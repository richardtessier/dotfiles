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
 plugins=(vi-mode jump)

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

# Tab completion
#autoload -U compinit && compinit

# Make sure colors work
autoload -U colors && colors

# Set VIM editing for command-line
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# History
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^_' undo
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M viins "^R" history-incremental-search-backward
bindkey -M viins "^F" history-incremental-search-forward


# Aliases
alias truecrypt='/Applications/TrueCrypt.app/Contents/MacOS/Truecrypt --text'

# Fuzzy file finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--extended --cycle"

# Go Development
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# GitHub helpers, alias git->hub
eval "$(hub alias -s)"
