# Linux and Command Line Mastery

A hands-on Linux learning project focused on developing practical command-line skills for Linux system administration and DevOps engineering.

The project emphasises learning through execution, troubleshooting, system inspection, file management, networking, text processing, and Bash automation. It documents practical exercises, command behaviour, observed results, and supporting evidence.

## Project Objectives

- Develop practical Linux file and directory management skills.
- Understand the Linux filesystem hierarchy.
- Navigate using absolute and relative paths.
- Manage file permissions, ownership, users, and groups.
- Monitor system resources and running processes.
- Manage systemd services and inspect system logs.
- Understand package management using APT and DPKG.
- Perform basic networking and DNS diagnostics.
- Use pipes and redirection to process command output.
- Develop reusable Bash scripts for basic automation.
- Apply structured troubleshooting techniques.
- Document practical exercises and preserve evidence of work.

## Environment

This project was practised in an Ubuntu Linux environment running on Windows Subsystem for Linux 2 (WSL2).

| Component | Detail |
| --- | --- |
| Operating system | Ubuntu 26.04.1 LTS |
| Virtualisation platform | WSL2 |
| Shell | GNU Bash 5.3.9 |
| Architecture | `x86_64` |
| Kernel | Linux `6.18.58.1-microsoft-standard-WSL2` |
| Project directory | `~/linux-command-line-practice` |
| Repository | `linux-command-line-practice` |

## Repository Structure

```text
linux-command-line-practice/
├── README.md
├── docs/
│   ├── notes.md
│   ├── errors.log
│   ├── output.log
│   └── service_checker.log
├── scripts/
│   └── setup_workspace.sh
├── screenshots/
│   ├── Section-1-Learning-Environment/
│   ├── Section-2-File-Management/
│   ├── Section-3-Directory-Navigation-and-Filesystem/
│   ├── Section-4-System-Monitoring-and-Administration/
│   ├── Section-5-Networking-Basics/
│   ├── Section-6-Pipes-Redirection-and-Text-Processing/
│   ├── Section-7-Shell-Scripting/
│   └── earlier supplementary screenshots
└── artifacts/
    ├── file-management/
    ├── navigation/
    ├── permissions-lab/
    ├── pipes-redirection-lab/
    ├── shell-scripting-lab/
    ├── workspace_demo/
    ├── workspace test/
    ├── section7_test/
    └── supporting logs and files
```

The repository contains 27 section-organised screenshots across Sections 1–7, plus seven earlier supplementary screenshots stored directly in `screenshots/`. The `artifacts/` directory contains exercise files, logs, generated configuration, a Debian package archive, and script outputs used as supporting evidence.

## Topics Covered

### 1. File and Directory Management

Practised creating, inspecting, copying, moving, renaming, and deleting files and directories using `touch`, `mkdir`, `ls`, `tree`, `cp`, `mv`, and `rm`.

Used `find` and `grep` to locate files and search their contents, alongside `cat`, `less`, `head`, `tail`, and `cmp` for file inspection and comparison.

### 2. Permissions, Ownership, and User Administration

Explored Linux read, write, and execute permissions across owner, group, and other permission classes.

Practised symbolic and numeric permission changes with `chmod`, default creation masks with `umask`, and ownership changes with `chown` and `chgrp`.

Also worked with user and group administration using `id`, `groups`, `getent`, `groupadd`, `useradd`, and `usermod`.

Investigated privileged file operations and why shell redirection with `sudo` can fail, using `sudo tee` to write to restricted files.

### 3. Directory Navigation and Filesystem

Practised absolute and relative navigation using `pwd`, `cd`, `cd ..`, `cd ../..`, `cd -`, `cd /`, and `cd ~`.

Created nested directories using `mkdir -p` and inspected directory contents and metadata with `ls`, `ls -la`, `ls -lah`, `ls -ld`, `find`, and `tree`.

Explored the Linux filesystem hierarchy, including `/etc`, `/var`, `/var/log`, `/tmp`, `/run`, `/usr`, and other standard directories.

The project also covered symbolic links, directory permissions, the sticky bit, system-log investigation, authentication-log inspection, and log-rotation configuration using `tail`, `grep`, `sudo`, `zgrep`, and files under `/etc/logrotate.d/`.

### 4. System Monitoring and Administration

Monitored processes and system resources using:

- `ps aux` and `top` for process inspection.
- `free -m` for memory and swap usage.
- `df -h` and `du -sh` for storage inspection.
- `uptime` for system uptime and load averages.

Inspected and managed systemd services using `systemctl`, including checking the `cron` service and creating and managing a custom `linux-lab.service` unit.

Used `journalctl` to query service and system events and practised journal maintenance and cleanup.

### 5. Package Management

Explored the distinction between APT and DPKG on Ubuntu:

- **APT:** High-level package management, repository metadata, dependency resolution, installation, and removal.
- **DPKG:** Lower-level management of local Debian package archives and the installed-package database.

Practised package inventory and status inspection using `apt list --installed` and `dpkg -l`.

Used `apt show <package>` and `dpkg -s <package>` to inspect package metadata, versions, dependencies, and installation status.

Practised package installation using `sudo apt install <package>` and `sudo dpkg -i <file.deb>`, as well as package removal using `sudo apt remove <package>` and `sudo apt purge <package>`. `apt purge` removes package-managed configuration files, but does not guarantee removal of every user-created file or external configuration.

These exercises demonstrated the difference between APT’s repository-based dependency management and DPKG’s direct local package operations.

### 6. Networking Basics

Practised connectivity testing with `ping` and inspected network interfaces and assigned addresses using `ip addr`.

Examined listening TCP and UDP sockets with `ss -tulnp`; elevated privileges may be required to display process information for sockets owned by other users. Also inspected DNS and name-resolution behaviour using:

- `dig` for DNS records such as `A`, `AAAA`, and `MX`.
- `/etc/resolv.conf` for resolver configuration.
- `/etc/hosts` for local hostname mappings.
- `/etc/nsswitch.conf` for name-service lookup ordering.
- `hostname` for system hostname inspection.

Also used command exit statuses to help distinguish connectivity results and investigated the relationship between local name resolution and external DNS queries.

### 7. Pipes, Redirection, and Text Processing

Practised standard input, standard output, and standard error handling using pipes and redirection operators:

`|`, `>`, `>>`, `2>`, `2>>`, `2>&1`, `&>`, and `/dev/null`.

Used text-processing utilities including `grep`, `wc`, `awk`, `tr`, `sort`, `uniq`, `tee`, and `sed` to filter, count, transform, and summarise command output.

For example, both standard output and standard error can be redirected into one file:

```bash
ls /etc /directory_that_does_not_exist > combined.log 2>&1
```

The order matters: `> combined.log` redirects standard output first, and `2>&1` then sends standard error to the same destination.

`uniq` detects adjacent repeated lines. To count duplicates across an entire unsorted input, sort the lines first:

```bash
sort file.txt | uniq -c
```

### 8. Shell Scripting and Automation

Developed Bash scripting skills using variables, positional parameters, functions, conditionals, loops, timestamps, command availability checks, and explicit exit statuses.

Created `scripts/setup_workspace.sh` to automate repeatable workspace setup using directory and file creation operations.

Also created `artifacts/shell-scripting-lab/service_checker.sh` to check requested service states, log results, validate arguments, check Docker CLI availability, and return meaningful exit codes.

Practised script syntax validation using:

```bash
bash -n script.sh
```

Also used commonly adopted Bash strict-mode settings:

```bash
set -euo pipefail
```

These settings help detect unset variables, unhandled command failures, and pipeline failures, while recognising that `set -e` has exceptions in certain conditional and command-list contexts.

### 9. Troubleshooting and Problem Solving

Applied a structured troubleshooting workflow to diagnose command, path, argument, permission, scripting, environment, service, and Git issues.

The exercises covered:

- Identifying missing files and directories.
- Diagnosing invalid command arguments and paths.
- Reading standard error and interpreting command output.
- Checking exit statuses using `$?`.
- Investigating permissions and service states.
- Understanding partial command failures.
- Handling non-fast-forward Git push rejections by synchronising local and remote history.

The emphasis was on identifying the cause of unexpected behaviour, applying a targeted fix, and verifying the result rather than repeatedly running commands without understanding the error.

## Command Reference

| Area | Commands and tools |
| --- | --- |
| File management | `touch`, `mkdir`, `ls`, `tree`, `cp`, `mv`, `rm`, `find`, `grep`, `cat`, `less`, `head`, `tail`, `cmp` |
| Navigation | `pwd`, `cd`, `cd ..`, `cd ../..`, `cd -`, `cd /`, `cd ~`, `mkdir -p` |
| Permissions and users | `chmod`, `umask`, `chown`, `chgrp`, `id`, `groups`, `getent`, `groupadd`, `useradd`, `usermod`, `sudo`, `tee` |
| Monitoring | `ps aux`, `top`, `free -m`, `df -h`, `du -sh`, `uptime` |
| Services and logs | `systemctl`, `journalctl`, `tail`, `grep`, `zgrep` |
| Packages | `apt list --installed`, `apt show`, `apt install`, `apt remove`, `apt purge`, `dpkg -l`, `dpkg -s`, `dpkg -i` |
| Networking | `ping`, `ip addr`, `ss -tulnp`, `dig`, `hostname` |
| Streams and text | Pipe (`&#124;`), `>`, `>>`, `2>`, `2>>`, `2>&1`, `&>`, `/dev/null`, `wc`, `grep`, `awk`, `tr`, `sort`, `uniq`, `tee`, `sed` |
| Bash scripting | Variables, positional parameters, functions, `if`, `case`, `for`, `while`, `read`, `exit`, `$?`, `date`, `command -v`, `bash -n`, `set -euo pipefail` |

## Completion Checklist

- [x] File and directory management.
- [x] Directory navigation and Linux filesystem hierarchy.
- [x] File permissions, ownership, users, and groups.
- [x] System resource and process monitoring.
- [x] systemd service management and journal inspection.
- [x] Package inventory, metadata inspection, installation, removal, and verification.
- [x] Networking connectivity, DNS, interfaces, and listening sockets.
- [x] Pipes, redirection, standard streams, and text processing.
- [x] Bash scripting, workspace automation, service checking, and exit-status handling.
- [x] Troubleshooting and Git workflow practice.
- [x] Documentation, screenshots, scripts, and supporting artifacts organised in the repository.

## Evidence and Documentation

Practical work is supported by the following repository resources:

- [Technical Notes](docs/notes.md): Detailed explanations, commands, practical exercises, observations, troubleshooting notes, and evidence references across Sections 1–9.
- `screenshots/`: Terminal-session screenshots organised by project section, with supplementary captures from earlier exercises.
- `artifacts/`: Generated logs, sample files, configuration extracts, a Debian package archive, and script outputs.
- `scripts/`: Reusable Bash automation scripts, including workspace setup.

The technical notes provide the detailed record of the work, while the screenshots and repository artifacts provide supporting evidence of practical execution.

## Learning Summary

This project strengthened practical Linux command-line proficiency across filesystem navigation, file operations, permissions, user and group administration, system monitoring, service management, package management, networking, text processing, and Bash automation.

The most important takeaway is that effective Linux administration depends not only on knowing commands, but also on interpreting outputs, exit statuses, permissions, logs, and error messages accurately.

These skills provide a practical foundation for troubleshooting Linux systems, automating repetitive tasks, and working with servers, cloud infrastructure, containers, and CI/CD environments.
