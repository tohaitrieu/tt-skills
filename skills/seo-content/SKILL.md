---
name: seo-content
description: "SEO content automation for totrieu.com. Use when: (1) User asks to analyze keywords or SEO opportunities, (2) User wants to write SEO article, (3) User needs content roadmap, (4) User wants to publish to CMS."
metadata:
  author: totrieu
  version: 1.0.0
---

# SEO Content Skill

Automates SEO content workflow: keyword analysis → article writing → CMS publishing.

## Quick Reference

| Situation | Action |
|-----------|--------|
| Analyze keywords | Run `scripts/fetch-gsc-keywords.sh`, score opportunities |
| Plan content | Prioritize by score, group by topic cluster |
| Write article | Use `references/content-templates.md`, Vietnamese với dấu |
| Save content | Git commit to TT-Contents repo |
| Notify admin | Discord message, wait approval |
| Publish | Run `scripts/publish-to-cms.sh` |

## Workflow

### 1. Keyword Analysis

```bash
./scripts/fetch-gsc-keywords.sh
```

Output JSON: keywords, impressions, clicks, CTR, position.

**Scoring Formula:**
```
Score = (Impressions × 0.4) + (CTR_potential × 0.3) + (Position_gap × 0.3)
```

| Score | Category | Action |
|-------|----------|--------|
| 80-100 | Quick Win | Optimize existing |
| 60-79 | High Potential | Write new article |
| 40-59 | Medium | Add to backlog |
| <40 | Low | Monitor only |

### 2. Content Planning

Group keywords by topic clusters:
- Trading (forex, crypto, stocks)
- Education (tutorials, guides)
- Analysis (market updates)

Create roadmap với priority order.

### 3. Research & Writing

Read `references/content-templates.md` for structure.

**Requirements:**
- Vietnamese với dấu đầy đủ
- 1500-2500 words
- Keyword density 1-2%
- Include internal links
- Practical examples from VN market

### SEO Quality Checklist (Yoast-based)

**Keyword Matching (Vietnamese):**
- Vietnamese KHÔNG hỗ trợ word form recognition
- Sử dụng **exact match** hoặc **contains**
- Keyword "trading forex" match: "trading forex", "về trading forex", "trading forex là gì"
- KHÔNG match: "trade forex", "forex trading" (khác thứ tự)

**Keyphrase Checks:**
| Criteria | Requirement | Weight |
|----------|-------------|--------|
| In Title | Keyword xuất hiện (exact/contains) | 15% |
| In Meta Description | 120-156 chars, có keyword | 10% |
| In Introduction | 100 từ đầu tiên | 10% |
| In Subheadings | Ít nhất 1 H2/H3 có keyword | 10% |
| Density | 1-2% (không quá 3%) | 15% |

**Readability:**
| Criteria | Requirement | Weight |
|----------|-------------|--------|
| Sentence Length | Avg ≤20 từ/câu | 10% |
| Paragraph Length | ≤150 từ/đoạn | 5% |
| Passive Voice | <10% câu bị động | 5% |
| Transition Words | >30% câu có từ chuyển tiếp | 5% |
| Subheading Distribution | Mỗi 300 từ có H2/H3 | 5% |

**Structure:**
| Criteria | Requirement | Weight |
|----------|-------------|--------|
| Text Length | 1500-2500 từ | 5% |
| Internal Links | ≥3 links | 5% |
| Images | Có alt text | 5% |

**Total Score:**
- 90-100: Excellent (Green)
- 70-89: Good (Light Green)
- 50-69: OK (Orange)
- <50: Needs Improvement (Red)

### 4. Save to TT-Contents

Folder mapping (see `references/tt-contents-structure.md`):
| Type | Folder |
|------|--------|
| Market analysis | `analysis/{category}/` |
| Educational | `education/{topic}/` |
| News | `content/posts/` |

```bash
cd ~/Downloads/GitHub/TT-Contents
git add .
git commit -m "content(seo): {keyword}"
git push
```

### 5. Discord Notification

Send to admin channel:
```
📝 New SEO Article Ready
Keyword: {keyword}
File: {filepath}
Preview: {github_url}

React ✅ to publish | ❌ to reject
```

### 6. Publish to CMS

On approval:
```bash
./scripts/publish-to-cms.sh "{filepath}"
```

Creates draft in Payload CMS.

## Discord Workflow

### Channels
| Channel | ID | Purpose |
|---------|-----|---------|
| Work | 1484382845744185364 | Tạo thread, cập nhật tiến độ |
| Report | 1480189760910786560 | Báo cáo hoàn thành |

### Flow
1. **Nhận task** → Tạo thread trong Work channel
2. **Trong thread**:
   - Cập nhật từng bước: "🔍 Đang phân tích keywords..."
   - Thảo luận nếu cần input
   - Đính kèm draft để review
3. **Hoàn thành** → Post summary tại Report channel với link thread

### Thread Format
```
📋 SEO Task: {keyword}
Status: 🟡 In Progress

Progress:
- ✅ Keyword analysis
- ✅ Outline created
- 🔄 Writing article...
- ⏳ Review pending
- ⏳ Publish to CMS
```

### Completion Report (Report channel)
```
✅ SEO Task Complete

Keyword: {keyword}
Article: {title}
File: {github_url}
Thread: {thread_url}

Status: Draft published to CMS
```

## Integration

| Service | Method |
|---------|--------|
| GSC API | `scripts/fetch-gsc-keywords.sh` |
| Infisical | `http://localhost:8080/api/v3/secrets/` |
| Discord Work | Channel 1484382845744185364 (threads) |
| Discord Report | Channel 1480189760910786560 (completion) |
| Payload CMS | `scripts/publish-to-cms.sh` |
| TT-Contents | Git operations |
