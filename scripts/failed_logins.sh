#!/usr/bin/env bash

# failed_logins.sh
# Identifies failed authentication attempts from system logs.
# Intended for authorised lab environments only.

set -euo pipefail

OUTPUT_DIR="../output"
OUTPUT_FILE="${OUTPUT_DIR}/failed_logins_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$OUTPUT_DIR"

{
    echo "========================================"
    echo " FAILED AUTHENTICATION ATTEMPTS"
    echo " Generated: $(date)"
    echo "========================================"

    echo
    echo "[SOURCE: auth.log / secure]"

    if [[ -r /var/log/auth.log ]]; then
        echo "--- Recent failed password attempts (auth.log) ---"
        grep -iE "failed password|authentication failure|invalid user" /var/log/auth.log 2>/dev/null | tail -n 50 || echo "No matching entries"
        echo
        echo "--- Summary by source IP (top 10) ---"
        grep -iE "failed password|authentication failure" /var/log/auth.log 2>/dev/null \
            | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" \
            | sort | uniq -c | sort -nr | head -n 10 || echo "No IP data"
    elif [[ -r /var/log/secure ]]; then
        echo "--- Recent failed password attempts (secure) ---"
        grep -iE "failed password|authentication failure|invalid user" /var/log/secure 2>/dev/null | tail -n 50 || echo "No matching entries"
        echo
        echo "--- Summary by source IP (top 10) ---"
        grep -iE "failed password|authentication failure" /var/log/secure 2>/dev/null \
            | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" \
            | sort | uniq -c | sort -nr | head -n 10 || echo "No IP data"
    else
        echo "Neither /var/log/auth.log nor /var/log/secure is readable."
        echo "Try running with appropriate privileges or check log location."
    fi

    echo
    echo "[lastb - bad login attempts (if available)]"
    if command -v lastb >/dev/null 2>&1; then
        lastb -n 20 2>/dev/null || echo "lastb returned no data or requires privileges"
    else
        echo "lastb not available"
    fi

} > "$OUTPUT_FILE"

echo "Failed logins report saved to: $OUTPUT_FILE"
