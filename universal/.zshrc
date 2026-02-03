# [[ -r ~/.config/zsh/znap ]] ||
#     git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.config/zsh/znap

# source ~/.config/zsh/znap/znap.zsh

# load NVM
export NVM_DIR="$HOME/.nvm"
export NVM_SYMLINK_CURRENT=true
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD=true
# zsh-nvm is too slow
# znap source lukechilds/zsh-nvm

# ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

case `uname` in
    Darwin)
        export PATH="$PATH:$HOME/.local/bin"
        export PATH="$PATH:$HOME/.dotnet/tools"
        export RBX_LOCAL_NUGET_FEED=/Users/${USER}/.rbx/LocalNuGetRepo
        export GOPATH="$HOME/go"
        export PATH="$GOPATH/bin:$PATH"

        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"

        # Roblox commands 
        source $HOME/.config/zsh/.rbx-zsh
    ;;
    Linux)
        # Linux specific config
    ;;
esac

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# Load tmux sessionizer functions
if [ -f ~/.config/tmux/tmux-sessionizer ]; then
    . ~/.config/tmux/tmux-sessionizer
fi

if [ -f ~/.config/tmux/tmux-workspace-helper ]; then
    . ~/.config/tmux/tmux-workspace-helper
fi

# Custom completions
fpath=(~/.config/zsh/completions $fpath)

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
