#!/bin/sh
set -e

if [ -n "$TUNNEL_TOKEN" ]; then
    echo "==> Cloudflared: menjalankan tunnel menggunakan TUNNEL_TOKEN"
    exec cloudflared --no-autoupdate tunnel run --token "$TUNNEL_TOKEN"
else
    echo "==> Cloudflared: TUNNEL_TOKEN tidak diset."
    echo "    Menjalankan Quick Tunnel (trycloudflare.com)."
    echo "    Salin URL https://xxx.trycloudflare.com dari log di bawah ini:"
    exec cloudflared --no-autoupdate tunnel --url http://app:80
fi