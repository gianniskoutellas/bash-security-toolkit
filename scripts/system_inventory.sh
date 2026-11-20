#!/usr/bin/env bash

# system_inventory.sh
# Collects basic Linux system and security-relevant inventory information.
# Intended for authorised lab environments only.

set -euo pipefail

OUTPUT_DIR="../output"
OUTPUT_FILE="${OUTPUT_DIR}/system_inventory_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$OUTPUT_DIR"

{
    echo "========================================"
    echo " LINUX SYSTEM INVENTORY"
    echo " Generated: $(date)"
    echo "========================================"

    echo
    echo "[HOSTNAME]"
    hostname

    echo
    echo "[OPERATING SYSTEM]"
    cat /etc/os-release

    echo
    echo "[KERNEL]"
    uname -a

    echo
    echo "[UPTIME]"
    uptime

    echo
    echo "[CPU]"
    lscpu | grep -E "Model name|CPU\(s\)|Architecture"

    echo
    echo "[MEMORY]"
    free -h

    echo
    echo "[DISK USAGE]"
    df -h

    echo
    echo "[NETWORK INTERFACES]"
    ip -brief address

    echo
    echo "[LISTENING PORTS]"
    ss -tulnp

    echo
    echo "[INSTALLED PACKAGES COUNT]"
    if command -v dpkg >/dev/null 2>&1; then
        dpkg -l | grep -c "^ii"
    elif command -v rpm >/dev/null 2>&1; then
        rpm -qa | wc -l
    else
        echo "Package manager not detected"
    fi

    echo
    echo "[RECENT LOGINS]"
    last -n 10 2>/dev/null || echo "last command unavailable"

} > "$OUTPUT_FILE"

echo "Inventory report saved to: $OUTPUT_FILE"
