# -----------------------------------------------------
# INIT
# -----------------------------------------------------

set -U fish_greeting ""

# -----------------------------------------------------
# Exports
# -----------------------------------------------------
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx XCURSOR_THEME ArcStarry-cursors
set -gx XCURSOR_SIZE 24

set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin /usr/lib/ccache/bin/ $fish_user_paths
