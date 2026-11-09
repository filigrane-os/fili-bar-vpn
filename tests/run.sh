#!/bin/sh
# Tests of the vpn plugin: no network and no real account (the external commands are stubs). Usage: tests/run.sh
PLUGIN=vpn
. "$(dirname "$0")/common.sh"

common_checks
stub ip 'case "$*" in *"type wireguard up"*) printf "5: proton-fr: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1420\n" ;; esac'
check "vpn-state shows the active tunnel" 'in_env "$ROOT/bin/vpn-state" | grep -q "\"text\": \"proton-fr\""'
stub ip ''
check "vpn-state is hidden without a tunnel" '[ "$(in_env "$ROOT/bin/vpn-state")" = "{\"text\": \"\"}" ]'
stub ip 'case "$*" in *"type wireguard up"*) echo "5: proton-fr: <UP>" ;; *) echo "proton-fr UNKNOWN 10.2.0.2/32" ;; esac'
check "vpn status names the tunnel" 'in_env "$ROOT/bin/vpn" status | grep -q "proton-fr"'
stub ip ''
check "vpn status when off" 'in_env "$ROOT/bin/vpn" status | grep -qi "off"'
check "vpn refuses an unknown command" '! in_env "$ROOT/bin/vpn" nonsense 2> /dev/null'
stub sudo 'exit 0'
check "vpn up without any config explains where to put one" 'in_env "$ROOT/bin/vpn" up < /dev/null 2>&1 | grep -q "/etc/wireguard"'
check "no tunnel file in the repository" '[ -z "$(cd "$ROOT" && git ls-files "*.conf" "*.key" 2> /dev/null)" ]'

exit "$fail"
