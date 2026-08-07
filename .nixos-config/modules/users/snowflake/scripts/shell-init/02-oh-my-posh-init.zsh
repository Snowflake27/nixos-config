if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init zsh --config "${FLAKE_CONFIG_PATH}/modules/users/snowflake/configs/oh-my-posh.toml")"
fi