# Setup Secrets

## 1. Google Search Console

### Tạo Service Account
1. Vào [Google Cloud Console](https://console.cloud.google.com)
2. Create Project hoặc chọn existing
3. Enable **Search Console API**: APIs & Services → Enable APIs → Search "Search Console API" → Enable
4. Create Service Account: IAM & Admin → Service Accounts → Create
   - Name: `seo-bot`
   - Role: không cần
5. Create Key: Click service account → Keys → Add Key → JSON
6. Download JSON file

### Add to Search Console
1. Vào [Search Console](https://search.google.com/search-console)
2. Settings → Users and permissions → Add user
3. Paste service account email (từ JSON: `client_email`)
4. Permission: **Full**

### Add to Infisical
```bash
# Store entire JSON as secret
infisical secrets set GSC_SERVICE_ACCOUNT_JSON='{"type":"service_account",...}'
infisical secrets set GSC_SITE_URL='https://totrieu.com'
```

## 2. Payload CMS API Key

1. Login https://cms.totrieu.com/admin
2. Settings → API Keys → Create
3. Name: `seo-bot`
4. Permissions: Posts (create, read)
5. Copy key

```bash
infisical secrets set CMS_API_URL='https://cms.totrieu.com/api'
infisical secrets set CMS_API_KEY='your-key'
```

## 3. Infisical Token

1. Login https://vault.totrieu.com
2. Project Settings → Service Tokens → Create
3. Name: `seo-bot`
4. Environment: Production
5. Copy token

Store in mac-mini:
```bash
echo "INFISICAL_TOKEN=your-token" >> ~/.openclaw/.env
```

## Verify

```bash
# On mac-mini
cd ~/tt-skills/skills/seo-content/scripts
./fetch-gsc-keywords.sh
```
