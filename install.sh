#!/bin/sh
# First-run setup, run by `fili-bar install` / `fili-bar setup` / `fili-bar sync`. Idempotent; asks questions only on a terminal.
# Secrets never go in this folder: they go to the keyring or to a file under ~/.config.
set -u
here="$(cd "$(dirname "$0")" && pwd)"
opts="${FILI_BAR_OPTIONS:-$HOME/.config/filigrane/bar/vpn.toml}"
tty=0; [ -t 0 ] && tty=1
# Options file: copy the example once, never overwrite
if [ ! -e "$opts" ] && [ -f "$here/config.example.toml" ]; then
    mkdir -p "$(dirname "$opts")" && cp "$here/config.example.toml" "$opts" && echo "options: $opts (edit it to change the defaults)"
fi
command -v wg-quick >/dev/null 2>&1 || echo "wg-quick is missing (sudo xbps-install wireguard-tools)"
# /etc/wireguard is readable by root only: do not guess, just say where the tunnels go
echo "tunnels: sudo install -m 600 NAME.conf /etc/wireguard/NAME.conf (NAME: 15 characters at most, from your provider's account page)"
