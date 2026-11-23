# Linux and Command Line Mastery — Technical Notes

## 1. Learning Environment

- Operating System: Ubuntu on WSL
- Shell: Bash
- Project: Linux Command Line Mastery
- Primary Focus: Linux administration and DevOps fundamentals
- Repository: `linux-command-line-practice`

### Learning Approach

This project focuses on developing practical Linux command-line proficiency through hands-on exercises.

Each task should demonstrate:

- The objective of the operation.
- Commands and options used.
- Understanding of the underlying concepts.
- Verification of the results.
- Relevance to real-world DevOps administration.

The project prioritises practical execution, understanding command behaviour, troubleshooting errors and documenting verified results.

---

## 2. File Management

### Project Requirements

Practise creating, copying, moving, renaming and deleting files and directories. Learn to inspect, read and search file contents using standard Linux utilities.

### Commands Practised

- `touch`: Create empty files or update timestamps.
- `mkdir -p`: Create nested directories, including missing parent directories.
- `mkdir -v`: Display directory creation messages.
- `ls -lah`: Inspect files, permissions, ownership and human-readable sizes, including hidden entries.
- `tree`: Display directory hierarchies.
- `cp`: Copy files.
- `cp -r`: Recursively copy directories and their contents.
- `cp -i`: Request confirmation before overwriting.
- `cp -v`: Display copy operations.
- `cp -p`: Preserve file attributes where possible.
- `mv`: Move and rename files and directories.
- `rm -i`: Request confirmation before deleting a file.
- `rm -ri`: Recursively delete directories with interactive confirmation.
- `rm -r`: Recursively delete directories and contents without confirmation.
- `find`: Locate files and directories.
- `grep`: Search file contents.
- `grep -n`: Display matching line numbers.
- `grep -i`: Perform case-insensitive matching.
- `grep -r`: Search directories recursively.
- `grep -rn`: Search recursively and display matching line numbers.
- `grep -v`: Exclude matching lines.
- `grep -vn`: Exclude matching lines and display original line numbers.
- `grep -c`: Count matching lines.
- `less`: Open files for interactive viewing.
- `cat`: Display file contents.
- `head`: Inspect the first lines of a file.
- `tail`: Inspect the last lines of a file.
- `cmp`: Compare files byte by byte.
- `diff -r`: Compare directory contents recursively; further practical verification remains outstanding.

### Workspace Structure

The file-management workspace is located at:

`artifacts/file-management/`

Its directories serve the following purposes:

- `source/`: Original application and error logs.
- `backup/`: Backup copies of log files.
- `archive/`: Files retained for archival purposes.
- `processed/`: Workspace for files undergoing processing.

### Practical Operations

#### 1. Creating directories

Created the `processed/` directory using:

```bash
mkdir -vp artifacts/file-management/processed
```

The terminal confirmed successful directory creation.

#### 2. Inspecting files and directories

Inspected the workspace using:

```bash
tree artifacts/file-management
ls -lah artifacts/file-management/
find artifacts/file-management/ -type f
```

Inspected `source/application.log` using:

```bash
cat artifacts/file-management/source/application.log
```

Its contents were:

```text
Application started successfully
```

#### 3. Copying files

Copied the original application log into the processing directory:

```bash
cp -vpi artifacts/file-management/source/application.log artifacts/file-management/processed/
```

Verified the original and copied files using:

```bash
ls -l artifacts/file-management/source/
ls -l artifacts/file-management/processed/
```

Compared both files using:

```bash
cmp artifacts/file-management/source/application.log artifacts/file-management/processed/application.log
echo $?
```

The comparison produced no output, and the exit status was `0`, confirming that both files were identical.

#### 4. Moving and renaming files

Copied `error.log` from `source/` into `processed/`:

```bash
cp -v artifacts/file-management/source/error.log artifacts/file-management/processed/
```

Then moved the copied file into `archive/`, renaming it:

```bash
mv -v artifacts/file-management/processed/error.log artifacts/file-management/archive/error-processed.log
```

This demonstrates that `mv` can relocate and rename a file in a single operation.

The original `source/error.log` remains untouched because the initial operation used `cp`, not `mv`.

#### 5. Searching with find and grep

Examples:

```bash
find artifacts/file-management/ -type f -name "*.log"
```

Finds regular files ending in `.log`.

```bash
grep "ERROR" file
```

Displays lines containing `ERROR`.

```bash
grep -n "ERROR" file
```

Displays matching lines with line numbers.

```bash
grep -i "error" file
```

Performs case-insensitive matching.

```bash
grep -r "ERROR" directory/
```

Searches recursively through files in a directory.

```bash
grep -rn "ERROR" directory/
```

Searches recursively and displays matching line numbers.

```bash
grep -v "ERROR" file
```

Excludes lines containing `ERROR`.

```bash
grep -vn "ERROR" file
```

Excludes matching lines and displays original line numbers.

```bash
grep -c "ERROR" file
```

Counts matching lines.

**Practical observations:**

- Recursive searching identified errors across source and archive directories.
- The server event log contained five `ERROR` lines.
- Inverted searching retained three non-error lines.
- Grep searches and displays results without modifying the original files.

#### 6. Copying, moving and safe deletion

Practised recursive directory copying:

```bash
cp -r source destination
```

Practised copying with overwrite protection using `cp -i`. Answering `n` declined the overwrite.

Practised deletion using:

```bash
rm -i
rm -ri
rm -r
```

Observations:

- `rm -i` requests confirmation before deleting a file.
- `rm -ri` recursively deletes directories with interactive confirmation.
- Answering `n` to the descend prompt cancels that recursive deletion.
- `rm -r` removes a directory and its contents without confirmation.
- Practised removing the disposable `artifacts/deletion-lab/` directory using `rm -r`.

**Important:** Recursive deletion should only be performed after checking the target path. An incorrect path can cause significant data loss.

#### 7. Interactive file inspection with less

Practised opening files using:

```bash
less filename
```

Useful navigation and search keys:

- `/ERROR`: Search for a matching term.
- `n`: Move to the next match.
- `q`: Exit the viewer.

`less` is useful for inspecting large files without printing the entire contents to the terminal.

### Observations and Lessons

- `mkdir -p` creates missing parent directories.
- `mkdir -v` displays directory creation information.
- `ls -lah` provides detailed directory listings, including hidden entries and human-readable sizes.
- `tree` provides a visual representation of directory hierarchies.
- `find -type f` recursively locates regular files.
- Relative paths are resolved from the current working directory, while absolute paths begin at `/`.
- `cp` creates a separate copy while retaining the original.
- `cp -i` helps prevent accidental overwriting by requesting confirmation.
- `cp -v` displays the source and destination of copy operations.
- `cp -p` preserves file attributes where possible.
- `mv` removes a file from its original location after a successful move.
- `mv` can rename files by specifying a new destination filename.
- Unlike `cp`, `mv` does not require `-r` to move directories.
- `cmp` produces no output when two files are identical.
- Exit status `0` indicates success; `1` from `cmp` indicates differing files.
- `grep` searches text without changing the original files.
- `less` allows interactive inspection of large files.

### Troubleshooting Experiences

**Incorrect source path**

Error:

```text
cp: cannot stat 'application.log': No such file or directory
```

Cause: The command used a relative path that did not match the file's actual location.

Resolution: Used the correct path from the project root:

```text
artifacts/file-management/source/application.log
```

**Incorrect command arguments**

Error:

```text
cp: target '...' is not a directory
```

Cause: Incorrect source and destination arguments.

Lesson: Understand the `SOURCE DESTINATION` structure before executing file operations.

**Partial command success**

Observation: A copy command reported an error for an invalid source argument but successfully copied another valid source file.

Lesson: A command can partially succeed. Always inspect its output and verify the resulting files.

**Attempting to execute a text file**

Error: `command not found` or `Permission denied`.

Cause: Attempted to execute a log file as though it were a program.

Resolution: Use `cat` or another file-inspection command to read text files.

### Remaining File Management Verification

- [ ] Verify recursive directory comparison using `diff -r`.
- [ ] Independently verify `cp -p` attribute preservation.
- [ ] Capture screenshots showing commands and successful results.

### DevOps Relevance

File management is essential for:

- Organising application files and deployment directories.
- Creating backups before configuration changes.
- Staging files for processing and deployment.
- Managing application logs and archived records.
- Verifying copied files before replacing important files.
- Troubleshooting filesystem operations and incorrect paths.

---

## 3. Directory Navigation and Filesystem

### Project Requirements

Navigate the Linux filesystem using absolute and relative paths, create nested directory structures and understand the purpose of standard Linux directories.

### Commands Practised

- `pwd`: Display the current working directory.
- `cd`: Change directories.
- `cd ..`: Move to the parent directory.
- `cd ../..`: Move up two directory levels.
- `cd -`: Return to the previous working directory.
- `cd /`: Navigate to the filesystem root.
- `cd ~`: Navigate to the user's home directory.
- `ls -la`: List files, including hidden entries, with detailed information.
- `ls -lah`: Display detailed listings with human-readable sizes.
- `mkdir -p`: Create nested directory structures.
- `find`: Search for files and directories.
- `tree`: Display directory structures.

### Understanding Linux Paths

**Absolute paths**

An absolute path starts from the filesystem root `/`.

Example:

```bash
cd /var/log
```

The path identifies the destination independently of the current working directory.

**Relative paths**

A relative path starts from the current working directory.

Example:

```bash
cd ../..
```

This moves up two directory levels from the current location.

**Important navigation concepts:**

- `/` represents the filesystem root.
- `~` represents the current user's home directory.
- `.` represents the current directory.
- `..` represents the parent directory.
- `cd -` switches to the previous working directory.

### Practical Navigation Exercises

#### 1. Navigating project directories

From:

```text
~/linux-command-line-practice/artifacts/file-management
```

Used:

```bash
cd ../..
```

This moved two levels upward to the project root:

```text
/home/victor/linux-command-line-practice
```

#### 2. Switching between directories

Used:

```bash
cd /tmp
cd -
```

`cd -` returned to the previous working directory.

This demonstrated the difference between:

- `cd ..`: Move to the parent directory.
- `cd -`: Return to the previous working directory.

#### 3. Exploring the filesystem root

Used:

```bash
cd /
ls -lah
```

The filesystem root contains important system directories and mount points.

#### 4. Exploring /etc

Used:

```bash
cd /etc
ls
```

Observed that `/etc` contains system-wide configuration files and directories.

Configuration files define how system services and applications behave.

#### 5. Exploring /var

Used:

```bash
cd /var
ls -lah
```

Observed directories including:

- `backups/`
- `cache/`
- `crash/`
- `lib/`
- `local/`
- `log/`
- `mail/`
- `opt/`
- `spool/`
- `tmp/`

Also observed:

```text
lock -> /run/lock
run  -> /run
```

These are symbolic links pointing to locations under `/run`.

Used:

```bash
find . -maxdepth 1 -type f
```

Observed:

```text
./.updated
```

This command lists regular files directly inside the current directory, without searching deeper into subdirectories.

**Understanding the command:**

- `.`: Start searching in the current directory.
- `-maxdepth 1`: Do not descend into child directories.
- `-type f`: Return regular files only.

### Linux Filesystem Hierarchy

#### /

The root of the Linux filesystem. Other directories and mounted filesystems exist beneath it.

#### /home

Contains users' home directories and personal files.

Example:

```text
/home/victor
```

#### /etc

Contains system-wide configuration files and directories.

Examples include service configuration and application settings.

#### /var

Contains variable data that changes during normal system operation.

Examples:

- Logs.
- Application state.
- Caches.
- Package and database state.
- Queued or spooled data.

Unlike `/etc`, which primarily stores configuration, `/var` stores operational data that changes as the system runs.

#### /var/log

Contains system and application logs.

Used to investigate system events, service behaviour, errors and authentication activity.

#### /var/cache

Stores cached data that applications can regenerate when needed.

#### /var/lib

Stores persistent application and system state.

#### /var/spool

Contains queued work waiting to be processed, such as mail or print jobs.

#### /tmp

Stores temporary files.

Applications and processes use it for temporary data. It is commonly configured with the sticky bit to restrict deletion by other users.

### Practical Investigation: /var/log

Inspected the log directory using:

```bash
ls -lah /var/log
```

Observed log files and directories including:

- `syslog`
- `auth.log`
- `kern.log`
- `dmesg`
- `dpkg.log`
- `alternatives.log`
- `bootstrap.log`
- `journal/`
- `apt/`
- `unattended-upgrades/`

These logs serve different purposes:

| Log | Purpose |
|---|---|
| `syslog` | General system and service events. |
| `auth.log` | Authentication and privilege-related activity. |
| `kern.log` | Kernel-related messages. |
| `dmesg` | Kernel ring buffer messages, often relating to system and device initialisation. |
| `dpkg.log` | Package installation, removal and configuration activity. |
| `alternatives.log` | Changes managed by the alternatives system. |

### Understanding File Permissions and Ownership

The following example was observed in `/var/log`:

```text
-rw-r----- 1 syslog adm 5.3K auth.log
```

Breakdown:

- `-`: Regular file.
- `rw-`: Owner can read and write.
- `r--`: Group can read.
- `---`: Other users have no permissions.
- `syslog`: File owner.
- `adm`: Group ownership.

This shows why some log files require elevated privileges or membership in an authorised group to inspect.

`sudo` allows authorised users to execute commands with elevated privileges.

### Practical Log Investigation

#### 1. Inspecting recent system logs

Used:

```bash
tail -n 15 /var/log/syslog
```

This displayed the last 15 lines of the system log.

`tail` is useful when investigating large logs because it displays the most recent entries without printing the entire file.

#### 2. Filtering system errors

Used:

```bash
grep -i "error" /var/log/syslog | tail -n 10
```

Command breakdown:

- `grep`: Searches for matching text.
- `-i`: Ignores case differences.
- `"error"`: Search term.
- `|`: Passes the output to another command.
- `tail -n 10`: Displays the last ten matching lines.

Observed WSL-related messages included:

- `CheckConnection: getaddrinfo() failed`.
- `ConfigApplyWindowsLibPath`.
- `InitializeLogging`.
- `failed to collect insights`.

The log also contained recurring WSL Ubuntu Pro service warnings because the Windows agent address file could not be found.

These observations demonstrate that log messages must be interpreted in context. A message containing `ERROR` does not automatically indicate a critical system failure.

#### 3. Inspecting authentication logs

Used:

```bash
sudo tail -n 15 /var/log/auth.log
```

Observed entries relating to:

- `CRON` opening and closing scheduled sessions as root.
- `sudo` opening and closing privileged sessions.
- The user `victor` executing a command with elevated privileges.

An observed sudo entry included:

```text
TTY=/dev/pts/0
PWD=/var
USER=root
COMMAND=/usr/bin/tail -n 15 /var/log/auth.log
```

Interpretation:

- `TTY`: Terminal associated with the command.
- `PWD`: Working directory when the command was executed.
- `USER`: Account the command ran as.
- `COMMAND`: Command executed with elevated privileges.

Authentication logs can help investigate successful and failed authentication attempts, privilege escalation and suspicious access.

#### 4. Searching for authentication failures

Used:

```bash
sudo grep -iE "failed|failure|invalid|authentication failure" /var/log/auth.log | tail -n 15
```

Also searched the previous log:

```bash
sudo grep -iE "failed|failure|invalid|authentication failure" /var/log/auth.log.1
```

No matching entries were returned in the inspected files.

**Important observation:**

No matching results do not prove that no unauthorised access was attempted.

Possible explanations include:

- The event occurred outside the current log's retention period.
- The event was recorded in an older rotated log.
- The event was recorded using different wording.
- Another logging source contains the relevant event.

Log investigations should consider the relevant time period and all appropriate log sources.

### Understanding Log Rotation

Log files can grow continuously as services and applications record events.

Allowing them to grow indefinitely could consume significant disk space.

Linux systems use log rotation to manage log size and retention.

Common rotated log filenames include:

```text
auth.log
auth.log.1
auth.log.2.gz
auth.log.3.gz
```

General interpretation:

- `auth.log`: Current log.
- `auth.log.1`: Most recently rotated log.
- `auth.log.2.gz`: An older compressed generation.
- `auth.log.3.gz`: Another older compressed generation.

The exact files available depend on the system's rotation history and configuration.

#### Inspecting rotated logs

Used:

```bash
ls -lh /var/log/auth.log*
```

Observed:

```text
-rw-r----- 1 syslog adm 7.0K Nov 23 15:20 auth.log
-rw-r----- 1 syslog adm  41K Nov 22 22:26 auth.log.1
```

This confirmed that the system had a current authentication log and a previous generation.

A search of `auth.log.1` returned no matching authentication failure patterns.

#### Searching compressed logs

Introduced `zgrep`, which searches compressed files without manually extracting them.

Example:

```bash
sudo zgrep -iE "failed|failure|invalid" /var/log/auth.log.2.gz
```

The command returned:

```text
gzip: /var/log/auth.log.2.gz: No such file or directory
```

The subsequent listing confirmed that `auth.log.2.gz` did not exist.

**Lesson:** Never assume that every system has the same rotated files. Check which archives actually exist before searching them.

### Investigating Log Rotation Configuration

Inspected the log rotation configuration directory:

```bash
ls -lah /etc/logrotate.d/
```

Observed configuration files including:

- `alternatives`
- `apport`
- `apt`
- `btmp`
- `chrony`
- `dpkg`
- `rsyslog`
- `ubuntu-pro-client`
- `unattended-upgrades`
- `wtmp`

Inspected the rsyslog configuration:

```bash
cat /etc/logrotate.d/rsyslog
```

Observed:

```conf
/var/log/syslog
/var/log/mail.log
/var/log/kern.log
/var/log/auth.log
/var/log/user.log
/var/log/cron.log
{
        rotate 4
        weekly
        missingok
        notifempty
        compress
        delaycompress
        sharedscripts
        postrotate
                /usr/lib/rsyslog/rsyslog-rotate
        endscript
}
```

### Understanding the Logrotate Directives

| Directive | Meaning |
|---|---|
| `rotate 4` | Retain four rotated log generations. |
| `weekly` | Rotate logs weekly. |
| `missingok` | Do not report an error if a log file is missing. |
| `notifempty` | Do not rotate an empty log file. |
| `compress` | Compress older rotated logs. |
| `delaycompress` | Delay compression of the most recently rotated log until a subsequent rotation cycle. |
| `sharedscripts` | Run the post-rotation script once for the group of logs. |
| `postrotate` | Defines commands to execute after rotation. |
| `endscript` | Marks the end of the post-rotation script. |

The post-rotation script runs:

```bash
/usr/lib/rsyslog/rsyslog-rotate
```

This helps rsyslog reopen its log files after rotation so that logging continues correctly.

**Understanding `delaycompress`:**

The most recently rotated log can remain uncompressed as `.1`, while older generations are compressed.

Example:

```text
auth.log
auth.log.1
auth.log.2.gz
auth.log.3.gz
```

This does not mean compression waits until a file reaches a particular size. It delays compression by one rotation cycle.

**Understanding retention:**

`rotate 4` specifies four rotated generations, separate from the current active log. The actual number of files present depends on rotation history and whether logs are empty or missing.

### Directory Navigation Observations and Lessons

- Absolute paths start at `/`.
- Relative paths are resolved from the current working directory.
- `cd ..` moves to the parent directory.
- `cd ../..` moves up two directory levels.
- `cd -` returns to the previous working directory.
- `/etc` stores system-wide configuration.
- `/var` stores variable operational data.
- `/var/log` stores system and application logs.
- `tail` is useful for inspecting recent log entries.
- Pipes allow command output to be filtered by other commands.
- `grep -E` supports multiple search patterns.
- `sudo` provides elevated privileges for authorised operations.
- Log rotation prevents logs from growing indefinitely.
- `zgrep` searches compressed log archives.
- Logrotate configuration determines rotation frequency, compression and retention.
- Log ownership and permissions control access to sensitive information.

### DevOps Relevance

Filesystem navigation and log investigation are essential when:

- Accessing application configuration.
- Inspecting system and application logs.
- Navigating deployment directories.
- Managing scripts and configuration files.
- Troubleshooting Linux servers.
- Investigating service failures.
- Identifying authentication and privilege-related events.
- Managing log retention and storage.
- Retrieving historical evidence during incident investigations.

### Remaining Directory Navigation Exercises

- [ ] Explore `/tmp` and understand its permissions.
- [ ] Create and remove temporary files safely.
- [ ] Inspect the sticky bit on `/tmp`.
- [ ] Practise locating files from different starting directories.
- [ ] Explore symbolic links in more detail.
- [ ] Capture screenshots showing navigation and filesystem investigations.

---

## 4. System Monitoring and Administration

### Project Requirements

Inspect system health, monitor processes and resources, manage users and groups, and understand file permissions and ownership.

### Commands to Practise

- `uptime`: Display system uptime and load averages.
- `free -m`: Display memory usage in megabytes.
- `df -h`: Display filesystem disk usage.
- `ps aux`: Display running processes.
- `top`: Monitor processes and resource usage interactively.
- `id`: Display user and group identity information.
- `chmod`: Modify file permissions.
- `chown`: Change file ownership.
- `sudo`: Execute commands with elevated privileges.
- `useradd`: Create user accounts.
- `groupadd`: Create groups.
- `usermod`: Modify user account properties.

### System Metrics

Actual outputs will be recorded after running the commands on the Ubuntu environment.

### Permissions and Ownership

Practical exercises will cover:

- Linux users and groups.
- File ownership.
- Read, write and execute permissions.
- Symbolic and numeric permission notation.
- Modifying permissions with `chmod`.
- Changing ownership with `chown`.
- Understanding administrative privileges with `sudo`.

### Package Management

Additional assessment requirement.

Commands to practise:

- `apt update`: Refresh package indexes.
- `apt upgrade`: Upgrade installed packages.
- `apt install`: Install packages.
- `apt remove`: Remove installed packages.
- `apt list --installed`: Inspect installed packages.

Package installation, version checks and terminal evidence will be documented after execution.

---

## 5. Networking Basics

### Project Requirements

Verify network connectivity and inspect network configuration.

### Commands to Practise

- `ip addr`: Display network interfaces and IP addresses.
- `ip -br addr`: Display network interfaces in brief format.
- `ping`: Test network connectivity.
- `ss -tulnp`: Inspect listening sockets and associated processes.
- `netstat`: Alternative network inspection utility where installed.

### Observations

Actual network interfaces, connectivity results and listening sockets will be recorded from the system.

### DevOps Relevance

Networking knowledge helps with:

- Troubleshooting server connectivity.
- Inspecting IP addresses and interfaces.
- Understanding listening services.
- Diagnosing application connectivity problems.
- Investigating communication between services.
- Understanding network dependencies in deployments.

---

## 6. Pipes and Redirection

### Project Requirements

Redirect command output and errors, and combine commands using pipelines to filter and process information.

### Operators and Commands

- `>`: Redirect standard output and overwrite a file.
- `>>`: Append standard output to an existing file.
- `2>`: Redirect standard error.
- `|`: Pass the output of one command into another.
- `grep`: Filter matching text.
- `awk`: Extract and process fields.
- `sort`: Sort output.
- `uniq`: Identify adjacent duplicate lines.
- `cat`: Display or combine file contents.

### Observations

- `>` replaces existing file contents.
- `>>` preserves existing content and appends new output.
- `2>` redirects error output rather than standard output.
- A here-document (`<<`) supplies multiple lines of input to a command.
- Using `>` with a here-document writes the supplied output to a file, replacing its previous contents.
- Pipes allow commands to work together without manually saving intermediate output.
- Commands can be chained to filter, transform and inspect information.

Practical exercises, terminal outputs and troubleshooting observations will be documented after execution.

---

## 7. Shell Scripting

### Script

`scripts/setup_workspace.sh`

### Project Requirements

Write a reusable Bash script incorporating variables, conditionals and loops to automate directory creation and logging.

### Concepts

- Bash shebang: `#!/usr/bin/env bash`
- Strict error handling: `set -euo pipefail`
- Variables.
- Directory creation.
- Conditional statements.
- Loops.
- Directory existence checks.
- Executable permissions using `chmod +x`.
- Logging and timestamps.

### Practical Objective

Build a reusable workspace initialization script that checks for existing directories, creates missing directories and records execution timestamps.

Execution results and script behaviour will be verified and documented.

---

## 8. Troubleshooting Log

Record actual errors encountered, their causes and the commands used to resolve them.

### Git Push Rejected

**Error:** Git push rejected with fetch first / non-fast-forward.

**Cause:** The remote repository already contained an initial commit that was not present locally.

**Resolution:**

```bash
git pull --rebase origin main
git checkout --theirs README.md
git add README.md
git rebase --continue
git push -u origin main
```

The rebase was completed and the changes were pushed.

### Incorrect File Paths

**Error:**

```text
cp: cannot stat 'application.log': No such file or directory
```

**Cause:** The command used a relative path that did not match the file's actual location.

**Resolution:** Used the correct path from the project root:

```text
artifacts/file-management/source/application.log
```

### Incorrect Copy Arguments

**Error:**

```text
cp: target '...' is not a directory
```

**Cause:** Incorrect source and destination arguments.

**Lesson:** Understand the `SOURCE DESTINATION` structure of `cp`.

### Partial Command Success

**Observation:** A copy command reported an error for an invalid source but successfully copied another valid source.

**Lesson:** A command can partially succeed. Always inspect its output and verify the resulting files.

### Attempting to Execute a Text File

**Error:** `command not found` or `Permission denied`.

**Cause:** Attempted to execute a log file as though it were a program.

**Resolution:** Use `cat` or another file-inspection command to read text files.

### WSL Ubuntu Pro Service Warning

**Observed in:** `/var/log/syslog`

The WSL Pro service repeatedly reported that it could not connect to the Windows agent because it could not find:

```text
/mnt/c/Users/victo/.ubuntupro/.address
```

The service exited and systemd scheduled subsequent restart attempts.

**Lesson:** Log warnings should be investigated in context. A warning does not automatically indicate a critical system failure. The relevance of the Ubuntu Pro integration to the WSL environment should be assessed before attempting to resolve it.

---

## 9. Learning Summary

This project develops practical Linux command-line proficiency through repeated exercises in:

- File and directory management.
- Filesystem navigation.
- System monitoring and administration.
- Package management.
- Permissions and ownership.
- Networking.
- Pipes and redirection.
- Bash scripting and automation.
- Log investigation and rotation.
- Documentation and version control.

The objective is to understand not only how commands work individually, but also how they can be combined to perform common DevOps administration tasks.

The project prioritises practical execution, understanding command behaviour, troubleshooting errors and documenting verified results.

### Repository Structure

The repository should contain:

- `README.md`: Project overview, goals, command list, completion checklist and learning summary.
- `docs/notes.md`: Detailed documentation, observations, command outputs and troubleshooting.
- `scripts/`: Reusable shell scripts with internal comments.
- `screenshots/`: Visual evidence of completed exercises.
- `artifacts/`: Sample files, logs and configuration extracts generated during exercises.

### Current Learning Progress

**Completed practical areas:**
- File creation and directory creation.
- File inspection.
- Copying, moving and renaming.
- Searching with `find` and `grep`.
- Safe and recursive deletion.
- Interactive file inspection with `less`.
- Absolute and relative path navigation.
- Parent-directory and previous-directory navigation.
- Exploring `/`, `/etc`, `/var` and `/var/log`.
- Inspecting system and authentication logs.
- Filtering log entries using `grep`.
- Understanding log rotation and inspecting logrotate configuration.

**Next practical focus:**
- Explore `/tmp`.
- Understand temporary-file permissions and the sticky bit.
- Continue filesystem navigation and investigation.
- Progress into system monitoring and administration.

The project should continue to document actual terminal evidence as each practical exercise is completed.
