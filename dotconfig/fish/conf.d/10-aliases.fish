# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

# -----------------------------------------------------
# General
# -----------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias c='clear'
alias q='exit'
alias nf='fastfetch'
alias pf='fastfetch'
alias fetch='fastfetch'
alias ls='eza -a --icons=always --group-directories-first'
alias ll='eza -al --icons=always --group-directories-first'
alias la='eza -a --icons=always --group-directories-first'
alias lt='eza -a --tree --level=1 --icons=always'
alias tree='eza --tree --icons'
alias shutdown='systemctl poweroff'
alias v='nvim'
alias vi='vim'
alias vim='nvim'
alias code='antigravity'
alias wifi='nmtui'
alias update='sudo pacman -Syu'
alias btop='btop'
alias h='history | fzf' # Quick history search with FZF
alias p='cd ~/Projects' # Quick access to projects folder

# -----------------------------------------------------
# Programmer Aliases
# -----------------------------------------------------
if command -v bat > /dev/null
    alias cat='bat --paging=never'
end

if command -v yazi > /dev/null
    alias y='yazi'
end

if command -v lazygit > /dev/null
    alias lg='lazygit'
end

if command -v trash-put > /dev/null
    alias del='trash-put'
end
alias rm='command rm -iv'

# HTTP & JSON (Programmer stuff)
alias http='http --style=monokai' # Colored HTTPie output
alias help='tldr' # Shortcut for tldr

# -----------------------------------------------------
# ML4W Apps
# -----------------------------------------------------
alias arch-cleanup='~/.config/ml4w/scripts/arch/cleanup.sh'
alias apps='~/.config/ml4w/bin/ml4w-apps.sh'
alias screenshot='~/.config/ml4w/bin/ml4w-screenshot.sh'
alias updates='~/.config/ml4w/scripts/ml4w-install-system-updates'
alias filemanager='~/.config/ml4w/settings/filemanager'
alias lock='hyprlock'
alias clock='tty-clock'
alias system='~/.config/ml4w/settings/systemmonitor'
alias quick='~/.config/ml4w/bin/ml4w-quicklinks.sh'
alias wallpaper='~/.config/ml4w/bin/ml4w-wallpaper.sh'
alias ml4w='flatpak run com.ml4w.welcome'
alias ml4w-settings='flatpak run com.ml4w.settings'
alias ml4w-calendar='flatpak run com.ml4w.calendar'
alias ml4w-hyprland='flatpak run com.ml4w.hyprlandsettings'
alias ml4w-sidebar='flatpak run com.ml4w.sidebar'

# -----------------------------------------------------
# Magic Functions
# -----------------------------------------------------

# 1. Extract Anything
function extract --description "Extract anything"
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# 2. Search Web (Google, Github, StackOverflow)
function google
    xdg-open "https://www.google.com/search?q=$argv"
end
function github
    xdg-open "https://github.com/search?q=$argv"
end

# 3. Quick File Find
# Usage: ff "filename.txt"
function ff
    find . -iname "*$argv*"
end

# -----------------------------------------------------
# Scripts
# -----------------------------------------------------
alias ascii='~/.config/ml4w/scripts/ml4w-ascii-header'

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
