# -----------------------------------------------------
# CUSTOMIZATION
# -----------------------------------------------------

# -----------------------------------------------------
# Prompt
# -----------------------------------------------------
if test -f "$HOME/.local/bin/oh-my-posh"
    $HOME/.local/bin/oh-my-posh init fish --config ~/.config/ohmyposh/zen.toml | source
else if command -v oh-my-posh > /dev/null
    oh-my-posh init fish --config ~/.config/ohmyposh/zen.toml | source
end

# -----------------------------------------------------
# Zoxide (Smarter cd)
# -----------------------------------------------------
if command -v zoxide > /dev/null
    zoxide init fish | source
    alias cd="z"
end

# -----------------------------------------------------
# Direnv (Project Environment Auto-loader)
# -----------------------------------------------------
if command -v direnv > /dev/null
    direnv hook fish | source
end

# -----------------------------------------------------
# FZF
# -----------------------------------------------------
if command -v fzf > /dev/null
    fzf --fish | source
end
