# vpn (fili-bar plugin)

WireGuard VPN without a daemon (`wg-quick`): the bar shows the active tunnel, a click toggles it. `bin/vpn [up [NAME] | down | status]` from a terminal.

```sh
fili-bar install https://github.com/filigrane-os/fili-bar-vpn
```

Tunnels are `/etc/wireguard/NAME.conf` (mode 600, root), downloaded from your provider; NAME is at most 15 characters.

`fili-bar install` also runs `install.sh`: it creates your options file from `config.example.toml`, asks for what is missing (credentials go to the keyring or to a file under `~/.config`, never to this folder) and prints what is left to do. Run it again with `fili-bar setup vpn`; it is safe to repeat.

## Packages

Declared in `module.toml` (`packages`), installed by `fili-bar install --yes`: `wireguard-tools` (no daemon).

## Personal data

None in this repository: the tunnel files stay in `/etc/wireguard`. `.gitignore` blocks `*.conf` and `*.key` as a safety net.

## Tests

```sh
sh tests/run.sh
```

No network and no real account: the external commands (`notify-send`, `secret-tool`, `rclone`, `ip`...) are stubs and `HOME` is a temporary folder. The checks every plugin passes (manifest, scripts parse, no personal data in the repository, `install.sh` idempotent) are in `tests/common.sh`; GitHub Actions runs them on each push.
