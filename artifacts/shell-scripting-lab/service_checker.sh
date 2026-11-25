#!/usr/bin/env bash

set -euo pipefail

LOG_FILE="./service_checker.log"
overall_status=0

# Validate arguments
if (( $# == 0 )); then
    echo "Usage: $0 service_name [service_name ...]" >&2
    exit 2
fi

# Log messages to terminal and file
log_msg() {
    local message="$1"
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$message" | tee -a "$LOG_FILE"
}

# Check an individual service
check_service() {
    local service="$1"
    local load_state

    load_state=$(systemctl show "$service.service" --property=LoadState --value 2>/dev/null || true)

    if [[ "$load_state" == "not-found" || -z "$load_state" ]]; then
        log_msg "$service: Service unit not found"
        overall_status=1
    elif systemctl is-active --quiet "$service.service"; then
        log_msg "$service: Running"
    else
        log_msg "$service: Stopped"
        overall_status=1
    fi
}

# Check every supplied service
for service in "$@"; do
    check_service "$service"
done

exit "$overall_status"
