# Phase 1: Core Infrastructure (OpenClaw Skill)

## Overview
Setup OpenClaw skill scaffold theo format clawhub.

**Priority**: High | **Status**: Pending
**Location**: `~/.openclaw/workspace/skills/seo-content/` (on mac-mini)

## Tasks

### 1.1 Create Skill Scaffold (on mac-mini)
```bash
ssh mac-mini-remote "mkdir -p ~/.openclaw/workspace/skills/seo-content/{references,scripts,hooks/openclaw,assets}"
```

### 1.2 SKILL.md Definition

```markdown
---
name: seo-content
description: "SEO content automation for totrieu.com. Use when: (1) User asks to analyze keywords or SEO opportunities, (2) User wants to write SEO article, (3) User needs content roadmap, (4) User wants to publish to CMS. Integrates with GSC, TT-Contents repo, Discord, and Payload CMS."
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
| Write article | Use `references/content-templates.md`, save to TT-Contents |
| Publish | Notify Discord, wait approval, run `scripts/publish-to-cms.sh` |

## Workflow

### 1. Keyword Analysis
```bash
# Fetch GSC data (uses Infisical for secrets)
./scripts/fetch-gsc-keywords.sh
```
Output: JSON with keywords, impressions, clicks, CTR, position

### 2. Opportunity Scoring
Score = (Impressions × 0.4) + (CTR_potential × 0.3) + (Position_gap × 0.3)
- **80-100**: Quick Win (optimize existing)
- **60-79**: High Potential (write new)
- **40-59**: Medium (backlog)
- **<40**: Low (monitor)

### 3. Content Writing
- Read `references/content-templates.md` for article structure
- Read `references/tt-contents-structure.md` for folder mapping
- Write Vietnamese với dấu đầy đủ
- Target 1500-2500 words

### 4. Save & Notify
- Save to `~/Downloads/GitHub/TT-Contents/{folder}/`
- Git commit & push
- Send Discord message to admin channel
- Wait for approval reaction

### 5. Publish
- On approval: Run `scripts/publish-to-cms.sh`
- Creates draft in Payload CMS

## Integration Points

| Service | Access Method |
|---------|---------------|
| GSC API | Infisical → `GSC_*` secrets |
| Discord | OpenClaw Discord channel |
| Payload CMS | Infisical → `CMS_API_KEY` |
| TT-Contents | Git clone on mac-mini |
```

### 1.3 _meta.json

```json
{
  "slug": "seo-content",
  "version": "1.0.0",
  "author": "totrieu"
}
```

### 1.4 Secrets in Infisical

Add to Infisical (vault.totrieu.com):
| Secret | Purpose |
|--------|---------|
| `GSC_SERVICE_ACCOUNT_JSON` | Google Search Console auth |
| `GSC_SITE_URL` | `https://totrieu.com` |
| `CMS_API_URL` | `https://cms.totrieu.com/api` |
| `CMS_API_KEY` | Payload CMS auth |

### 1.5 Script: Fetch Secrets from Infisical

**`scripts/get-secret.sh`**
```bash
#!/bin/bash
# Fetch secret from Infisical
SECRET_NAME=$1
curl -s "http://localhost:8080/api/v3/secrets/${SECRET_NAME}" \
  -H "Authorization: Bearer ${INFISICAL_TOKEN}" | jq -r '.secret.secretValue'
```

## Success Criteria

- [ ] Skill folder created on mac-mini
- [ ] SKILL.md with clear workflow
- [ ] _meta.json for versioning
- [ ] Secrets documented in Infisical
- [ ] get-secret.sh working

## Next Phase
→ [Phase 2: GSC Integration](./phase-02-gsc-integration.md)
