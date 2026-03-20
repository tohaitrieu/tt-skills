# Phase 2: GSC Integration

## Overview
Tích hợp Google Search Console API để fetch và phân tích keywords.

**Priority**: High | **Status**: Pending

## Tasks

### 2.1 Service Account Setup

1. Google Cloud Console → Create project
2. Enable Search Console API
3. Create service account với role "Viewer"
4. Download JSON key → store in Infisical
5. Add service account email to GSC property

### 2.2 Fetch Keywords Script

**`scripts/fetch-keywords.ts`**

```typescript
interface KeywordData {
  keyword: string;
  clicks: number;
  impressions: number;
  ctr: number;
  position: number;
  url?: string;
}

// Fetch last 28 days data
// Filter: impressions > 10, position > 5 (opportunity zone)
// Sort by impressions DESC
// Return top 100 keywords
```

### 2.3 Opportunity Scoring

**`scripts/analyze-keywords.ts`**

Scoring formula:
```
Score = (Impressions × 0.4) + (CTR_potential × 0.3) + (Position_gap × 0.3)

Where:
- CTR_potential = Expected CTR at position 1 - Current CTR
- Position_gap = 10 - Current position (capped at 10)
```

Output categories:
| Score | Category | Action |
|-------|----------|--------|
| 80-100 | Quick Win | Optimize existing content |
| 60-79 | High Potential | Write new article |
| 40-59 | Medium | Add to backlog |
| <40 | Low | Monitor only |

### 2.4 Keyword Report Format

```markdown
# SEO Keyword Report - 2026-03-20

## Quick Wins (Optimize)
| Keyword | Position | Impressions | Score |
|---------|----------|-------------|-------|
| ... | ... | ... | ... |

## High Potential (Write New)
| Keyword | Position | Impressions | Score |
|---------|----------|-------------|-------|
| ... | ... | ... | ... |

## Topic Clusters
- **Trading**: keyword1, keyword2, keyword3
- **Crypto**: keyword4, keyword5
- **Education**: keyword6, keyword7
```

### 2.5 Caching Strategy

- Cache GSC data for 24h (avoid rate limits)
- Store in `~/.openclaw/workspace/.cache/gsc/`
- Auto-refresh on `/seo keywords --refresh`

## API Reference

```typescript
// GSC Search Analytics API
POST https://www.googleapis.com/webmasters/v3/sites/{siteUrl}/searchAnalytics/query

{
  "startDate": "2026-02-20",
  "endDate": "2026-03-20",
  "dimensions": ["query", "page"],
  "rowLimit": 1000,
  "dimensionFilterGroups": [{
    "filters": [{
      "dimension": "country",
      "expression": "vnm"
    }]
  }]
}
```

## Success Criteria

- [ ] GSC API authentication working
- [ ] Fetch keywords với full metrics
- [ ] Opportunity scoring accurate
- [ ] Keyword report generated
- [ ] Caching implemented

## Next Phase
→ [Phase 3: Content Pipeline](./phase-03-content-pipeline.md)
