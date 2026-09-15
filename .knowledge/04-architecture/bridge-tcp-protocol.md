---
id: KB-04-bridge-tcp-protocol
title: "TCP Bridge Protocol"
category: architecture
subcategory: protocol
tags: [bridge, tcp, protocol, json-rpc, ipc]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-04-separate-process-architecture
  - KB-04-system-architecture
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "TCP bridge protocol between MCP server and QGIS plugin"
  key_facts:
    - "TCP localhost:9876"
    - "JSON-RPC request/response"
    - "MCP server is TCP client, QGIS bridge is TCP server"
    - "Trust boundary: same user, same machine"
    - "No authentication needed"
  common_questions:
    - "How do MCP server and QGIS communicate?"
    - "What is the protocol format?"
    - "Is the connection secure?"
---

# TCP Bridge Protocol

## Overview

The TCP bridge connects the standalone MCP server process to the QGIS bridge plugin over localhost.

## Connection Details

| Property | Value |
|---|---|
| Transport | TCP |
| Host | localhost (127.0.0.1) |
| Port | 9876 (configurable) |
| Protocol | JSON-RPC 2.0 (simplified) |
| Encoding | UTF-8 JSON, newline-delimited |
| Auth | None (localhost trust) |
| Client | MCP server process |
| Server | QGIS bridge plugin |

## Message Format

### Request (MCP Server → QGIS Bridge)

```json
{
  "jsonrpc": "2.0",
  "id": "req-001",
  "method": "execute_tool",
  "params": {
    "tool_name": "buffer",
    "parameters": {
      "input_layer": "roads",
      "distance": 500.0,
      "segments": 5,
      "dissolve": false,
      "output_layer": "roads_buffer"
    }
  }
}
```

### Response (QGIS Bridge → MCP Server)

**Success:**
```json
{
  "jsonrpc": "2.0",
  "id": "req-001",
  "result": {
    "output_layer": "roads_buffer",
    "input_layer": "roads",
    "feature_count": 1250,
    "crs": "EPSG:32633",
    "geometry_type": "Polygon",
    "distance": 500.0,
    "dissolved": false
  }
}
```

**Error:**
```json
{
  "jsonrpc": "2.0",
  "id": "req-001",
  "error": {
    "code": -32602,
    "message": "Layer 'roads' not found in project",
    "data": {
      "available_layers": ["rivers", "buildings", "study_area"]
    }
  }
}
```

## Connection Lifecycle

```
1. QGIS bridge starts TCP server on :9876
2. MCP server connects as TCP client
3. MCP server sends tool execution requests
4. QGIS bridge executes via PyQGIS on main thread
5. QGIS bridge returns JSON result
6. Connection persists for duration of task
7. MCP server disconnects after task completion
```

## Thread Safety

**Critical:** PyQGIS operations MUST run on the QGIS main thread.

```python
# QGIS Bridge (plugin.py)
class BridgeServer(QObject):
    """TCP server that dispatches to QGIS main thread."""

    tool_request = pyqtSignal(dict)  # Signal for main thread

    def __init__(self):
        self.tcp_server = QTcpServer()
        self.tcp_server.listen(QHostAddress.LocalHost, 9876)
        self.tcp_server.newConnection.connect(self._on_connection)
        self.tool_request.connect(self._execute_on_main_thread)

    def _on_connection(self):
        """Handle new TCP connection from MCP server."""
        socket = self.tcp_server.nextPendingConnection()
        socket.readyRead.connect(lambda: self._read_request(socket))

    def _read_request(self, socket):
        """Read JSON request and emit signal for main thread."""
        data = socket.readAll().data().decode()
        request = json.loads(data)
        self.tool_request.emit(request)  # Qt signal → main thread

    @pyqtSlot(dict)
    def _execute_on_main_thread(self, request):
        """Execute tool on QGIS main thread (safe for PyQGIS)."""
        result = self._dispatch_tool(request)
        self._send_response(request["id"], result)
```

## Security

- **Localhost only:** `QHostAddress.LocalHost` prevents external connections
- **Same user:** Both processes run as same OS user
- **No auth needed:** OS-level access control sufficient
- **Workspace scoped:** Bridge only accesses files in benchmark workspace

## Error Codes

| Code | Meaning |
|---|---|
| -32600 | Invalid request |
| -32601 | Tool not found |
| -32602 | Invalid parameters |
| -32603 | Internal error (PyQGIS exception) |
| -32000 | Layer not found |
| -32001 | CRS mismatch |
| -32002 | Output layer already exists |

## Related Files

- [KB-04-separate-process-architecture](separate-process-architecture.md) — Why separate
- [KB-06-bridge-implementation](../06-implementation/bridge-implementation.md) — Code details
- [KB-04-qt-worker-pattern](qt-worker-pattern.md) — Thread safety
