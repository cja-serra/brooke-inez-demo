#!/bin/bash
# Deploy: GitHub → Vercel (auto) → Hostinger FTP

cd /Users/throttle/demos/brooke-inez

# 1. Push to GitHub (Vercel auto-deploys from here)
git add -A
git commit -m "${1:-update site}"
git push

# 2. FTP to Hostinger (live site)
lftp -u u771303799,Cjagroup.us1 ftp://151.106.96.170 <<'EOF'
set ftp:ssl-allow no
put /Users/throttle/demos/brooke-inez/index.html -o /domains/brookeinezphotography.com/public_html/index.html
mirror -R /Users/throttle/demos/brooke-inez/images /domains/brookeinezphotography.com/public_html/images
quit
EOF

echo "Done — GitHub + Vercel + Hostinger all updated."
