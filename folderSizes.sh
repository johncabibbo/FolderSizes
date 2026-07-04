#!/opt/homebrew/bin/bash
# =============================================================================
# Filename: folderSizes.sh
# Project: File Sizes
# Version: 1.3
# Last Modified Date: 2026-04-01
# Category: File Management
# OS: Mac
# Maintainer: Cloud Box 9 Inc.
# -----------------------------------------------------------------------------
# Description:
#   Lists subfolder sizes within a given directory, including human-readable
#   size, size in bytes (with commas), file count, and folder name.
#
# Usage:
#   folderSizes.sh [-a] [-s] [FOLDER]
#   (Defaults to current directory if FOLDER is omitted)
#
# Options:
#   -a   Sort alphabetically by folder name (default)
#   -s   Sort by size, largest first
#   -h   Show help and usage
#
# Example:
#   folderSizes.sh /Volumes/CB9-13Media/BPA_Media2025
#   folderSizes.sh -s ~/Documents
#   bash ~/Documents/script/fileManagement/folderSizes.sh -a ~/Documents
# -----------------------------------------------------------------------------
# Revision History:
# -----------------------------------------------------------------------------
# v1.3 (2026-04-01)
#   - Added -h flag: displays formatted help screen with usage and options
# -----------------------------------------------------------------------------
# v1.2 (2026-04-01)
#   - Added -a (alphabetical) and -s (by size, largest first) sort options
#   - Default sort remains alphabetical
#   - Header now shows active sort mode in page detail
#   - Legend line added below header showing available sort options
# -----------------------------------------------------------------------------
# v1.1 (2026-04-01)
#   - CB9 compliant: added dynamic-width header/footer, ANSI colors, copyright
#   - Updated file header to CB9 standard format with revision history
# -----------------------------------------------------------------------------
# v1.0 (original)
#   - Initial version: list subfolder sizes with HR size, bytes, file count
# =============================================================================

SCRIPT_NAME="Folder Sizes"
VERSION="1.2"

# --------------------------
# ANSI Colors
# --------------------------
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
CYAN='\033[0;36m'
BRIGHT_CYAN='\033[1;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
RED='\033[0;31m'

# --------------------------
# Terminal width
# --------------------------
TERM_WIDTH=$(tput cols 2>/dev/null || echo 100)

sep_line() {
    printf '%*s' "$TERM_WIDTH" '' | tr ' ' '='
    printf '\n'
}

# --------------------------
# Header
# --------------------------
print_header() {
    local page_detail="$1"
    printf '\n'
    sep_line
    printf " ${BRIGHT_CYAN}${SCRIPT_NAME}${RESET} ${DIM}v${VERSION}${RESET}"
    if [ -n "$page_detail" ]; then
        printf " ${GRAY}[${page_detail}]${RESET}"
    fi
    printf '\n'
    sep_line
}

# --------------------------
# Footer
# --------------------------
print_footer() {
    sep_line
    printf " ${DIM}Copyright © 2026 Cloud Box 9 Inc. All rights reserved.${RESET}\n"
}

# --------------------------
# Exit screen
# --------------------------
exit_screen() {
    clear
    sep_line
    printf " ${BRIGHT_CYAN}${SCRIPT_NAME}${RESET} ${DIM}v${VERSION}${RESET}\n"
    sep_line
    printf '\n'
    printf " ${GRAY}${SCRIPT_NAME} exiting...${RESET}\n"
    printf '\n'
    printf " ${DIM}Copyright © 2026 Cloud Box 9 Inc. All rights reserved.${RESET}\n"
    printf '\n'
    sep_line
}

# --------------------------
# Help screen
# --------------------------
print_help() {
    print_header "Help"
    printf '\n'
    printf " ${YELLOW}USAGE${RESET}\n"
    printf "   folderSizes.sh ${CYAN}[OPTIONS]${RESET} ${CYAN}[FOLDER]${RESET}\n"
    printf '\n'
    printf "   Lists the size of each subfolder within FOLDER.\n"
    printf "   Defaults to the current directory if FOLDER is omitted.\n"
    printf '\n'
    printf " ${YELLOW}OPTIONS${RESET}\n"
    printf "   ${CYAN}-a${RESET}   Sort alphabetically by folder name ${DIM}(default)${RESET}\n"
    printf "   ${CYAN}-s${RESET}   Sort by size, largest first\n"
    printf "   ${CYAN}-h${RESET}   Show this help screen\n"
    printf '\n'
    printf " ${YELLOW}EXAMPLES${RESET}\n"
    printf "   ${DIM}folderSizes.sh${RESET}                    Current directory, alphabetical\n"
    printf "   ${DIM}folderSizes.sh -s ~/Documents${RESET}     Sort by size, largest first\n"
    printf "   ${DIM}folderSizes.sh -a /Volumes/Media${RESET}  Explicit alphabetical sort\n"
    printf '\n'
    printf " ${YELLOW}OUTPUT COLUMNS${RESET}\n"
    printf "   ${CYAN}Size (HR)${RESET}     Human-readable size  ${DIM}(e.g. 1.2G, 340M)${RESET}\n"
    printf "   ${CYAN}Size (Bytes)${RESET}  Exact size in bytes with comma formatting\n"
    printf "   ${CYAN}File Count${RESET}    Total number of files inside the folder\n"
    printf "   ${CYAN}Folder${RESET}        Subfolder name\n"
    printf '\n'
    print_footer
    printf '\n'
}

# Trap Ctrl+C for clean exit
trap 'printf "\n"; exit_screen; exit 0' INT

# --------------------------
# Parse arguments
# --------------------------
SORT_MODE="alpha"
DIR=""

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -a) SORT_MODE="alpha"; shift ;;
        -s) SORT_MODE="size";  shift ;;
        -h) print_help; exit 0 ;;
        -*) printf "${RED}Error: Unknown option '$1'${RESET}\n"
            printf "Usage: folderSizes.sh [-a] [-s] [FOLDER]\n"
            exit 1 ;;
        *)  DIR="$1"; shift ;;
    esac
done

DIR="${DIR:-.}"

# Validate directory
if [ ! -d "$DIR" ]; then
    printf "${RED}Error: '${DIR}' is not a valid directory.${RESET}\n"
    exit 1
fi

# Resolve to absolute path for display
ABS_DIR=$(cd "$DIR" && pwd)

# Sort label for header
if [ "$SORT_MODE" = "size" ]; then
    SORT_LABEL="By Size"
else
    SORT_LABEL="Alphabetical"
fi

print_header "${ABS_DIR} | ${SORT_LABEL}"
printf '\n'

# Sort legend
printf " ${YELLOW}[-a]${RESET} ${GRAY}Alphabetical${RESET}   ${YELLOW}[-s]${RESET} ${GRAY}By Size (largest first)${RESET}\n"
printf '\n'

# Column header
printf " ${YELLOW}%-10s  %-20s  %-12s  %s${RESET}\n" \
    "Size (HR)" "Size (Bytes)" "File Count" "Folder"
printf " ${DIM}%-10s  %-20s  %-12s  %s${RESET}\n" \
    "----------" "--------------------" "------------" "------"

# Generate rows: prepend sort keys (tab-delimited) then display line
{
    shopt -s nullglob
    for d in "$DIR"/*/; do
        [ -d "$d" ] || continue

        # Human-readable size (macOS -sh)
        size_hr=$(du -sh "$d" 2>/dev/null | awk '{print $1}')

        # Bytes: use -sk (KB) then multiply by 1024
        size_bytes=$(du -sk "$d" 2>/dev/null | awk '{printf "%d", $1*1024}')

        # Insert commas every three digits
        size_bytes_commas=$(echo "$size_bytes" | rev | sed -E 's/.{3}/&,/g' | rev | sed 's/^,//')

        # Count files only (not directories)
        file_count=$(find "$d" -type f 2>/dev/null | wc -l | tr -d ' ')

        folder_name=$(basename "$d")

        # Output: SIZE_BYTES<TAB>FOLDER_NAME<TAB>DISPLAY_LINE
        printf "%s\t%s\t%-10s  %-20s  %-12s  %s\n" \
            "$size_bytes" "$folder_name" \
            "$size_hr" "$size_bytes_commas" "$file_count" "$folder_name"
    done
} | {
    if [ "$SORT_MODE" = "size" ]; then
        sort -t$'\t' -k1 -rn
    else
        sort -t$'\t' -k2
    fi
} | awk -F'\t' '{print $3}' | while IFS= read -r line; do
    printf " ${GREEN}%s${RESET}\n" "$line"
done

printf '\n'
print_footer
printf '\n'
