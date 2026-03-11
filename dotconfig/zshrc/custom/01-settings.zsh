#  _                      _            _    
# | |__  _   _ _ __  _ __| | ___   ___| | __
# | '_ \| | | | '_ \| '__| |/ _ \ / __| |/ /
# | | | | |_| | |_) | |  | | (_) | (__|   < 
# |_| |_|\__, | .__/|_|  |_|\___/ \___|_|\_\
#        |___/|_|                           
# 

# -----------------------------------------------------
# Path & Environment Configuration
# -----------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# -----------------------------------------------------
# Oh My Posh (Prompt)
# -----------------------------------------------------
if [ -f "$HOME/.local/bin/oh-my-posh" ]; then
    eval "$($HOME/.local/bin/oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"
elif command -v oh-my-posh > /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"
fi

# -----------------------------------------------------
# Zsh Plugins
# -----------------------------------------------------
# Autosuggestions (History Hints)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#717c7a"
fi

# Syntax Highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# History Substring Search (Prefix Search with Arrows)
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# -----------------------------------------------------
# FZF (Fuzzy Finder)
# -----------------------------------------------------
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# -----------------------------------------------------
# Zoxide (Smarter cd)
# -----------------------------------------------------
if command -v zoxide > /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi

# -----------------------------------------------------
# Direnv (Project Environment Auto-loader)
# -----------------------------------------------------
if command -v direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

# -----------------------------------------------------
# Completion System
# -----------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# -----------------------------------------------------
# Directory Navigation (Auto-CD)
# -----------------------------------------------------
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# -----------------------------------------------------
# Programmer Aliases
# -----------------------------------------------------
# File Management
if command -v eza > /dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --group-directories-first'
    alias la='eza -a --icons --group-directories-first'
    alias tree='eza --tree --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -lh'
    alias la='ls -A'
fi

if command -v bat > /dev/null; then
    alias cat='bat --paging=never'
fi

if command -v yazi > /dev/null; then
    alias y='yazi'
fi

# Git Productivity
if command -v lazygit > /dev/null; then
    alias lg='lazygit'
fi

# Safety First (Trash-cli)
if command -v trash-put > /dev/null; then
    alias del='trash-put'
    alias rm='echo "Gunakan \"del\" untuk menghapus ke tong sampah, atau \"/usr/bin/rm\" jika yakin hapus permanen."'
fi

# Quick Utils
alias c='clear'
alias q='exit'
alias v='nvim'
alias vi='vim'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias update='sudo pacman -Syu'
alias btop='btop'
alias h='history | fzf' # Quick history search with FZF
alias p='cd ~/Projects' # Quick access to projects folder

# HTTP & JSON (Programmer stuff)
alias http='http --style=monokai' # Colored HTTPie output
alias help='tldr' # Shortcut for tldr

# -----------------------------------------------------
# Magic Functions
# -----------------------------------------------------

# 1. Extract Anything
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# 2. Search Web (Google, Github, StackOverflow)
google() { xdg-open "https://www.google.com/search?q=$*" }
github() { xdg-open "https://github.com/search?q=$*" }

# -----------------------------------------------------
# Auto-Pairing (Brackets & Quotes)
# -----------------------------------------------------
foreach char ({'"',"'",'(','[','{'}) {
  bindkey "$char" self-insert-closing
}
function self-insert-closing() {
  local char=$KEYS[1]
  local -A pairs
  pairs=('"' '"' "'" "'" '(' ')' '[' ']' '{' '}')
  LBUFFER+=$char
  RBUFFER=$pairs[$char]$RBUFFER
}
bindkey '^?' backward-delete-pair
function backward-delete-pair() {
  local -A pairs
  pairs=('"' '"' "'" "'" '(' ')' '[' ']' '{' '}')
  if [[ $pairs[$LBUFFER[-1]] == $RBUFFER[1] ]]; then
    LBUFFER=${LBUFFER%?}
    RBUFFER=${RBUFFER#?}
  else
    zle backward-delete-char
  fi
}
zle -N self-insert-closing
zle -N backward-delete-pair

# -----------------------------------------------------
# History Settings
# -----------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# -----------------------------------------------------
# Fastfetch (Run on start)
# -----------------------------------------------------
if command -v fastfetch > /dev/null; then
    fastfetch
fi
