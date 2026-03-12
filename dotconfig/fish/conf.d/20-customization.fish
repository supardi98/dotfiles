# -----------------------------------------------------
# CUSTOMIZATION
# -----------------------------------------------------

# -----------------------------------------------------
# Prompt
# -----------------------------------------------------
set -l posh_theme "zen.toml"
if test -f ~/.config/hypr/settings/ricing.conf
    # Note: Fish doesn't support 'export' in the same way as bash, 
    # but our ricing.conf uses export. We can still source it but 
    # might need to handle variables carefully.
    # For now, we'll try to extract POSH_THEME or use a simplified approach.
    set -l theme_from_conf (grep "export POSH_THEME=" ~/.config/hypr/settings/ricing.conf | cut -d'"' -f2)
    if test -n "$theme_from_conf"
        set posh_theme "$theme_from_conf"
    end
end

if test -f "$HOME/.local/bin/oh-my-posh"
    $HOME/.local/bin/oh-my-posh init fish --config ~/.config/ohmyposh/$posh_theme | source
else if command -v oh-my-posh > /dev/null
    oh-my-posh init fish --config ~/.config/ohmyposh/$posh_theme | source
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
