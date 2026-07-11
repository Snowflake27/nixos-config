nix-switch() {
	if [ -z "$1" ]; then
		echo "${COLOR_INFO}Usage: ${COLOR_INPUT}${STYLE_BOLD}nix-switch <config-name>$COLOR_RESET"
		echo ""
		echo "${COLOR_INFO}Defined configurations in the Flake file:${COLOR_RESET}"

		nix eval --json "${FLAKE_CONFIG_PATH}" \
			jq -r '.[]' | sed 's/^/  - /'

		return "$NIXOS_CONFIG_NOT_SPECIFIED"
	fi

	print-separator

	if ! sudo nixos-rebuild switch --flake "${FLAKE_CONFIG_PATH}#$1"; then
		print-separator
		print-decorated-message "❌" "Nixos build failed!" "$COLOR_ERROR"

		return "$NIXOS_BUILD_FAIL"
	fi

	print-separator
	print-decorated-message "󱄅 " "Nixos config build completed" "$COLOR_SUCCESS"

	source /etc/profile
	print-decorated-message "󰈮 " "Shell profile sourced" "$COLOR_INFO"

	# If you're using zsh, reload its config
	if [ -n "$ZSH_VERSION" ]; then
		if [ -f /etc/zshrc ]; then
			source /etc/zshrc
			print-decorated-message "󰈮 " "Zsh profile sourced" "$COLOR_INFO"
		fi

		# If starship exists, reload that too
		if command -v starship >/dev/null; then
			eval "$(starship init zsh)"
			print-decorated-message " " "Starship reloaded" "$COLOR_INFO"
		fi
	fi

}
