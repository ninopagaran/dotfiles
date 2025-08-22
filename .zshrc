# export LC_ALL=en_US.UTF-8

export ELECTRON_OZONE_PLATFORM_HINT=auto

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
  export SDL_VIDEODRIVER=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
  export QT_QPA_PLATFORM=wayland
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_DESKTOP=sway
  exec sway
fi


source $HOME/.profile

# aliases
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^w "tmux attach\ntmux\n"

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

export MANPAGER='nvim +Man!'

source <(oh-my-posh init zsh --config $HOME/.config/ohmyposh/main.toml)

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
  zdharma-continuum/fast-syntax-highlighting \
  blockf \
  zsh-users/zsh-completions \
  atload"_zsh_autosuggest_start; \
  ZSH_AUTOSUGGEST_STRATEGY=(history completion) \
    ZSH_AUTOSUGGEST_MANUAL_REBIND=0 \
    ZSH_AUTOSUGGEST_HISTORY_IGNORE=' *' \
    bindkey '^p' history-search-backward; \
    bindkey '^n' history-search-forward; \
    bindkey '^o' autosuggest-accept; \
    bindkey '^e' autosuggest-execute; \
    bindkey '^a' autosuggest-toggle; \
    bindkey '^s' autosuggest-clear" \
    zsh-users/zsh-autosuggestions

