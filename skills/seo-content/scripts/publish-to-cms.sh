#!/bin/bash
# Publish article to Payload CMS as draft
# Usage: ./publish-to-cms.sh "/path/to/article.md"

set -e

ARTICLE_PATH="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/../../../.env"

if [ -z "$ARTICLE_PATH" ]; then
  echo "Usage: ./publish-to-cms.sh <article-path>"
  exit 1
fi

# Load .env
if [ -f "$ENV_FILE" ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs)
fi

CMS_API_URL="${CMS_API_URL:-https://cms.totrieu.com/api}"

# Parse frontmatter and content
parse_article() {
  python3 << EOF
import sys
import re
import json

with open("$ARTICLE_PATH", 'r') as f:
    content = f.read()

# Extract frontmatter
fm_match = re.match(r'^---\n(.*?)\n---\n(.*)$', content, re.DOTALL)
if not fm_match:
    print(json.dumps({"error": "No frontmatter found"}))
    sys.exit(1)

import yaml
frontmatter = yaml.safe_load(fm_match.group(1))
body = fm_match.group(2).strip()

print(json.dumps({
    "title": frontmatter.get("title", "Untitled"),
    "slug": frontmatter.get("slug", ""),
    "description": frontmatter.get("description", ""),
    "keywords": frontmatter.get("keywords", []),
    "category": frontmatter.get("category", ""),
    "content": body
}))
EOF
}

ARTICLE_DATA=$(parse_article)

# Create draft in Payload CMS
curl -s -X POST "${CMS_API_URL}/posts" \
  -H "Authorization: Bearer ${CMS_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$(echo "$ARTICLE_DATA" | jq '{
    title: .title,
    slug: .slug,
    content: .content,
    excerpt: .description,
    status: "draft",
    seo: {
      title: .title,
      description: .description,
      keywords: (.keywords | join(", "))
    }
  }')"

echo "Draft published to CMS"
