# Linux and Command Line Mastery — Technical Notes

## 1. Learning Environment

### 1.1 Environment Overview

This project is practised in an Ubuntu Linux environment running inside Windows Subsystem for Linux (WSL2), providing a practical command-line workspace for Linux fundamentals, system administration, networking, text processing, and Bash scripting.

| **Component** | **Environment Detail** |
| --- | --- |
| **Operating System** | Ubuntu 26.04.1 LTS |
| **Virtualisation Environment** | WSL2 |
| **Shell** | GNU Bash 5.3.9 |
| **Architecture** | `x86_64` |
| **Kernel** | Linux `6.18.58.1-microsoft-standard-WSL2` |
| **Project Directory** | `~/linux-command-line-practice` |
| **Repository** | `linux-command-line-practice` |

### 1.2 Learning Approach

Each exercise in this project is approached with emphasis on practical execution rather than rote memorisation alone:

- **Conceptual understanding:** Clarifying what a command, flag, stream, or subsystem does before relying on it.

- **Accurate execution:** Running commands cleanly in the WSL2 Ubuntu environment and checking paths, arguments, and privileges.

- **Output interpretation:** Reading stdout, stderr, status indicators, and exit codes to verify what actually happened.

- **DevOps relevance:** Connecting everyday CLI tasks to server administration, automation, containers, CI/CD, and troubleshooting workflows.

- **Documented evidence:** Linking notes to organised terminal records and repository artifacts.
### 1.3 Evidence

- `screenshots/Section-1-Learning-Environment/01-ubuntu-wsl-bash-kernel-environment.png` — Recorded environment verification reference for Ubuntu, WSL2, Bash, and kernel details.


---

## 2. File Management

### 2.1 Objective

Develop practical skills for creating, inspecting, copying, moving, renaming, deleting, and searching files and directories in Linux, alongside core concepts in file permissions, ownership, groups, user administration, and privileged operations.

### 2.2 Commands Practised

| Command | Purpose |
| --- | --- |
| `touch` | Create empty files or update file timestamps. |
| `mkdir` | Create directories (including nested paths when using `-p`). |
| `ls` | List files and directories and inspect metadata. |
| `tree` | Display directory hierarchies visually. |
| `cp` | Copy files and directories. |
| `mv` | Move or rename files and directories. |
| `rm` | Remove files and directories (including interactive `-i` and recursive `-r` modes). |
| `find` | Search directory trees for files and directories matching criteria. |
| `grep` | Search file contents or streams for matching text patterns. |
| `cat` | Concatenate and print file contents to standard output. |
| `less` | Page through file contents interactively. |
| `head` | Display the first lines of a file. |
| `tail` | Display the last lines of a file. |
| `cmp` | Compare two files byte by byte and report differences. |
| `chmod` | Modify file and directory permission bits. |
| `umask` | Inspect or set the default file-creation permission mask. |
| `chown` | Change file or directory owner (and optionally group). |
| `chgrp` | Change group ownership of files or directories. |
| `id` | Display real and effective user ID (`uid`), group ID (`gid`), and supplementary group memberships. |
| `groups` | Display the group memberships of the current or a specified user. |
| `getent` | Query system administrative databases such as `passwd` and `group`. |
| `groupadd` | Create a new user group. |
| `useradd` | Create a new user account. |
| `usermod` | Modify properties or group memberships of an existing user account.


### 2.3 Permissions, Ownership and User Administration

Linux enforces access control through read (`r`), write (`w`), and execute (`x`) permissions across three permission classes: **user (owner)**, **group**, and **others**.

#### File vs. Directory Permissions

* **On regular files:** `r` allows reading file contents; `w` allows modifying file contents (creating or deleting the file itself depends on write permission on the parent directory); `x` allows executing the file as a binary or script.
* **On directories:** `r` allows listing directory entries (such as with `ls`); `w` allows creating, renaming, or removing entries inside the directory; `x` (traverse/search permission) allows passing through the directory to access files or subdirectories along a path. A directory with `r` but without `x` lets a user see entry names in a listing but blocks accessing metadata or opening files inside it.



#### Symbolic vs. Numeric Permissions and `umask`

* **Symbolic notation (`chmod`):** Modifies specific classes and bits relative to current permissions (for example, `chmod u+x script.sh` adds execute for the owner, or `chmod g-w,o-rwx file` tightens group/other access).
* **Numeric (octal) notation (`chmod`):** Sets exact permission bits using base-8 digits where `r=4`, `w=2`, and `x=1` per class (for example, `chmod 644 file` sets `rw-r--r--`, `chmod 755 dir_or_script` sets `rwxr-xr-x`, and `chmod 600 private_file` restricts access to `rw-------`).
* **Default creation mask (`umask`):** Rather than granting full `0666` (files) or `0777` (directories) permissions on creation, the kernel masks out permission bits set in the process `umask` (for example, a `umask` of `0022` masks group and other write bits, yielding `0644` for new files and `0755` for new directories). Inspecting `umask` before and after changing it shows how default access is controlled for newly created items.



#### Ownership, Group Membership, Lookup and Privileged Redirection

* **Ownership vs. group membership:** Every file has a single owning user and a single owning group (`chown owner:group target` or `chown owner target`; `chgrp group target`). Having a group as the file's group owner does not automatically grant access unless the **group** permission bits allow it; a user only exercises group permissions if their user ID matches one of the groups associated with the file (primary `gid` or supplementary groups).
* **Identity and database queries (`id`, `groups`, `getent`):** `id` and `groups` show active user and group identities in the shell session, while `getent passwd <user>` and `getent group <group>` query system databases (including `/etc/passwd` and `/etc/group`) to verify account and group creation after `useradd`, `usermod`, and `groupadd`.
* **Privileged execution and redirection (`sudo` and `sudo tee`):** Shell redirection operators (`>` and `>>`) are processed by the current non-root shell *before* the target command runs, so `sudo echo text > /root-owned-file` can fail with `Permission denied` even when `echo` runs under `sudo`. Piping into `sudo tee` (or `sudo tee -a` to append) runs `tee` with elevated privileges so it can write to restricted files.



### 2.4 File Searching and Inspection

Exercises practised locating files across directory trees with `find`, filtering lines by pattern with `grep`, and inspecting file contents using `cat`, `less`, `head`, and `tail`, alongside byte-by-byte comparison with `cmp`. Repository artifacts under `artifacts/file-management/` (such as `source/`, `source-backup/`, `backup/`, `processed/`, and `archive/`) and `artifacts/permissions-lab/` (such as `root-owned.txt`, `report.txt`, `private/secret.txt`, and `ownership-lab/`) reflect hands-on file and permission exercises.

#### Practical Walkthroughs (File Management & Permissions)

* **Searching, comparing, and managing files (`find`, `grep`, `head`, `tail`, `cp`, `mv`, `rm`, `cmp`):**
1. *Task:* Locate files, search text patterns, inspect file contents or slices, compare files, and copy, move/rename, or clean up test files and directories across `artifacts/file-management/`.
2. *Commands used:* `find`, `grep`, `head`, `tail`, `cp`, `mv`, `rm`, and `cmp`.
3. *Why appropriate:* Each command addresses a distinct step—discovering paths (`find`), matching lines (`grep`), sampling beginnings/ends (`head`/`tail`) or full contents (`cat`/`less`), verifying byte equality (`cmp`), and moving/copying/removing files in isolated lab folders.
4. *Observed result:* Exercised file lookup, pattern filtering, content inspection, and file/directory lifecycle operations across structured lab subdirectories.


* **Permissions, `umask`, ownership and privileged redirection (`umask`, `chmod`, `chown`, `chgrp`, `getent`, `groupadd`, `sudo tee`):**
1. *Task:* Inspect creation masks, adjust permissions and ownership, create groups/accounts, and write to restricted or root-owned files in `artifacts/permissions-lab/`.
2. *Commands used:* `umask`, `chmod`, `chown`, `chgrp`, `getent`, `groupadd`, `useradd`/`usermod`, and `sudo tee`.
3. *Why appropriate:* Combines permission bit inspection and updates, database verification (`getent`), and `sudo tee` so writes to restricted targets execute with elevated privileges rather than failing under shell redirection.
4. *Observed result:* Established how `umask` and `chmod` control file/directory modes, how `chown`/`chgrp` and `getent` manage/verify ownership and groups, and how `sudo tee` writes to root-owned targets such as `artifacts/permissions-lab/root-owned.txt`.





### 2.5 Practice Status

All planned file management, permission, ownership, user/group administration, and privileged redirection exercises for this section were practised during the hands-on sessions, supported by the lab files and records in the repository.

### 2.6 Evidence

* **Section Screenshots:**
* `screenshots/Section-2-File-Management/01-find-grep-head-tail-cp-mv-rm.png` — Searching, content inspection, and file copy/move/delete exercises.
* `screenshots/Section-2-File-Management/02-permissions-umask-and-chmod.png` — Permission modes and default `umask` inspection/modification.
* `screenshots/Section-2-File-Management/03-chown-chgrp-and-privileged-redirection.png` — File/group ownership changes (`chown`, `chgrp`) and privileged output redirection (`sudo tee`).
* `screenshots/Section-2-File-Management/04-ownership-and-users-groups-getent-groupadd.png` — User/group database queries (`getent`) and group creation (`groupadd`).


* **Supplementary Screenshots:**
* `screenshots/01-file-management.png` — Earlier file management lab capture.
* `screenshots/03b-permissions-admin.png` — Earlier permissions and administrative operations capture.


* **Repository Artifacts:**
* `artifacts/file-management/` (`source/`, `source-backup/`, `backup/`, `processed/`, `archive/`) and `artifacts/permissions-lab/` (`root-owned.txt`, `report.txt`, `private/secret.txt`, `ownership-lab/`).


## 3. Directory Navigation and Filesystem

### 3.1 Objective and Project Alignment

Build practical confidence navigating the Linux filesystem using absolute and relative paths, creating and inspecting nested directory structures with `mkdir -p`, and understanding the purpose, organisation, permissions, and operational roles of standard Linux directories—including `/etc`, `/var`, `/var/log`, and `/tmp`—as well as symbolic links, log inspection, and log rotation in support of the **Linux and Command Line Mastery** project.

### 3.2 Commands Practised

| Command | Purpose |
| --- | --- |
| `pwd` | Display the current working directory. |
| `cd` | Change the current working directory. |
| `cd ..` | Move to the parent directory. |
| `cd ../..` | Move up two directory levels. |
| `cd -` | Return to the previous working directory. |
| `cd /` | Navigate to the filesystem root. |
| `cd ~` | Navigate to the current user's home directory. |
| `ls` | List directory contents. |
| `ls -la` | Display hidden entries and detailed file metadata. |
| `ls -lah` | Display detailed listings with human-readable file sizes. |
| `ls -ld` | Display permissions and ownership metadata for directories themselves rather than their contents. |
| `mkdir -p` | Create nested directory structures, including missing parent directories. |
| `find` | Search for files and directories using names, types, depth, and other criteria. |
| `tree` | Display directory structures hierarchically. |
| `cat` | Display file contents, including configuration files. |
| `tail` | Display the last lines of a file. |
| `grep` | Search text for matching patterns. |
| `zgrep` | Search compressed files using grep-style patterns. |
| `sudo` | Execute authorised commands with elevated privileges. |

### 3.3 Understanding Linux Paths

Linux uses a hierarchical filesystem structure that begins at the root directory `/`. Commands such as `cd` and `pwd` operate relative to the current working directory unless an absolute path is supplied.

#### Absolute Paths

An absolute path starts from the filesystem root `/` and identifies a location independently of the current working directory.

```bash
cd /var/log

```

This navigates directly to `/var/log`, regardless of the directory from which the command is executed.

#### Relative Paths

A relative path is interpreted from the current working directory.

```bash
cd ../..

```

This moves two directory levels upward from the current location.

#### Important Navigation Symbols

| Symbol | Meaning |
| --- | --- |
| `/` | Filesystem root. |
| `~` | Current user's home directory. |
| `.` | Current directory. |
| `..` | Parent directory. |
| `-` | Previous working directory when used with `cd`. |

#### Understanding `cd ..` vs. `cd -`

These commands perform different operations:

* `cd ..` moves to the parent directory in the filesystem hierarchy.
* `cd -` returns to the previous working directory.

```bash
cd /var
cd /tmp
cd -

```

The final command returns to `/var`, rather than moving to `/`. Understanding this distinction helps when navigating between project directories and system locations.

### 3.4 Practical Navigation Exercises

All navigation and directory-creation exercises in this section were practised hands-on in the Ubuntu WSL2 environment.

#### 1. Navigating Project Directories and Creating Nested Structures

Starting from:

```text
~/linux-command-line-practice/artifacts/file-management

```

Executed:

```bash
cd ../..
pwd

```

The navigation moved two directory levels upward to the project root:

```text
/home/victor/linux-command-line-practice

```

Nested directory structures were also created and inspected using `mkdir -p`, `ls -la`, and `tree` (including project and lab paths such as `artifacts/navigation/projects/webapp/logs/`).

**What this demonstrated:**

* Relative paths can navigate directory hierarchies without specifying the complete path.
* Each `..` represents one parent-directory transition.
* `mkdir -p` creates parent directories automatically when building nested structures, and `pwd` verifies the resulting location.

#### 2. Switching Between Directories

Executed:

```bash
cd /tmp
cd -

```

The second command returned to the previous working directory. This demonstrated how `cd -` switches between two working locations without repeatedly typing their absolute paths.

#### 3. Exploring the Filesystem Root

Executed:

```bash
cd /
ls -lah

```

The root directory contains the main directories and mount points that form the Linux filesystem hierarchy. The `-a` option includes hidden entries, while `-h` displays file sizes in human-readable units.

#### 4. Exploring `/etc`

Executed:

```bash
cd /etc
ls

```

Observed that `/etc` contains system-wide configuration files and directories that define how services, applications, and other system components behave.

#### 5. Exploring `/var` and `/tmp`

Executed:

```bash
cd /var
ls -lah

```

Observed directories including `backups/`, `cache/`, `crash/`, `lib/`, `local/`, `log/`, `mail/`, `opt/`, `spool/`, and `tmp/`, along with symbolic links:

```text
lock -> /run/lock
run  -> /run

```

A symbolic link is a filesystem object that references another file or directory so it can be accessed through an alternative path. Directory permission checks (`ls -ld`) across `/etc`, `/var`, and `/tmp` also highlighted `/tmp`'s sticky bit (`drwxrwxrwt`), which allows shared temporary writes while preventing users from deleting or renaming files owned by others.

#### 6. Searching the `/var` Directory

Executed:

```bash
find . -maxdepth 1 -type f

```

Observed:

```text
./.updated

```

This command searches for regular files directly inside the current directory without descending into child directories.

| Component | Meaning |
| --- | --- |
| `find` | Search for filesystem entries. |
| `.` | Start searching from the current directory. |
| `-maxdepth 1` | Limit the search to the starting directory level. |
| `-type f` | Return regular files only. |

This demonstrated how `find` narrows a filesystem search using location, depth, and file type.

### 3.5 Understanding the Linux Filesystem Hierarchy

Linux organises files and directories according to established filesystem conventions. Understanding these locations makes it easier to navigate systems, locate configuration, investigate logs, and troubleshoot applications.

| Directory | Purpose |
| --- | --- |
| `/` | Root of the entire filesystem hierarchy. |
| `/home` | Contains users' personal home directories and files. |
| `/root` | Home directory of the root administrative account. |
| `/etc` | Stores system-wide configuration files. |
| `/var` | Stores variable operational data that changes during system operation. |
| `/var/log` | Contains system and application logs. |
| `/var/cache` | Stores regenerable cached application data. |
| `/var/lib` | Stores persistent application and system state. |
| `/var/spool` | Holds queued work awaiting processing. |
| `/tmp` | Stores temporary files used by applications and processes. |
| `/run` | Stores volatile runtime information, commonly cleared during boot. |
| `/usr` | Contains many user-space applications, libraries, and shared resources. |
| `/opt` | Provides a location for optional or separately installed software. |
| `/dev` | Contains device files representing hardware and virtual devices. |
| `/proc` | Virtual filesystem exposing process and kernel information. |
| `/sys` | Virtual filesystem exposing kernel, device, and hardware information. |

#### Understanding `/etc` vs. `/var`

* `/etc` primarily stores configuration describing how applications and services should operate (for example, `/etc/rsyslog.conf`).
* `/var` stores operational data generated or changed while the system is running (for example, `/var/log/syslog`).

This distinction is useful when troubleshooting whether a problem originates from configuration or runtime behaviour.

### 3.6 Practical Investigation: `/var/log`

The `/var/log` directory was inspected to understand how Linux records system events, application activity, authentication operations, and package-management activity.

```bash
ls -lah /var/log

```

Observed files and directories included `syslog`, `auth.log`, `kern.log`, `dmesg`, `dpkg.log`, `alternatives.log`, `bootstrap.log`, `journal/`, `apt/`, and `unattended-upgrades/`.

| Log | Purpose |
| --- | --- |
| `syslog` | General system and service events. |
| `auth.log` | Authentication and privilege-related activity. |
| `kern.log` | Kernel-related messages. |
| `dmesg` | Kernel ring-buffer messages, commonly associated with hardware and system initialisation. |
| `dpkg.log` | Package installation, removal, and configuration activity recorded by DPKG. |
| `alternatives.log` | Changes managed by the alternatives system. |

### 3.7 Understanding File Permissions and Ownership

While inspecting `/var/log`, the following authentication-log entry was observed:

```text
-rw-r----- 1 syslog adm 5.3K auth.log

```

| Component | Meaning |
| --- | --- |
| `-` | Regular file. |
| `rw-` | Owner has read and write permissions. |
| `r--` | Group has read permission. |
| `---` | Other users have no permissions. |
| `syslog` | File owner. |
| `adm` | Group ownership. |

The permission string `rw-r-----` (`640`) allows the owner (`syslog`) to read and modify the file, allows group members (`adm`) to read it, and denies access to other users through permission bits. Because logs can contain sensitive usernames, commands, and service events, restricted access protects log integrity and privacy. For authorised administrative access, `sudo` runs the command with elevated privileges:

```bash
sudo tail -n 15 /var/log/auth.log

```

### 3.8 Practical Log Investigation

All log inspection and filtering exercises below were practised in the lab environment.

#### 1. Inspecting Recent System Logs

```bash
tail -n 15 /var/log/syslog

```

`tail` shows recent entries quickly without printing large log files in full, making it a primary starting point when investigating unexpected service or system behaviour.

#### 2. Filtering System Errors

```bash
grep -i "error" /var/log/syslog | tail -n 10

```

* `grep` searches input for matching text; `-i` makes matching case-insensitive; `"error"` sets the pattern; `|` pipes output to `tail -n 10` to show the last ten matches.
* Observed WSL-related messages included `CheckConnection: getaddrinfo() failed`, `ConfigApplyWindowsLibPath`, `InitializeLogging`, `failed to collect insights`, and recurring WSL Ubuntu Pro service warnings when the Windows agent address file was not found.
* Error lines must be evaluated in context—looking at component, frequency, surrounding lines, and actual impact—rather than assuming the entire system is down.

#### 3. Inspecting Authentication Logs

```bash
sudo tail -n 15 /var/log/auth.log

```

Observed `CRON` and `sudo` session activity, including user `victor` running a privileged command (`TTY=/dev/pts/0`, `PWD=/var`, `USER=root`, `COMMAND=/usr/bin/tail -n 15 /var/log/auth.log`).

#### 4. Searching for Authentication Failures

```bash
sudo grep -iE "failed|failure|invalid|authentication failure" /var/log/auth.log | tail -n 15
sudo grep -iE "failed|failure|invalid|authentication failure" /var/log/auth.log.1

```

* `-E` enables extended regular expressions so `|` inside quotes acts as alternation (`failed` or `failure` or `invalid` or `authentication failure`).
* No matching failure lines appeared in those inspected files. Absence of matches in a single log or current window does not prove no unauthorised attempts occurred elsewhere, under different wording, or in older rotated archives.

### 3.9 Understanding Log Rotation and Investigating Configuration

Log rotation prevents log files from growing without bound and exhausting disk space by rotating, retaining, and compressing logs according to policies in `/etc/logrotate.d/`.

#### 1. Inspecting Rotated Logs and Searching Compressed Archives

```bash
ls -lh /var/log/auth.log*
sudo zgrep -iE "failed|failure|invalid" /var/log/auth.log.2.gz

```

* `ls -lh /var/log/auth.log*` showed active `auth.log` and rotated `auth.log.1`.
* `zgrep` searches compressed files directly without manual extraction. Running `zgrep` against `/var/log/auth.log.2.gz` returned `gzip: /var/log/auth.log.2.gz: No such file or directory` because that compressed archive did not exist on the system, reinforcing the need to verify available rotated files before querying specific archives.

#### 2. Inspecting `/etc/logrotate.d/` and `/etc/logrotate.d/rsyslog`

Listing `/etc/logrotate.d/` showed service rules such as `alternatives`, `apport`, `apt`, `btmp`, `chrony`, `dpkg`, `rsyslog`, `ubuntu-pro-client`, `unattended-upgrades`, and `wtmp`. Inspecting `/etc/logrotate.d/rsyslog` showed rules for `/var/log/syslog`, `/var/log/mail.log`, `/var/log/kern.log`, `/var/log/auth.log`, `/var/log/user.log`, and `/var/log/cron.log`:

| Directive | Meaning |
| --- | --- |
| `rotate 4` | Retain up to four rotated generations (separate from the active log). |
| `weekly` | Schedule rotation weekly. |
| `missingok` | Do not report an error when a specified log file is missing. |
| `notifempty` | Do not rotate an empty log file. |
| `compress` | Compress rotated logs. |
| `delaycompress` | Delay compression of the most recently rotated log until a subsequent rotation cycle (for example, keeping `.1` uncompressed while older generations become `.2.gz`, `.3.gz`). |
| `sharedscripts` | Run the post-rotation script once for the group of logs rather than once per file. |
| `postrotate` / `endscript` | Wrap commands executed after rotation, such as `/usr/lib/rsyslog/rsyslog-rotate` so `rsyslog` reopens file descriptors cleanly instead of writing to a rotated file descriptor. |

### 3.10 Observations, DevOps Relevance, and Completion Status

* **Key takeaways:** Practised absolute vs. relative paths, `cd ..` / `cd ../..` / `cd -` / `cd /` / `cd ~`, `pwd`, `mkdir -p`, `ls` / `ls -la` / `ls -lah` / `ls -ld`, `tree`, `find`, symbolic links, `/etc` vs. `/var` and `/tmp`, `tail`, `grep`, `sudo`, `zgrep`, and `logrotate` configuration.
* **DevOps relevance:** Essential for locating service configurations, navigating application/deployment trees, inspecting application and authentication logs, preventing disk exhaustion from logs, and troubleshooting incidents on Linux servers and cloud instances.
* **Practice status:** All directory navigation, filesystem hierarchy, log investigation, and logrotate exercises in Section 3 were practised hands-on and are ready for submission.

### 3.11 Evidence

* **Section Screenshots:**
* `screenshots/Section-3-Directory-Navigation-and-Filesystem/01-ls-la-project-subdirectories.png` — Hidden files and detailed directory metadata (`ls -la`).
* `screenshots/Section-3-Directory-Navigation-and-Filesystem/02-tree-project-hierarchy.png` — Hierarchical project layout (`tree`).
* `screenshots/Section-3-Directory-Navigation-and-Filesystem/03-cd-relative-navigation-and-tree-summary.png` — Relative path navigation (`cd ..`, `cd ~`) and directory summary.
* `screenshots/Section-3-Directory-Navigation-and-Filesystem/04-filesystem-etc-var-tmp-inspection.png` — Inspection of `/etc`, `/var`, and `/tmp` permissions, ownership, and sticky bit (`ls -ld`).


* **Supplementary Screenshot:**
* `screenshots/02-directory-navigation.png` — Earlier directory navigation lab capture.


* **Repository Artifacts:**
* `artifacts/navigation/projects/webapp/logs/`

## 4. System Monitoring and Administration

### 4.1 Objective

Develop practical skills for monitoring system resources and processes, managing `systemd` services, inspecting system logs, and querying installed packages on Ubuntu.

### 4.2 Commands Practised

| **Command** | **Purpose** |
| --- | --- |
| `ps aux` | Snapshot running processes across users, including CPU/memory usage and full commands. |
| `top` | Monitor live processes and system resource consumption interactively. |
| `free -m` | Display physical memory (RAM) and swap usage in megabytes. |
| `df -h` | Report filesystem disk space usage and free capacity in human-readable units. |
| `uptime` | Show how long the system has been running and 1-, 5-, and 15-minute load averages. |
| `systemctl` | Inspect and control `systemd` units and services. |
| `journalctl` | Query and filter logs recorded by `systemd-journald`. |
| `du -sh` | Calculate summarised disk usage (`-s`) in human-readable format (`-h`) for a directory or path. |
| `apt list --installed` | List packages installed through APT on the system. |
| `dpkg -l` | Display package status and details from the local `dpkg` database. |

### 4.3 Process and Resource Monitoring

Resource inspection exercises focused on distinguishing short-term spikes from sustained bottlenecks:

- **Processes:** Using `ps aux` for a point-in-time process list and `top` for interactive observation of active tasks and resource consumers.

- **Memory and swap:** Checking RAM allocation, buffers/cache, and swap utilisation with `free -m` to spot memory pressure.

- **Storage capacity:** Checking mounted filesystem capacity with `df -h` and pinpointing heavy directories with `du -sh` (useful before services fail due to full disks or runaway logs).

- **Uptime and load average:** Reading `uptime` load averages alongside CPU core count and I/O/wait activity to judge whether load reflects compute saturation or processes waiting on I/O.

### 4.4 Service Management and System Logs

Exercises covered how `systemd` manages background services and integrates with logging:

- Inspecting service states and unit definitions using `systemctl`, including checking the `cron` service.

- Creating and managing a custom `linux-lab.service` unit, practising lifecycle operations (starting, stopping, and restarting) and observing how unit behaviour is reflected in logs.

- Querying service and system events with `journalctl` and reviewing journal maintenance/restart/cleanup behaviour.

### 4.5 Package Management

#### APT vs. DPKG

On Debian and Ubuntu systems, **APT** (`apt`, `apt-cache`, `apt-get`) and **DPKG** (`dpkg`) operate at different layers of package management:

- **APT (high-level package manager):** Resolves dependency trees across configured software repositories, downloads packages, coordinates upgrades/removals across interdependent packages, and maintains repository metadata.

- **DPKG (low-level package manager):** Installs, configures, queries, or removes individual `.deb` package archives directly on the local system and tracks installed package states in the local `dpkg` database without automatically resolving remote repository dependencies.

#### Package Operations and Inventory

- **Package inventory and status inspection:** Used `apt list --installed` to list installed packages and `dpkg -l` to inspect package states. The `ii` status indicates that a package is selected for installation and is currently installed.

- **Package metadata inspection:** Used `apt show <package>` and `dpkg -s <package>` to inspect package descriptions, versions, dependencies, and installation status. APT provides repository-level package information, while DPKG reports the local package database state.

- **Package installation:** Practised installing packages through APT using `sudo apt install <package>` and installing local Debian package archives using `sudo dpkg -i <file.deb>`. APT resolves repository dependencies, whereas DPKG installs the specified local archive and may require dependency correction if packages are missing.

- **Package removal:** Practised `sudo apt remove <package>` to remove installed package software while generally retaining system-wide configuration files, and `sudo apt purge <package>` to remove package configuration files as well.

- **Package verification:** Used package queries to check installation state after package operations. The `tree` package was also inspected in the installed-package inventory.

These exercises demonstrated the distinction between repository-based package management with APT and direct package operations through DPKG.

### 4.6 Evidence

- Repository reference: `artifacts/permissions-lab/cowsay_3.03+dfsg2-8build1_all.deb`.

- Screenshot references: `screenshots/Section-4-System-Monitoring-and-Administration/01-journalctl-rsyslog-and-disk-usage.png`, `screenshots/Section-4-System-Monitoring-and-Administration/02-systemctl-cron-status-and-unit.png`, `screenshots/Section-4-System-Monitoring-and-Administration/03-systemd-custom-service-lifecycle.png`, `screenshots/Section-4-System-Monitoring-and-Administration/04-systemd-journal-restart-and-cleanup.png`, `screenshots/Section-4-System-Monitoring-and-Administration/05-ps-df-free-uptime-monitoring.png`, `screenshots/Section-4-System-Monitoring-and-Administration/06-uptime-load-average.png`, `screenshots/Section-4-System-Monitoring-and-Administration/07-apt-list-installed.png`, `screenshots/03a-system-monitoring.png`, and `screenshots/03b-permissions-admin.png`.

## 5. Networking Basics

### 5.1 Objective

Build foundational Linux networking skills for testing reachability, tracing name resolution, inspecting network interfaces and IP addresses, and checking listening sockets.

### 5.2 Commands Practised

| **Command** | **Purpose** |
| --- | --- |
| `ping` | Test reachability and round-trip latency using ICMP echo requests. |
| `ip addr` | Display network interfaces, link states, and assigned IPv4/IPv6 addresses. |
| `ss -tulnp` | List TCP (`-t`) and UDP (`-u`) listening (`-l`) sockets with numeric ports (`-n`) and process info (`-p`) where available. |
| `dig` | Query DNS servers directly for record types such as `A`, `AAAA`, and `MX`. |
| `cat` | Inspect host, resolver, and name-service configuration files. |
| `hostname` | Display or inspect the system hostname. |

### 5.3 Connectivity Testing

Exercises used `ping` to verify reachability, examine ICMP echo request/reply behaviour, and check command exit statuses to distinguish reachable hosts from unreachable targets or blocked ICMP traffic.

### 5.4 DNS and Name Resolution

Name resolution exercises examined both local overrides and DNS queries:

- Inspecting `/etc/resolv.conf` (name servers/search domains), `/etc/hosts` (static local hostname mappings), `/etc/nsswitch.conf` (lookup ordering across sources such as `files` and `dns`), and system `hostname`.

- Using `dig` to inspect `A` (IPv4), `AAAA` (IPv6), and `MX` (mail exchange) records.

- Distinguishing local hostname/hosts-file resolution from external DNS lookups, which helps diagnose environments where a service resolves locally but fails to query upstream DNS (or vice versa).

### 5.5 Network Interfaces and Sockets

Exercises inspected interfaces and open sockets:

- Using `ip addr` to identify loopback (`lo`) and Ethernet/virtual interfaces along with assigned addresses.

- Using `ss -tulnp` to inspect listening TCP/UDP ports and identify bound services—a core step when verifying whether a daemon is listening or troubleshooting port conflicts and firewall/reachability issues.

### 5.6 Evidence

- Screenshot references: `screenshots/Section-5-Networking-Basics/01-ping-icmp-and-exit-status.png`, `screenshots/Section-5-Networking-Basics/02-dns-resolv-hosts-nsswitch-and-hostname.png`, `screenshots/Section-5-Networking-Basics/03-dig-dns-records-a-aaaa-mx.png`, `screenshots/Section-5-Networking-Basics/05-ping-and-resolver-diagnostics.png`, `screenshots/Section-5-Networking-Basics/07-ip-addr-and-ss-listening-sockets.png`, and `screenshots/04-networking-basics.png`.

## 6. Pipes, Redirection and Text Processing

### 6.1 Objective

Develop practical skills in connecting commands with pipes, controlling standard I/O streams via redirection, separating error output, and filtering or transforming text for log analysis and automation.

### 6.2 Commands Practised

| **Command / Operator** | **Purpose** |
| --- | --- |
| `\|` | Pipe standard output of one command into the standard input of the next. |
| `>` | Redirect standard output to a file, overwriting existing content. |
| `>>` | Append standard output to the end of a file. |
| `2>` | Redirect standard error (fd 2) to a file, overwriting existing content. |
| `2>>` | Append standard error (fd 2) to a file. |
| `&>` | Redirect both standard output and standard error together (Bash). |
| `/dev/null` | Null device that discards written output and returns EOF on read. |
| `wc` | Count lines (`-l`), words (`-w`), and bytes/characters (`-c`/`-m`). |
| `grep` | Filter lines matching regular expressions or text patterns. |
| `awk` | Scan and process structured text lines and fields. |
| `tr` | Translate, squeeze, or delete characters from standard input. |
| `sort` | Sort lines of text. |
| `uniq` | Filter or count adjacent matching lines (typically paired with `sort`). |
| `tee` | Write input to one or more files while simultaneously passing it to stdout. |
| `sed` | Perform stream-based text substitutions and edits. |

### 6.3 Standard Streams and Redirection

Every Linux process starts with three standard file descriptors: **stdin** (fd `0`), **stdout** (fd `1`), and **stderr** (fd `2`). Separating `stdout` from `stderr` prevents diagnostic messages from polluting data files or downstream pipeline inputs.

In a practical experiment, the following command redirected normal output and error output into separate files:

```bash
ls /etc /directory_that_does_not_exist > output.log 2> errors.log
```

This demonstrates how standard output and standard error can be captured independently.

To capture both streams in one file, the following command was also practised:

```bash
ls /etc /directory_that_does_not_exist > combined.log 2>&1
```

The order matters: `> combined.log` redirects standard output first, and `2>&1` then redirects standard error to the same destination as standard output.

**Observed behaviour:**

- Valid listing output for `/etc` was written to `output.log` (`stdout`).
- The error message for `/directory_that_does_not_exist` was written separately to `errors.log` (`stderr`).
- Additional exercises practised appending (`>>`, `2>>`), combined redirection (`&>`), discarding noise via `/dev/null`, and checking exit statuses. Log artifacts such as `artifacts/pipes-redirection-lab/app.log`, `combined.log`, `combined-short.log`, `errors-only.log`, `errors.log`, `output.txt`, `topics.txt`, `artifacts/server_events.log`, `artifacts/stderr_capture.log`, `artifacts/error_summary.txt`, `docs/output.log`, and `docs/errors.log` reflect redirection and text-processing work in the repository.

### 6.4 Pipes and Text Processing

Exercises chained commands with `|` to filter, count, reshape, and summarise text:

- Counting and pattern filtering with `wc` and `grep`.

- Field extraction and formatting with `awk`, character translation with `tr`, ordering with `sort`, deduplicating adjacent lines with `uniq`, branching streams with `tee`, and pattern replacement with `sed`.

`uniq` only detects adjacent repeated lines. To count duplicates across an entire unsorted input, use:

```bash
sort file.txt | uniq -c
```

#### Evidence Note on `topics.txt` Match Count

A discrepancy exists between the historical run recorded in `screenshots/Section-6-Pipes-Redirection-and-Text-Processing/01-redirection-stdout-stderr-devnull-and-wc-grep.png`—where `grep "DevOps" topics.txt | wc -l` yielded `5`—and the preserved `artifacts/pipes-redirection-lab/topics.txt` file, which contains only one matching entry. Because `topics.txt` was likely edited or overwritten across later lab iterations or file updates, the earlier multi-line contents at the time of that run are no longer preserved in the artifact, so the limitation is noted directly rather than guessed.

### 6.5 Evidence

- Repository artifacts in `artifacts/pipes-redirection-lab/` and log files under `artifacts/` and `docs/`.

- Screenshot references: `screenshots/Section-6-Pipes-Redirection-and-Text-Processing/01-redirection-stdout-stderr-devnull-and-wc-grep.png`, `screenshots/Section-6-Pipes-Redirection-and-Text-Processing/02-awk-tr-sort-uniq-tee-and-sed.png`, and `screenshots/05-pipes-and-redirection.png`.

## 7. Shell Scripting

### 7.1 Objective

Apply Linux CLI fundamentals to write maintainable Bash scripts using variables, arguments, conditionals, loops, functions, error handling, and explicit exit codes.

### 7.2 Concepts and Commands Practised

| **Concept / Command** | **Purpose** |
| --- | --- |
| Variables | Store reusable configuration values, paths, and state inside a script. |
| Positional parameters | Access command-line arguments passed to a script (`$1`, `$2`, `$#`, `$@`). |
| Functions | Group reusable logic into modular, readable blocks. |
| Conditionals | Branch execution based on test expressions and exit statuses (`if`/`elif`/`else`, `case`). |
| Loops | Repeat tasks across lists, ranges, or files (`for`, `while`). |
| `echo` | Print text and expanded variables to standard output. |
| `read` | Read interactive user input from standard input. |
| `exit` | Exit the script with a specific numeric status code (`0` for success, non-zero for failure/usage errors). |
| `$?` | Inspect the exit status of the most recently executed command. |
| `date` | Format timestamps for logs and reports. |
| `command -v` | Check whether an executable or command is available in `PATH`. |
| `bash -n` | Check script syntax without executing commands. |
| `set -euo pipefail` | Enables commonly used Bash strict-mode settings: `-u` treats unset variables as errors, `-e` exits on many unhandled command failures (subject to Bash's conditional and command-list exceptions), and `-o pipefail` makes a pipeline return a failure status when a command within it fails. |

### 7.3 Workspace Automation

A workspace setup script (`scripts/setup_workspace.sh`) was built to automate directory and file creation using variables, functions, and loops so workspace setup is repeatable rather than manual, alongside sample workspace artifacts such as `artifacts/workspace_demo/`, `artifacts/workspace test/`, and `artifacts/section7_test/`.

### 7.4 Service Checker Script

A service-checking script (`artifacts/shell-scripting-lab/service_checker.sh`, with accompanying `artifacts/shell-scripting-lab/service_checker.log` and `docs/service_checker.log`) was created to inspect requested system services and log results:

- Accepts service names via command-line arguments and checks service status using system service commands.

- Evaluates service states with conditional logic and writes timestamped log messages.

- Uses strict Bash settings, syntax checking via `bash -n`, explicit exit statuses, and a check for Docker CLI availability (`command -v`).

#### Historical vs. Current Service State Reporting

There is a clear distinction between an **inactive/stopped service** and a **missing service unit** in `systemd`:

- **Inactive / stopped service:** The unit file exists in `systemd` (so `systemd` recognises the unit), but the service process is currently stopped (`inactive`/`dead`), which an earlier script version/run reported as `Not running` (as seen in `screenshots/Section-7-Shell-Scripting/03-service-checker-exit-codes-syntax-and-logging.png`).

- **Service unit not found:** No matching `systemd` unit exists for the requested service name, which the current `artifacts/shell-scripting-lab/service_checker.sh` reports as `Service unit not found`.

Because `service_checker.sh` evolved during development, historical output messages (`Not running`) reflect earlier script behaviour, whereas `Service unit not found` reflects the current script's handling of unknown or non-existent units.

### 7.5 Exit Status Verification

Testing `service_checker.sh` across scenarios confirmed clear status reporting:

| **Test Case** | **Observed Result** |
| --- | --- |
| Check `cron` while running | Exit status `0` |
| Supply an invalid / non-existent service | Exit status `1` |
| Run without required arguments | Exit status `2` |
| Execute an incorrect script path | Shell-generated exit status `127` (command not found) |

### 7.6 Evidence

- Repository scripts and artifacts: `scripts/setup_workspace.sh`, `artifacts/shell-scripting-lab/service_checker.sh`, `artifacts/shell-scripting-lab/service_checker.log`, `docs/service_checker.log`, `artifacts/workspace_demo/`, `artifacts/workspace test/`, and `artifacts/section7_test/`.

- Screenshot references: `screenshots/Section-7-Shell-Scripting/01-setup-workspace-functions-and-loops.png`, `screenshots/Section-7-Shell-Scripting/02-workspace-logs-strict-mode-and-git-status.png`, `screenshots/Section-7-Shell-Scripting/03-service-checker-exit-codes-syntax-and-logging.png`, `screenshots/Section-7-Shell-Scripting/04-service-checker-and-docker-cli-checks.png`, and `screenshots/06-shell-scripting.png`.

## 8. Troubleshooting and Problem Solving

### 8.1 Objective

Build a disciplined troubleshooting workflow for diagnosing and fixing command, path, argument, scripting, environment, and Git issues using actual outputs and exit codes.

### 8.2 Troubleshooting Areas

- **File and directory paths:** Diagnosing wrong paths, missing files/directories, and non-directory path errors (for example, `artifacts/not_a_directory`).

- **Command arguments:** Catching missing or invalid flags/arguments and checking expected usage.

- **Command execution:** Reading error messages carefully and distinguishing full failure from partial completion.

- **Exit statuses:** Using `$?` and script return codes to confirm whether commands or pipeline steps succeeded or failed.

- **Shell scripting:** Resolving syntax errors, bad inputs, execution issues, and unexpected exit codes.

- **Git operations:** Handling non-fast-forward push rejections when remote branches have commits not yet local, and resolving sync cleanly (such as pulling/rebasing before pushing).

- **WSL environment:** Investigating WSL2/Ubuntu messages and environment quirks during hands-on work.

### 8.3 Troubleshooting Approach

1. Identify the exact command or script step that produced unexpected behaviour.

2. Read the full error message and note which stream (`stdout`/`stderr`) carried it.

3. Verify command syntax, arguments, and target file/directory paths.

4. Inspect relevant files, permissions, service states, or environment settings.

5. Check `$?` and output details to narrow down the root cause.

6. Apply a targeted fix and re-run the command.

7. Confirm the expected result and clean state.

### 8.4 Lessons Learned

- An error message does not always mean an entire command failed; multi-target commands can succeed on valid items while failing on invalid ones.

- Exit statuses provide reliable signals for automation and verification beyond visual inspection alone.

- Valid commands still fail when given bad paths, missing arguments, or insufficient permissions.

- Non-fast-forward Git push rejections happen when the remote history is ahead of local history; syncing local changes with remote commits before pushing avoids clobbering work.

- Diagnosing from observed output prevents guesswork, and re-running commands blindly without understanding the cause can compound problems.

### 8.5 Evidence

Troubleshooting is reflected across the terminal exercises, scripts (`scripts/setup_workspace.sh`, `artifacts/shell-scripting-lab/service_checker.sh`), log and lab artifacts (`artifacts/not_a_directory`, `artifacts/stderr_capture.log`, `artifacts/error_summary.txt`, `docs/errors.log`, `docs/output.log`), and session records throughout the project; there is no standalone screenshot directory for Section 8.

## 9. Project Summary

### 9.1 Project Overview

The **Linux and Command Line Mastery** project builds practical command-line proficiency in Ubuntu on WSL2 across fundamentals, file and permission management, system monitoring and services, networking, streams and text processing, Bash scripting, and troubleshooting.

### 9.2 Skills Developed

- **Linux Fundamentals:** Filesystem navigation, file/directory operations, permissions, ownership, user/group management, and privileged commands.

- **System Administration:** Process and resource monitoring (`ps`, `top`, `free`, `df`, `du`, `uptime`), `systemd` service management, `journalctl` log inspection, and APT/DPKG package checks.

- **Networking:** Connectivity testing (`ping`), DNS and local resolver inspection (`dig`, `/etc/hosts`, `/etc/resolv.conf`, `/etc/nsswitch.conf`, `hostname`), and interface/socket inspection (`ip addr`, `ss`).

- **Command-Line Data Processing:** Stream redirection (`>`, `>>`, `2>`, `2>>`, `&>`, `/dev/null`), pipelines (`|`), and text utilities (`grep`, `wc`, `awk`, `tr`, `sort`, `uniq`, `tee`, `sed`).

- **Bash Scripting and Automation:** Variables, positional parameters, functions, conditionals, loops, exit codes, `command -v`, `bash -n`, `set -euo pipefail`, workspace setup automation, and service checking.

- **Troubleshooting:** Systematic diagnosis using error messages, exit statuses, path/permission checks, and Git synchronisation workflows.

### 9.3 Practical Project Evidence

The repository collection contains:

- Documentation (`README.md` and `docs/notes.md`).

- Scripts (`scripts/setup_workspace.sh` and `artifacts/shell-scripting-lab/service_checker.sh`).

- Exercise artifacts and logs under `artifacts/` and `docs/`.

- 27 section-organised screenshots across `screenshots/Section-1-Learning-Environment` through `screenshots/Section-7-Shell-Scripting`, plus 7 earlier supplementary screenshots in `screenshots/`.
