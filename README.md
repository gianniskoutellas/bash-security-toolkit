# Bash Security Toolkit

A collection of Bash scripts for basic Linux security auditing and hardening checks in isolated, authorised lab environments.

## Purpose

This project demonstrates practical Linux administration, security auditing, and reporting skills.

## Scripts

- `system_inventory.sh`: Collects OS, kernel, hostname, disk, memory, and network information.
- `failed_logins.sh`: Identifies failed authentication attempts from system logs.
- `listening_ports.sh`: Lists active listening services and associated processes.

## Usage

```bash
chmod +x scripts/*.sh
./scripts/system_inventory.sh
```

## Scope

For authorised lab environments only. This project does not perform exploitation or unauthorised testing.

## Roadmap

- Add user and sudo audit script
- Add basic SSH hardening checks
- Add CSV/JSON reporting
- Add severity ratings
