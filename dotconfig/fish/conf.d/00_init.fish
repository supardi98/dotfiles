# -----------------------------------------------------
# INIT
# -----------------------------------------------------

set -U fish_greeting ""

# -----------------------------------------------------
# Exports
# -----------------------------------------------------
set -gx EDITOR nvim
set -gx VISUAL nvim

set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin /usr/lib/ccache/bin/ $fish_user_paths
