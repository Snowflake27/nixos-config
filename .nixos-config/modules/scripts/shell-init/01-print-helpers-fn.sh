print-icon() {
    [ -z "$1" ] && return

    local icon="$1"

    # Strip all spaces from head and tail
    icon="${icon#"${icon%%[![:space:]]*}"}"
    icon="${icon%"${icon##*[^[:space:]]}"}"

    if [ -n "$icon" ]; then
        printf "%s " "$icon"
    fi
}

print-decorated-message() {
    local icon="$1"
    local message="$2"
    local color="$3"

    if [ -n "$color" ]; then
        printf "%s" "$color"
    fi

    print-icon "$icon"
    printf "%s" "$message"
    printf "%s\n" "$COLOR_RESET"
}

print-separator() {
	echo "${COLOR_MUTED}-------------------------------------------------------------${COLOR_RESET}"
	echo ""
}