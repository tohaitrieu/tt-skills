# TT Skills

OpenClaw skills for totrieu.com automation workflows.

## Skills

| Skill | Description | Status |
|-------|-------------|--------|
| [seo-content](./skills/seo-content/) | SEO keyword analysis, content writing, CMS publishing | Planning |

## Installation

### Auto-deploy (Recommended)
Push to this repo triggers GitHub Action → deploys to mac-mini.

### Manual
```bash
# On mac-mini
git clone https://github.com/tohaitrieu/tt-skills.git ~/tt-skills
ln -s ~/tt-skills/skills/* ~/.openclaw/workspace/skills/
```

## Structure

```
tt-skills/
├── skills/                 # Individual OpenClaw skills
│   └── {skill-name}/
│       ├── SKILL.md       # Main definition
│       ├── _meta.json     # ClawHub metadata
│       ├── references/    # Context docs
│       ├── scripts/       # Executable scripts
│       └── assets/        # Templates
├── shared/                 # Shared utilities
│   ├── scripts/
│   └── templates/
└── .github/workflows/     # CI/CD
```

## Development

1. Create skill folder in `skills/`
2. Add `SKILL.md` with frontmatter
3. Add scripts, references as needed
4. Push → auto-deploys to mac-mini

## Secrets

Skills access secrets via Infisical at `vault.totrieu.com`.
