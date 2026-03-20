#!/bin/bash
# Fetch keywords from Google Search Console API
# Requires: GSC_SERVICE_ACCOUNT_JSON, GSC_SITE_URL in Infisical

set -e

INFISICAL_URL="http://localhost:8080/api/v3/secrets"

# Get secrets from Infisical
get_secret() {
  curl -s "${INFISICAL_URL}/$1" -H "Authorization: Bearer ${INFISICAL_TOKEN}" | jq -r '.secret.secretValue'
}

GSC_SITE_URL=$(get_secret "GSC_SITE_URL")
GSC_CREDENTIALS=$(get_secret "GSC_SERVICE_ACCOUNT_JSON")

# Calculate date range (last 28 days)
END_DATE=$(date +%Y-%m-%d)
START_DATE=$(date -v-28d +%Y-%m-%d 2>/dev/null || date -d "28 days ago" +%Y-%m-%d)

# Get access token
ACCESS_TOKEN=$(echo "$GSC_CREDENTIALS" | python3 -c "
import sys, json
from google.oauth2 import service_account
from google.auth.transport.requests import Request

creds_json = json.load(sys.stdin)
creds = service_account.Credentials.from_service_account_info(
    creds_json,
    scopes=['https://www.googleapis.com/auth/webmasters.readonly']
)
creds.refresh(Request())
print(creds.token)
")

# Fetch search analytics
curl -s "https://www.googleapis.com/webmasters/v3/sites/${GSC_SITE_URL}/searchAnalytics/query" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{
    \"startDate\": \"${START_DATE}\",
    \"endDate\": \"${END_DATE}\",
    \"dimensions\": [\"query\", \"page\"],
    \"rowLimit\": 500,
    \"dimensionFilterGroups\": [{
      \"filters\": [{
        \"dimension\": \"country\",
        \"expression\": \"vnm\"
      }]
    }]
  }" | jq '.rows | map({
    keyword: .keys[0],
    url: .keys[1],
    clicks: .clicks,
    impressions: .impressions,
    ctr: (.ctr * 100 | floor / 100),
    position: (.position | floor)
  }) | sort_by(-.impressions)'
