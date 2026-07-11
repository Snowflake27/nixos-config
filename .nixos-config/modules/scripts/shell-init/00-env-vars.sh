### Setup configuration
FLAKE_CONFIG_PATH="/etc/nixos/flake-config/"

###

### Error codes
NIXOS_CONFIG_NOT_SPECIFIED=1
NIXOS_BUILD_FAIL=10

###

### Color Helpers
export COLOR_RESET=$(tput sgr0)

export COLOR_SUCCESS=$(tput setaf 2)
export COLOR_ERROR=$(tput setaf 1)
export COLOR_INFO=$(tput setaf 6)
export COLOR_DEBUG=$(tput setaf 5)
export COLOR_INPUT=$(tput setaf 11)
export COLOR_MUTED=$(tput setaf 8)

export STYLE_BOLD=$(tput bold)

###