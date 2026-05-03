#!/bin/bash
cd "$(dirname "$0")"

# Récupère l'IP locale
LOCAL_IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "introuvable")

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║         Holy Beauty Team Task                ║"
echo "╠══════════════════════════════════════════════╣"
echo "║  Local  → http://localhost:8765              ║"
echo "║  Réseau → http://$LOCAL_IP:8765"
echo "║                                              ║"
echo "║  Partage le lien Réseau à toute l'équipe !   ║"
echo "║  Ctrl+C pour arrêter                         ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

open "http://localhost:8765"
python3 server.py
