# export LC_ALL=en_US.UTF-8
# export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin/"
# export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH:/home/linuxbrew/.linuxbrew/bin/"

# aliases
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# load completions
autoload -U compinit && compinit
zmodload zsh/complist

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# enable vi mode
# source $ZDOTDIR/zsh-vim-mode

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/main.toml)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export XDG_CONFIG_HOME="$HOME/.config"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
