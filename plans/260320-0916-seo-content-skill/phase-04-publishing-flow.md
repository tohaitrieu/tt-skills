# Phase 4: Publishing Flow

## Overview
Discord notification, admin approval, và Payload CMS publishing.

**Priority**: High | **Status**: Pending

## Tasks

### 4.1 Discord Notification

**Webhook Message Format:**

```json
{
  "embeds": [{
    "title": "📝 New SEO Article Ready",
    "description": "Article cần review trước khi publish",
    "color": 5814783,
    "fields": [
      {"name": "Keyword", "value": "{keyword}", "inline": true},
      {"name": "Word Count", "value": "{count}", "inline": true},
      {"name": "Category", "value": "{category}", "inline": true},
      {"name": "File", "value": "`{filepath}`"},
      {"name": "Preview", "value": "[View on GitHub]({github_url})"}
    ],
    "footer": {"text": "Reply ✅ to publish | ❌ to reject"}
  }],
  "components": [{
    "type": 1,
    "components": [
      {"type": 2, "style": 3, "label": "Publish", "custom_id": "seo_publish_{id}"},
      {"type": 2, "style": 4, "label": "Reject", "custom_id": "seo_reject_{id}"},
      {"type": 2, "style": 2, "label": "Edit First", "custom_id": "seo_edit_{id}"}
    ]
  }]
}
```

### 4.2 Approval Tracking

Store pending approvals:
```
~/.openclaw/workspace/.cache/seo/pending/
└── {article_id}.json
    {
      "id": "uuid",
      "keyword": "...",
      "filepath": "...",
      "created_at": "...",
      "discord_message_id": "...",
      "status": "pending|approved|rejected"
    }
```

### 4.3 Discord Bot Listener

OpenClaw có thể dùng Discord channel để listen:
- Monitor reactions hoặc button clicks
- Trigger publish khi admin approve
- Hoặc dùng `/seo approve {id}` command

### 4.4 Payload CMS Integration

**`scripts/publish-draft.ts`**

```typescript
// Payload CMS API endpoint
POST https://cms.totrieu.com/api/posts

// Headers
Authorization: Bearer {CMS_API_KEY}
Content-Type: application/json

// Body
{
  "title": "{title}",
  "slug": "{slug}",
  "content": "{markdown_content}",
  "excerpt": "{meta_description}",
  "category": "{category_id}",
  "tags": ["{tag_ids}"],
  "status": "draft",
  "author": "{author_id}",
  "seo": {
    "title": "{seo_title}",
    "description": "{meta_description}",
    "keywords": "{keywords}"
  },
  "publishedAt": null
}
```

### 4.5 Post-Publish Actions

Sau khi publish thành công:
1. Update Discord message → "✅ Published as draft"
2. Update pending status → "approved"
3. Log to `.learnings/` nếu có issues
4. Optional: Notify via Telegram

### 4.6 Error Handling

| Error | Action |
|-------|--------|
| CMS API fail | Retry 3x, then notify admin |
| Invalid content | Return validation errors |
| Duplicate slug | Append timestamp to slug |
| Auth expired | Refresh token, retry |

## Workflow Diagram

```
Article Ready
     │
     ▼
Discord Notification ──────────────────┐
     │                                 │
     ▼                                 ▼
Admin Reviews ◄─── Edit Request ◄─── Reject
     │
     ▼
  Approve
     │
     ▼
Publish to CMS (draft)
     │
     ▼
Update Discord ✅
     │
     ▼
  Complete
```

## Commands Summary

| Command | Description |
|---------|-------------|
| `/seo keywords` | Analyze GSC keywords |
| `/seo plan` | Create content roadmap |
| `/seo write <keyword>` | Write article |
| `/seo status` | Check pending articles |
| `/seo approve <id>` | Approve & publish |
| `/seo reject <id>` | Reject article |

## Success Criteria

- [ ] Discord webhook sends formatted message
- [ ] Approval buttons work
- [ ] CMS API publishes draft correctly
- [ ] Status tracking accurate
- [ ] Error handling robust

## Security Notes

- CMS API key: Store in Infisical, never in code
- Discord webhook: Restricted channel
- GSC credentials: Service account only
