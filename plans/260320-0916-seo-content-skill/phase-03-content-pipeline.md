# Phase 3: Content Pipeline

## Overview
Research, outline generation, và AI-assisted article writing.

**Priority**: High | **Status**: Pending

## Tasks

### 3.1 SERP Analysis

**`scripts/serp-analyze.ts`**

Cho mỗi target keyword:
1. Fetch top 10 Google results (via SerpAPI hoặc scraping)
2. Extract:
   - Title patterns
   - H2/H3 headings
   - Word count
   - Content type (guide, list, review, etc.)
3. Identify content gaps

### 3.2 Outline Generation

**`scripts/generate-outline.ts`**

Input: keyword + SERP analysis
Output:
```markdown
# [SEO Title với keyword]

## Meta Description
[150-160 chars, include keyword]

## Outline
1. Introduction (hook + keyword)
2. [H2 based on SERP analysis]
   - [H3 subtopic]
   - [H3 subtopic]
3. [H2 competitor gap topic]
4. [H2 unique angle]
5. Conclusion + CTA

## Target
- Word count: 1500-2500
- Keywords: primary, secondary1, secondary2
- Internal links: [suggest 3-5 related posts]
```

### 3.3 Article Writing

**Prompt Template**: `assets/prompt-templates/seo-article.md`

```markdown
Bạn là SEO content writer chuyên nghiệp cho totrieu.com.

## Context
- Website: Trading & Finance education (Vietnamese)
- Audience: Retail traders, beginners to intermediate
- Tone: Professional nhưng dễ hiểu, không academic

## Task
Viết bài SEO cho keyword: {keyword}

## Requirements
- Follow outline below
- 1500-2500 từ
- Include keyword tự nhiên (density 1-2%)
- Vietnamese với dấu đầy đủ
- Dùng ví dụ thực tế từ thị trường VN
- Include internal links: {internal_links}

## Outline
{outline}

## Format
- Markdown với proper headings
- Short paragraphs (2-3 sentences)
- Bullet points cho lists
- Bold key concepts
```

### 3.4 Content Storage (TT-Contents)

Folder mapping:
| Content Type | Folder |
|--------------|--------|
| Market analysis | `analysis/{category}/` |
| Educational | `education/{topic}/` |
| News/Updates | `content/posts/` |
| Partner content | `partners/{partner}/` |

Filename format: `{slug}-{YYMMDD}.md`

### 3.5 Frontmatter Template

```yaml
---
title: "{title}"
slug: "{slug}"
description: "{meta_description}"
keywords: ["{primary}", "{secondary1}", "{secondary2}"]
category: "{category}"
author: "To Hai Trieu"
status: draft
created_at: "{date}"
target_publish: "{date + 3 days}"
seo_score: {score}
word_count: {count}
---
```

## TT-Contents Integration

```typescript
// Save article to correct folder
const savePath = `~/Downloads/GitHub/TT-Contents/${folder}/${filename}.md`;

// Git operations
git add .
git commit -m "content(seo): add article - {keyword}"
git push origin main
```

## Success Criteria

- [ ] SERP analysis working
- [ ] Outline generator produces quality outlines
- [ ] Article writer follows SEO best practices
- [ ] Content saved to correct TT-Contents folder
- [ ] Git auto-commit and push

## Next Phase
→ [Phase 4: Publishing Flow](./phase-04-publishing-flow.md)
