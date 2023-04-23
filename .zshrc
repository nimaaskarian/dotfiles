#  _____     _    _            __              _           _      
# |_   _|_ _| |__| |___   ___ / _|  __ ___ _ _| |_ ___ _ _| |_ ___
#   | |/ _` | '_ \ / -_) / _ \  _| / _/ _ \ ' \  _/ -_) ' \  _(_-<
#   |_|\__,_|_.__/_\___| \___/_|   \__\___/_||_\__\___|_||_\__/__/
# _instant_prompt
# _general
# _variables
# __zinit
# _plugins
# _p10k
# _aliases
# _binds

# calcurse B)
calcurse_output=$(calcurse -at -d 2)
if [[ $(printf $calcurse_output | wc -c) -gt 0 ]]; then
  printf 'today: '
  date +'%a'
  printf '\n'
  printf "$calcurse_output\n"
fi
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


#  ___         _            _                             _   
# |_ _|_ _  __| |_ __ _ _ _| |_   _ __ _ _ ___ _ __  _ __| |_ 
#  | || ' \(_-<  _/ _` | ' \  _| | '_ \ '_/ _ \ '  \| '_ \  _|
# |___|_||_/__/\__\__,_|_||_\__| | .__/_| \___/_|_|_| .__/\__|
#                                |_|                |_|       
# _instant_prompt

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


#   ___                       _ 
#  / __|___ _ _  ___ _ _ __ _| |
# | (_ / -_) ' \/ -_) '_/ _` | |
#  \___\___|_||_\___|_| \__,_|_|
# _general
HISTFILE=~/.cache/zsh_history
HISTSIZE=10000
SAVEHIST=100000
# ^W don't delete whole argument
WORDCHARS=' *?_-.[]~=&;!#$%^(){}<>/'
autoload -Uz select-word-style
select-word-style normal
zstyle ':zle:*' word-style unspecified
# autocd
setopt autocd extendedglob nomatch notify
# no beep
unsetopt beep
# small to capital letters
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# _variables
export PATH=$PATH:$HOME/.local/bin/
export EDITOR=lvim
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


#  _____      _ _   
# |_  (_)_ _ (_) |_ 
#  / /| | ' \| |  _|
# /___|_|_||_|_|\__|
# __zinit

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


#  ___ _           _         
# | _ \ |_  _ __ _(_)_ _  ___
# |  _/ | || / _` | | ' \(_-<
# |_| |_|\_,_\__, |_|_||_/__/
#            |___/           
# _plugins

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    zdharma-continuum/history-search-multi-word \
 blockf \
    zsh-users/zsh-completions #\
 # atload"!_zsh_autosuggest_start" \
 #    zsh-users/zsh-autosuggestions

zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light jeffreytse/zsh-vi-mode
# command-not-found
source /usr/share/doc/pkgfile/command-not-found.zsh
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


#  ___  _  __  _   
# | _ \/ |/  \| |__
# |  _/| | () | / /
# |_|  |_|\__/|_\_\
# _p10k

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


#    _   _ _                 
#   /_\ | (_)__ _ ___ ___ ___
#  / _ \| | / _` (_-</ -_|_-<
# /_/ \_\_|_\__,_/__/\___/__/
# _aliases
   
alias c="wl-copy"
alias cc="PAGER='/home/nima/Scripts/glowless' calcurse"
alias ls='lsd'
alias la='ls -lA'
alias lt='ls --tree'
alias lg='colorls --gs'
alias py=python3
function z(){
    nohup zathura "$1" &> /dev/null &
}
alias p="sudo pacman"
alias np="pacman"
alias pwc='pwd | c'
alias ins='sudo pacman -S'
alias upg='sudo pacman -Syu'
alias s="sudo systemctl"
alias cpy="~/Scripts/cpp-interpreter/cpp.py"
alias mv="mv -vi"
alias cp="cp -vi"
alias zbarimg="zbarimg --raw -q"
alias glone="~/Scripts/glone.py"
alias pm="pulsemixer"
alias pc="peaclock --config-dir ~/.config/peaclock"
alias gd="fd -td -H |fzf"
alias gf="fd -tf -H |fzf"
function ef() {
    [ $1 ] && pushd $1 || pushd ~
    output=$(gf) && lvim "$output" || popd
}
function sd(){
    [ $1 ] && pushd $1 || pushd ~
    output=$(gd) && cd "$output" || popd
}
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


#  ___ _         _    
# | _ |_)_ _  __| |___
# | _ \ | ' \/ _` (_-<
# |___/_|_||_\__,_/__/
# _binds

# bindkey '^[[A' up-line-or-search
# bindkey '^[[B' down-line-or-search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

bindkey -v "^?" backward-delete-char 
bindkey ' ' magic-space
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


#  ___  _  __  _   
# | _ \/ |/  \| |__
# |  _/| | () | / /
# |_|  |_|\__/|_\_\
# _p10k

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
