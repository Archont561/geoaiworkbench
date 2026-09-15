---
id: KB-10-workspace-scoping
title: "Workspace Scoping"
category: security
subcategory: detail
tags: [security, workspace,scoping]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14, 15]
related:
  - KB-10-security-overview
  - Agent workspace: input/ (read)
  - output/ (write)
  - scripts/ (write); no access to system files; no access to other tasks' data; reference outputs read-only (chmod 444); Docker --network=none for CodeGen; TCP bridge localhost only|KB-04-bridge-tcp-protocol
  - KB-02-black-box-constraint
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Workspace Scoping"
  key_facts:
    - "Workspace Scoping"
  common_questions:
    - "How is Workspace Scoping handled?"
---

# Workspace Scoping

## Details

File system access restrictions

## Related Files

- KB-10-security-overview
- Agent workspace: input/ (read)
- output/ (write)
- scripts/ (write); no access to system files; no access to other tasks' data; reference outputs read-only (chmod 444); Docker --network=none for CodeGen; TCP bridge localhost only|KB-04-bridge-tcp-protocol
- KB-02-black-box-constraint
