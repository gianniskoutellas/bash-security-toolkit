# Bash Security Toolkit

Bash scripts for basic Linux security auditing in isolated, authorised lab environments.

## Purpose

Demonstrates practical Linux administration, log review, and security-relevant inventory skills.

## Scripts

| Script | What it does |
|--------|----------------|
| `scripts/system_inventory.sh` | OS, kernel, CPU, memory, disk, network interfaces, listening ports summary, recent logins |
| `scripts/failed_logins.sh` | Failed authentication attempts from auth.log/secure + top source IPs + lastb |
| `scripts/listening_ports.sh` | Active listening sockets (ss/netstat) and processes bound to network ports |

## Usage

```bash
git clone https://github.com/gianniskoutellas/bash-security-toolkit.git
cd bash-security-toolkit
chmod +x scripts/*.sh

# Run from the scripts directory so relative output path works
cd scripts
./system_inventory.sh
./failed_logins.sh
./listening_ports.sh
```

Reports are written to `output/` (one timestamped file per run).

## Requirements

- Linux (tested patterns for Debian/Ubuntu and RHEL-style systems)
- Standard tools: `ss` or `netstat`, `grep`, `awk`-compatible environment
- Some checks (auth logs, lastb, full process info) may need elevated privileges

## Scope

For authorised lab environments only. No exploitation, no unauthorised scanning.

## Roadmap

- User and sudoers audit script
- Basic SSH configuration checks
- Optional CSV/JSON report format
