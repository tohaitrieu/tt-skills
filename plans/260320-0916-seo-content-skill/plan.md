# SEO Content Automation Skill (OpenClaw)

## Overview
OpenClaw skill tự động hóa quy trình SEO content: từ phân tích keyword → viết bài → publish.

**Status**: Planning
**Priority**: High
**Platform**: OpenClaw Gateway on Mac Mini
**Location**: `~/.openclaw/workspace/skills/seo-content/`

## Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│  User: "Phân tích keywords SEO"                                     │
│         ↓                                                           │
│  OpenClaw loads SKILL.md → Agent executes workflow                  │
├─────────────────────────────────────────────────────────────────────┤
│  Step 1: Fetch GSC Data                                             │
│  └── scripts/fetch-gsc-keywords.sh → JSON output                    │
├─────────────────────────────────────────────────────────────────────┤
│  Step 2: Analyze & Score                                            │
│  └── Agent analyzes data, scores opportunities                      │
├─────────────────────────────────────────────────────────────────────┤
│  Step 3: Research & Write                                           │
│  └── Agent uses references/ for templates, writes article           │
├─────────────────────────────────────────────────────────────────────┤
│  Step 4: Save to TT-Contents                                        │
│  └── Git commit & push to repo                                      │
├─────────────────────────────────────────────────────────────────────┤
│  Step 5: Notify Admin                                               │
│  └── Discord message → Wait for approval                            │
├─────────────────────────────────────────────────────────────────────┤
│  Step 6: Publish Draft                                              │
│  └── scripts/publish-to-cms.sh → Payload CMS API                    │
└─────────────────────────────────────────────────────────────────────┘
```

## Phases

- [Phase 1: Core Infrastructure](./phase-01-core-infrastructure.md)
- [Phase 2: GSC Integration](./phase-02-gsc-integration.md)
- [Phase 3: Content Pipeline](./phase-03-content-pipeline.md)
- [Phase 4: Publishing Flow](./phase-04-publishing-flow.md)

## Dependencies

| Dependency | Purpose | Status |
|------------|---------|--------|
| Google Search Console API | Keyword data | Need service account |
| Discord Channel | Notifications via OpenClaw | Existing |
| Payload CMS API | Draft publishing | API ready |
| TT-Contents repo | Content storage | Ready |
| Infisical | Secrets management | Running on mac-mini |

## OpenClaw Skill Structure

```
~/.openclaw/workspace/skills/seo-content/
├── SKILL.md                    # Main skill definition (frontmatter + instructions)
├── _meta.json                  # ClawHub metadata
├── references/
│   ├── gsc-api.md             # GSC API reference
│   ├── content-templates.md    # Article templates
│   ├── cms-api.md             # Payload CMS endpoints
│   └── tt-contents-structure.md # Folder mapping
├── scripts/
│   ├── fetch-gsc-keywords.sh  # Fetch from GSC via API
│   ├── analyze-opportunities.sh # Score keywords
│   └── publish-to-cms.sh      # Publish draft to CMS
├── hooks/
│   └── openclaw/
│       └── handler.ts         # Session start reminder
└── assets/
    ├── seo-article-template.md
    └── keyword-report-template.md
```

## Success Criteria

1. Fetch top 100 keywords from GSC với metrics đầy đủ
2. Score và prioritize keywords chính xác
3. Generate SEO-optimized articles (1500-2500 words)
4. Auto-save đúng folder trong TT-Contents
5. Discord notification với approval buttons
6. Publish draft to CMS khi approved

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| GSC API rate limits | Medium | Implement caching, batch requests |
| Content quality | High | Human review before publish |
| Discord bot downtime | Low | Fallback to email notification |
| CMS API changes | Medium | Version lock, error handling |

## Next Steps

1. [ ] Setup Google Search Console service account
2. [ ] Create skill scaffold
3. [ ] Implement Phase 1 (core infrastructure)
4. [ ] Test GSC integration
5. [ ] Build content pipeline
