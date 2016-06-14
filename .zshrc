# Created by newuser for 4.3.17
hosts=(`hostname`)
autoload -U colors
colors
host_color="green"
path_color="blue"
date_color="yellow"
date_format="%H:%M"
date="%{fg[$date_color]%}%D{date_format}"
userhost="%{$fg[yellow]%}[%B%{$fg[green]%}%n%b%{$fg[yellow]%}@%B%{$fg[red]%}%m%b%{$fg[yellow]%}]"
cpath="%B%{$fg[cyan]%}%35< ...<%~%b%{$fg[yellow]%}"
delimchar="%{$fg[yellow]%}%# "
end="%{$reset_color%}" 
returncmd="%{$fg[yellow]%}[%{$fg[cyan]%}%?%{$fg[yellow]%}]"
# Main prompt
PS1="$userhost$cpath$returncmd$delimchar$end"
#     # Right Prompt => date
RPS1="%{$fg[yellow]%}[%{$fg[white]%}%(t.Ding!.%B%D{%T}%b)%{$fg[yellow]%}]$end"
#        
HISTFILE=~/.zsh_history
SAVEHIST=100000000
HISTSIZE=100000000
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash


setopt c_bases             # Print hex numbers like 0x7F instead of 16#7Fs
setopt hist_save_no_dups   # Only the newest of a set of duplicates (regardless of
# sequence) is saved to file
   setopt inc_append_history  # Commands are added to the history file as they are
  setopt share_history 
# entered.
setopt list_packed         # Use variable width columns for completion options
setopt octal_zeroes        # print octal numbers like 037 instead of 8#37

watch=all 
# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile


################################################################################
# Overwrite default bind keys                                                  #
################################################################################
#autoload zkbd
#[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && zkbd
#source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE
#
#[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
#[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
#[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
#[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
#[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
#[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
#[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
#[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
#[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
#[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
#[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey "^[OH" beginning-of-line # Home
bindkey "^[OF" end-of-line # End
bindkey "^[[2~" overwrite-mode # insert
bindkey "^[[3~" delete-char # delete
bindkey "^H" backward-delete-char #backspace
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


################################################################################
# Completion options                                                           #
################################################################################
# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.

autoload -U compinit
compinit -i # silenty ignone insecure directory and file
ZLS_COLORS=$LS_COLORS
# Completion Styles

# Add a menu on completion
zstyle ':completion:*' menu select=1
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zshcache
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' ''

# Use menuselection for pid completion
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

#  tag-order 'globbed-files directories' all-files 
zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*~'

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

# With commands like rm, it's annoying if you keep getting offered the same
# file multiple times. This fixes it. Also good for cp, et cetera..
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

# Describe each match group.
zstyle ':completion:*:descriptions' format "%{$fg_bold[blue]%}[ %{$fg_bold[green]%}%d%{$fg_bold[blue]%}]%{$reset_color%}"

# Messages/warnings format
zstyle ':completion:*:messages' format "%{$fg_bold[blue]%}[ %{$fg_bold[yellow]%}%d%{$fg_bold[blue]%}]%{$reset_color%}"
zstyle ':completion:*:warnings' format "%{$fg_bold[blue]%}[ %{$fg_bold[red]%}No match for %d%{$fg_bold[blue]%}]%{$reset_color%}"

# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# Simulate spider's old abbrev-expand 3.0.5 patch 
zstyle ':completion:*:history-words' stop verbose
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false

# Follow GNU LS_COLORS
zmodload -i zsh/complist

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
zstyle ':completion:*:processes' command 'ps -axo pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# auto complete with local directories
zstyle ':completion:*:*:cd:*' tag-order local-directories path-directories
################################################################################
# Last command to execute                                                      #
################################################################################

#source /bin/aws_zsh_completer.sh
#source /usr/local/bin/aws_zsh_completer.sh
export TERM=xterm-256color
#. /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# export LC_ALL=pl_PL.utf8
