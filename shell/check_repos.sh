#!/bin/bash

# color setting
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check git status with colored output
check_git_status() {
    local REPO_PATH="$1"
    local STATUS=""

    if [ -d "$REPO_PATH" ]; then
        # cd "$REPO_PATH" || return 1
        # temporarily change directory
        pushd "$REPO_PATH" >/dev/null || return 1

        git fetch >/dev/null 2>&1

        if ! git diff --quiet || ! git diff --cached --quiet; then
            STATUS="${RED}Uncommitted changes${NC}"
        else

            # Compare local and remote states
            LOCAL=$(git rev-parse @)
            REMOTE=$(git rev-parse @{u})
            BASE=$(git merge-base @ @{u})

            if [ "$LOCAL" = "$REMOTE" ]; then
                STATUS="${GREEN}Up-to-date${NC}"
            elif [ "$LOCAL" = "$BASE" ]; then
                STATUS="${RED}Behind remote (need pull)${NC}"
            elif [ "$REMOTE" = "$BASE" ]; then
                STATUS="${RED}Unpushed changes (need push)${NC}"
            else
                STATUS="${RED}Diverged${NC}"
            fi
        fi
        # return to original dir
        popd >/dev/null
    else
        STATUS="${RED}Path not found${NC}"
    fi

    echo -e "$STATUS: $REPO_PATH"

    # return 0 if up-to-date, else return
    [ "$STATUS" = "${GREEN}Up-to-date${NC}" ]
}

check_repos_on_start() {
    local REPO_PATHS=("$@")

    for REPO_PATH in "${REPO_PATHS[@]}"; do
        check_git_status "$REPO_PATH"
    done
}
check_repos_on_exit() {
    local REPO_PATHS=("$@")
    local ERROR_FOUND=0

    for REPO_PATH in "${REPO_PATHS[@]}"; do
        if ! check_git_status "$REPO_PATH"; then
            ERROR_FOUND=1
        fi
    done

    if [ "$ERROR_FOUND" -eq 1 ]; then
        trap - EXIT
        read -p "Errors found. Do you still want to exit? (y/n): " choice
        if [ "$choice" != "y" ]; then
            echo "Aborting exit."
            exec bash
        fi
    else
        echo -e "${GREEN}No errors, exiting.${NC}"
    fi
}

# Loop through each path in the array and check its status
TARGET_REPO_PATHS=(
    "/home/kato/10.git_repos/dotfiles/"
    "/home/kato/10.git_repos/easyvec/"
    "/home/kato/10.git_repos/molgeom/"
)

check_repos_on_start "${TARGET_REPO_PATHS[@]}"

trap 'check_repos_on_exit "${TARGET_REPO_PATHS[@]}"' EXIT

