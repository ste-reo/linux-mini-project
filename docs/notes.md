# Linux and Command Line Mastery — Technical Notes

## 1. Learning Environment

- Operating System: Ubuntu on WSL
- Shell: Bash
- Project: Linux Command Line Mastery
- Primary Focus: Linux administration and DevOps fundamentals

## 2. File Management

### Commands Practised
- `touch`: Create files.
- `mkdir -p`: Create nested directories.
- `cp`: Copy files.
- `mv`: Move and rename files.
- `rm -i`: Delete files with confirmation.
- `find`: Locate files and directories.
- `grep`: Search file contents.
- `head`: Inspect the first lines of a file.
- `tail`: Inspect the last lines of a file.
- `cat`: Display file contents.

### Practical Operations
Created a file-management workspace containing:
- source/
- backup/
- archive/

Practised copying `application.log` into the backup directory, moving the copy into the archive directory, and interactively deleting it.

Used `grep -rn "ERROR"` to search recursively for error messages.

### Observations
- `cp` preserves the original file while creating another copy.
- `mv` moves or renames files.
- `rm -i` requests confirmation before deletion.
- `find -type f` searches for regular files.
- `grep -rn` searches recursively and displays matching line numbers.

## 3. Directory Navigation and Filesystem

### Commands
- `pwd`
- `cd`
- `ls -la`
- `mkdir -p`
- `find`

### Practical Operations
Created nested directories and practised navigating between directories using relative and absolute paths.

### Linux Filesystem Observations

#### /etc
System-wide configuration files and directories.

#### /var
Variable data, including logs, caches and application state.

#### /tmp
Temporary files. Commonly configured with the sticky bit to restrict deletion by other users.

Actual directory observations to be added after inspection.

## 4. System Monitoring and Administration

### Commands to Practise
- `uptime`
- `free -m`
- `df -h`
- `ps aux`
- `top`
- `id`
- `chmod`
- `chown`
- `sudo`

### System Metrics
Actual outputs will be recorded after running the commands on the Ubuntu environment.

### Permissions and Ownership
Practical exercises and observations to be documented after completion.

## 5. Networking Basics

### Commands to Practise
- `ip addr`
- `ip -br addr`
- `ping`
- `ss -tulnp`

### Observations
Actual network interfaces, connectivity results and listening sockets will be recorded from the system.

## 6. Pipes and Redirection

### Operators and Commands
- `>`: Redirect standard output and overwrite a file.
- `>>`: Append standard output.
- `2>`: Redirect standard error.
- `|`: Pass output between commands.
- `grep`: Filter matching text.
- `awk`: Extract and process fields.
- `sort`: Sort output.
- `uniq`: Identify adjacent duplicate lines.

Practical exercises and command outputs to be added.

## 7. Shell Scripting

### Script
`scripts/setup_workspace.sh`

### Concepts
- Bash shebang: `#!/usr/bin/env bash`
- Strict error handling: `set -euo pipefail`
- Variables
- Directory creation
- Conditional statements
- Directory existence checks
- Executable permissions using `chmod +x`

### Practical Objective
Build a reusable workspace initialization script that checks for existing directories, creates missing directories and records execution timestamps.

Execution results to be verified and documented.

## 8. Troubleshooting Log

Record actual errors encountered, their causes and the commands used to resolve them.

## 9. Learning Summary

This project develops practical Linux command-line proficiency through repeated exercises in file management, filesystem navigation, system administration, networking, command pipelines and Bash automation.

The objective is to understand not only how commands work individually, but also how they can be combined to perform common DevOps administration tasks.
