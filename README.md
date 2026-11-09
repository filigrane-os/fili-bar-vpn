# vpn (fili-bar plugin)

WireGuard VPN without a daemon (`wg-quick`): the bar shows the active tunnel, a click toggles it. `bin/vpn [up [NAME] | down | status]` from a terminal.

```sh
fili-bar install https://github.com/filigrane-os/fili-bar-vpn
```

Tunnels are `/etc/wireguard/NAME.conf` (mode 600, root), downloaded from your provider; NAME is at most 15 characters.

## Personal data

None in this repository: the tunnel files stay in `/etc/wireguard`. `.gitignore` blocks `*.conf` and `*.key` as a safety net.
