# TT-Contents Structure

Repository: `~/Downloads/GitHub/TT-Contents/`

## Folder Mapping

| Content Type | Folder | Example |
|--------------|--------|---------|
| Crypto analysis | `analysis/crypto/` | Bitcoin weekly |
| Commodities | `analysis/commodities/` | Gold, Oil |
| Forex | `analysis/forex/` | EUR/USD |
| Stocks (VN) | `analysis/stocks/` | VN-Index |
| News | `analysis/news/` | Market updates |
| Educational | `education/{topic}/` | Trading guides |
| Posts | `content/posts/` | General articles |
| Memes | `content/memes/` | Social content |

## Filename Format

```
{slug}-{YYMMDD}.md
```

Examples:
- `bitcoin-weekly-260320.md`
- `gold-xauusd-analysis-260320.md`
- `huong-dan-trading-co-ban-260320.md`

## Frontmatter Required

```yaml
---
title: "Required"
slug: "required"
description: "Required for SEO"
keywords: ["required"]
category: "required"
author: "To Hai Trieu"
status: draft
created_at: "YYYY-MM-DD"
---
```

## Git Commit Format

```
content({category}): {brief description}
```

Examples:
- `content(crypto): add bitcoin weekly analysis`
- `content(education): add trading basics guide`
- `content(seo): add keyword-targeted article`
