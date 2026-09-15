---
id: KB-03-statistical-tests
title: "Statistical Tests and Analysis Plan"
category: metrics
subcategory: statistics
tags: [statistics, anova, mcnemar, chi-square, bootstrap, cliffs-delta, bonferroni]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3, 12]
related:
  - KB-03-metrics-overview
  - KB-00-research-questions
  - KB-01-han-et-al-2026
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Complete statistical analysis plan with tests per RQ"
  key_facts:
    - "α = 0.05, Bonferroni α_adj = 0.0083"
    - "Bootstrap 95% CIs on all primary metrics"
    - "Cliff's delta for effect sizes"
    - "Following GISclaw (Han et al.) precedent"
    - "Libraries: scipy, statsmodels"
  common_questions:
    - "What statistical tests are used?"
    - "Why Bonferroni correction?"
    - "What effect sizes are reported?"
---

# Statistical Tests and Analysis Plan

## Significance Thresholds

| Parameter | Value | Rationale |
|---|---|---|
| α (nominal) | 0.05 | Standard |
| α_adj (Bonferroni) | 0.05 / 6 = 0.0083 | 6 primary RQs (PB1-PB5, PB7) |
| CI level | 95% | Standard |
| Bootstrap resamples | 10,000 | Sufficient precision |

## Tests by Research Question

### PB1: Overall Effectiveness

| Test | Variables | Library |
|---|---|---|
| One-way ANOVA | Paradigm (3) → TSR | `scipy.stats.f_oneway` |
| Post-hoc Tukey HSD | Pairwise paradigm TSR | `scipy.stats.tukey_hsd` |
| Mann-Whitney U | Paradigm → OQS | `scipy.stats.mannwhitneyu` |
| Bootstrap CI | TSR per paradigm | `scipy.stats.bootstrap` |

### PB2: Difficulty Moderation

| Test | Variables | Library |
|---|---|---|
| Two-way ANOVA | Paradigm × Difficulty → PCS | `statsmodels.api.ols` |
| Interaction plot | Paradigm × Difficulty | `seaborn.catplot` |
| Post-hoc Tukey | Per difficulty tier | `scipy.stats.tukey_hsd` |

### PB3: Agent-Paradigm Interaction

| Test | Variables | Library |
|---|---|---|
| Two-way ANOVA | Agent × Paradigm → TSR | `statsmodels.api.ols` |
| Cliff's delta | Pairwise agent comparisons | `cliffs_delta` (custom) |
| Heatmap | Agent × Paradigm × TSR | `seaborn.heatmap` |

### PB4: Execution Behavior

| Test | Variables | Library |
|---|---|---|
| Chi-square | Paradigm → Error type distribution | `scipy.stats.chi2_contingency` |
| McNemar | Paired paradigm → ED | `statsmodels.stats.contingency.mcnemar` |
| Mann-Whitney U | Paradigm → PEA | `scipy.stats.mannwhitneyu` |
| Wilcoxon signed-rank | Within-agent paradigm PEA | `scipy.stats.wilcoxon` |

### PB5: Security

| Test | Variables | Library |
|---|---|---|
| Descriptive | Attack surface comparison | Manual |
| Fisher's exact | Paradigm → ADV pass/fail | `scipy.stats.fisher_exact` |
| Qualitative | Attack surface analysis | Narrative |

### PB6: Information Fidelity (Optional)

| Test | Variables | Library |
|---|---|---|
| Spearman correlation | Chain length → LCP | `scipy.stats.spearmanr` |
| Linear regression | Chain length → TSR | `statsmodels.api.OLS` |

### PB7: Tool Count Effect

| Test | Variables | Library |
|---|---|---|
| Paired t-test | MCP-5 vs MCP-15 → TSR per task | `scipy.stats.ttest_rel` |
| Paired t-test | MCP-5 vs MCP-15 → TSA | `scipy.stats.ttest_rel` |
| Paired t-test | MCP-5 vs MCP-15 → ED | `scipy.stats.ttest_rel` |
| Bootstrap CI | TSR difference (MCP-5 - MCP-15) | `scipy.stats.bootstrap` |

## Effect Size Reporting

| Effect Size | When Used | Interpretation |
|---|---|---|
| Cohen's d | t-tests | 0.2=small, 0.5=medium, 0.8=large |
| Cliff's delta | Non-parametric comparisons | <0.147=negligible, 0.147-0.33=small, 0.33-0.474=medium, >0.474=large |
| η² (eta-squared) | ANOVA | 0.01=small, 0.06=medium, 0.14=large |
| Cramér's V | Chi-square | 0.1=small, 0.3=medium, 0.5=large |

## Bootstrap CI Implementation

```python
from scipy.stats import bootstrap
import numpy as np

def compute_bootstrap_ci(data, statistic=np.mean, n_resamples=10000):
    result = bootstrap(
        (data,),
        statistic,
        n_resamples=n_resamples,
        confidence_level=0.95,
        method='BCa'
    )
    return result.confidence_interval.low, result.confidence_interval.high
```

## Cliff's Delta Implementation

```python
def cliffs_delta(x, y):
    """Non-parametric effect size for two independent samples."""
    n1, n2 = len(x), len(y)
    diff = 0
    for xi in x:
        for yj in y:
            if xi > yj:
                diff += 1
            elif xi < yj:
                diff -= 1
    return diff / (n1 * n2)
```

## Software Stack

| Library | Version | Purpose |
|---|---|---|
| scipy | ≥1.14 | Core statistical tests |
| statsmodels | ≥0.14 | ANOVA, regression |
| polars | ≥1.0 | Data manipulation |
| duckdb | ≥1.1 | JSONL queries |
| matplotlib | ≥3.9 | Plots |
| seaborn | ≥0.13 | Statistical visualizations |

## Precedent

Following GISclaw (Han et al., 2026) which reported:
- 1,800 controlled experiments
- Bootstrap 95% CIs
- Paired Wilcoxon tests
- Cliff's delta effect sizes

## Related Files

- [KB-00-research-questions](../00-meta/research-questions.md) — RQ definitions
- [KB-01-han-et-al-2026](../01-literature/papers/han-et-al-2026.md) — Statistical precedent
- [KB-06-statistics-implementation](../06-implementation/statistics-implementation.md) — Code
