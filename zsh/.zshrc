# --- Zinit core ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# --- Paths ---
export PATH="$HOME/.local/bin:/Users/muddassir/.codeium/windsurf/bin:$PATH"
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# --- Editor ---
export EDITOR="windsurf"
export VISUAL="windsurf"

# --- Plugins ---
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# --- Completions ---
autoload -Uz compinit && compinit

# --- History ---
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zhistory
HISTDUP=erase
setopt appendhistory sharehistory \
       hist_ignore_space hist_ignore_all_dups hist_save_no_dups \
       hist_ignore_dups hist_find_no_dups

# --- Completion styles ---
# zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview  'eza --icons --group-directories-first --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons --group-directories-first --color=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -l --icons --group-directories-first --color=always $realpath'


# --- Aliases
alias ls='eza --icons --group-directories-first --color=auto'
alias ll='eza -l --icons --group-directories-first --color=auto'
alias la='eza -la --icons --group-directories-first --color=auto'
alias lt='eza -T --icons --group-directories-first --color=auto' # tree view

# --- Prompt & tools ---
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
