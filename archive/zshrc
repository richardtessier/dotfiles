# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="flazz"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git zshmarks vi-mode)
plugins=(vi-mode fzf-z)
fpath=(~/.zsh/completion $fpath)

# TODO: Are there completions that I might use here?
#plugins+=(zsh-completions)
#autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

# Jump auto-complete
#function _completemarks {
#  reply=($(ls $MARKPATH))
#}

# z frequency path navigator
. `brew --prefix`/etc/profile.d/z.sh

#compctl -K _completemarks jump
#compctl -K _completemarks unmark

# Online help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

# Edit command-line in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^T' edit-command-line

# History
setopt histignorespace
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
#bindkey '^P' up-history
#bindkey '^N' down-history
#
# Tab completion
#autoload -U compinit && compinit
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Make sure colors work
autoload -U colors && colors

# Set VIM editing for command-line
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

bindkey '^_' undo
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M viins "^R" history-incremental-search-backward
bindkey -M viins "^F" history-incremental-search-forward

# Aliases & function (for arguments)
#alias mvim='open -a MacVim.app'
alias lt='ls -lt'
alias lta='ls -ltA'

lth() {
  local headargs lsargs

  # $1=Numeric, head -n $1 and $2 is path
  # $1=String && $2=Numeric, $1 is path and head -n $2
  # else use $1 as path (can be empty) and no argument to head
  if [[ $1 =~ ^[0-9]+$ ]]; then
    #echo "Limit to n lines"
    headargs="-n $(( $1+0 ))"
    lsargs="${argv[2,$#]}"
  else
    #echo "Assume all args are files"
    lsargs="${argv}"
    headargs=""
  fi

  #eval "$lscmd"
  #lsargs="dev2/bmc/Queries_2015-12-07/*.zip"
  #echo "${=lsargs}"
  ls -lt ${=lsargs} | head ${headargs}
}

ff() {
  find . -not \( -path "*/Library/*" -o -path "*/Applications/*" -o -path "*/.Trash/*" -o -path "*Microsoft Lync History/*" -prune \) -name $*
}

alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
# Fuzzy file finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--extended --cycle"

# cd into the selected directory - with filter for large directories of little interest
fzf-cd-widget-filtered() {
  local cmd="${FZF_ALT_C_COMMAND:-"command find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' -o -path '*/Library' -o -path '*/Applications' \\) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3-"}"
  cd "${$(eval "$cmd" | $(__fzfcmd) +m):-.}"
  zle reset-prompt
}
zle     -N   fzf-cd-widget-filtered
bindkey '^B' fzf-cd-widget-filtered

# Go Development
export GOPATH=$HOME/go
export PATH="/usr/local/opt/python/libexec/bin:$PATH:$GOPATH/bin:$HOME/anaconda3/bin"

# Terminal Columns
export COLUMNS

# Make less behave more intelligently and leave output on screen!
export LESS=-iXFR

# GitHub helpers, alias git->hub
eval "$(hub alias -s)"

# iTerm2 profile switcher function
function it2prof() { echo -e "\033]50;SetProfile=$1\a" }

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
