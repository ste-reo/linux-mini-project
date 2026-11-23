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
- `mkdir -v`: Display directory creation messages.
- `ls -lah`: Inspect files, directories, permissions, ownership and human-readable sizes.
- `tree`: Display directory hierarchies.
- `cp`: Copy files.
- `cp -r`: Recursively copy directories.
- `cp -i`: Request confirmation before overwriting.
- `cp -v`: Display copy operations.
- `cp -p`: Preserve file attributes where possible.
- `mv`: Move and rename files and directories.
- `rm -i`: Delete files with confirmation.
- `find`: Locate files and directories.
- `grep`: Search file contents.
- `grep -n`: Display matching line numbers.
- `head`: Inspect the first lines of a file.
- `tail`: Inspect the last lines of a file.
- `cat`: Display file contents.
- `cmp`: Compare two files byte by byte.

### Workspace Structure
The file-management workspace is located at:
`artifacts/file-management/`

Its existing directories serve the following purposes:
- `source/`: Original application and error logs.
- `backup/`: Backup copies of log files.
- `archive/`: Files retained for archival purposes.
- `processed/`: Workspace for files undergoing processing.

Created the `processed/` directory using:
```bash
mkdir -vp artifacts/file-management/processed
