#!/usr/bin/env bash

# listening_ports.sh
# Lists active listening services and associated processes.
# Intended for authorised lab environments only.

set -euo pipefail

OUTPUT_DIR="../output"
OUTPUT_FILE="${OUTPUT_DIR}/listening_ports_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$OUTPUT_DIR"

{
    echo "========================================"
    echo " LISTENING PORTS AND SERVICES"
    echo " Generated: $(date)"
    echo "========================================"

    echo
    echo "[ss -tulnp]"
    if command -v ss >/dev/null 2>&1; then
        ss -tulnp 2>/dev/null || ss -tuln
    else
        echo "ss not available"
    fi

    echo
    echo "[netstat fallback (if ss unavailable or for comparison)]"
    if command -v netstat >/dev/null 2>&1; then
        netstat -tulnp 2>/dev/null || netstat -tuln
    else
        echo "netstat not available"
    fi

    echo
    echo "[Processes bound to network sockets (lsof)]"
    if command -v lsof >/dev/null 2>&1; then
        lsof -i -P -n 2>/dev/null | head -n 40 || echo "lsof returned no data or requires privileges"
    else
        echo "lsof not available"
    fi

    echo
    echo "[Quick interpretation notes]"
    echo "- Look for unexpected high ports or services listening on 0.0.0.0"
    echo "- Cross-check process names against known required services"
    echo "- Privilege level of the process matters for exposure risk"

} > "$OUTPUT_FILE"

echo "Listening ports report saved to: $OUTPUT_FILE"
