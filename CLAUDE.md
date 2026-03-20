# CLAUDE.md

OpenClaw skills repository for totrieu.com workflows.

## Context

- **Platform**: OpenClaw Gateway on mac-mini
- **Skills Location**: `~/.openclaw/workspace/skills/`
- **Secrets**: Infisical at `vault.totrieu.com`

## Skill Format

Each skill follows ClawHub format:
```
skills/{name}/
├── SKILL.md        # Frontmatter + instructions
├── _meta.json      # {"slug": "name", "version": "1.0.0"}
├── references/     # Context docs for agent
├── scripts/        # Shell scripts (executable)
└── assets/         # Templates
```

## SKILL.md Template

```markdown
---
name: skill-name
description: "When to use this skill. Use when: (1) condition, (2) condition."
metadata:
  author: totrieu
  version: 1.0.0
---

# Skill Name

Brief description.

## Quick Reference
| Situation | Action |
|-----------|--------|

## Workflow
Step-by-step instructions for the agent.
```

## Scripts

- Use `#!/bin/bash` shebang
- Access Infisical: `curl http://localhost:8080/api/v3/secrets/KEY`
- Make executable: `chmod +x script.sh`

## Deployment

Push to main → GitHub Action syncs to mac-mini → Skills auto-loaded by OpenClaw.

## Related

- TT-Contents: `~/Downloads/GitHub/TT-Contents/` (content storage)
- Payload CMS: `cms.totrieu.com`
- Discord: OpenClaw Discord channel integration
