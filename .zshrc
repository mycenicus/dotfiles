export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
ZLE_RPROMPT_INDENT=0

autoload -U compinit; compinit

# load zgen plugin manager
source "${HOME}/.zgen/zgen.zsh"

zgen load zsh-users/zsh-syntax-highlighting
zgen load zsh-users/zsh-completions src
zgen load zsh-users/zsh-autosuggestions
zgen load Aloxaf/fzf-tab

# Keybindings
# Emacs keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Autosuggestions history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
# Append history instead of overwriting it
setopt appendhistory
# Share command history across all sessions
setopt sharehistory
# Prevent writing to history file by adding space at beggining
setopt hist_ignore_space
# Prevent duplicates
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Make autocompletion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias icat='kitten icat'

# Shell integrations
eval "$(fzf --zsh)"

eval "$(starship init zsh)"

[ -f "/home/artem/.ghcup/env" ] && . "/home/artem/.ghcup/env" # ghcup-env
