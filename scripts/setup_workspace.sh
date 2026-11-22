#!/usr/bin/env bash
# Automates workspace directory creation and timestamped activity logging.
set -euo pipefail

BASE_DIR="${1:-./artifacts/workspace_demo}"
LOG_FILE="${BASE_DIR}/activity.log"
SUBDIRS=("raw" "processed" "reports")

# Validate target directory argument
if [[ -z "$BASE_DIR" ]]; then
  echo "Error: Target directory cannot be empty." >&2
  exit 1
fi

mkdir -p "$BASE_DIR"
touch "$LOG_FILE"

log_msg() {
  local level="$1"
  local message="$2"
  printf '[%s] [%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$level" "$message" | tee -a "$LOG_FILE"
}

log_msg "INFO" "Initializing workspace at '$BASE_DIR'"

# Loop through required subdirectories and create them if missing
for dir in "${SUBDIRS[@]}"; do
  target_path="${BASE_DIR}/${dir}"
  if [[ -d "$target_path" ]]; then
    log_msg "WARN" "Directory already exists: $target_path"
  else
    mkdir -p "$target_path"
    log_msg "INFO" "Created directory: $target_path"
  fi
done

log_msg "INFO" "Workspace setup complete."
