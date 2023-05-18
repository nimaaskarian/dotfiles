# vim:fileencoding=utf-8:foldmethod=marker
# Calcurse startup{{{
calcurse_output=$(calcurse -at -d 2)
if [[ $(printf $calcurse_output | wc -c) -gt 0 ]]; then
  printf 'today: '
  date +'%a'
  printf '\n'
  printf "$calcurse_output\n"
fi
# }}}
# Instant prompt{{{

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}
# General{{{
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
# export NNN_OPENER=nuke
export NNN_COLORS="1234"
export NNN_BMS="D:$HOME/Scripts;v:$HOME/Downloads"
export NNN_TMPFILE="$HOME/.cache/nnn-lastd"
export ZSH_SYSTEM_CLIPBOARD_METHOD="wlc"
# }}}
# Zinit{{{

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
# }}}
# Plugins{{{

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

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

zinit light kutsan/zsh-system-clipboard
zinit light jeffreytse/zsh-vi-mode
# }}}
# Aliases{{{
   
alias c="wl-copy"
alias cc="PAGER='/home/nima/Scripts/glowless' calcurse"
function nnn(){
    /bin/nnn -Cde $@;
    $(sed "s/'//g" ~/.cache/nnn-lastd)
}
alias ls='nnn'
alias la='nnn -H'
alias lt='ls --tree'
alias lg='colorls --gs'
alias py=python3
function z(){
    nohup zathura "$@" &> /dev/null &
}
function w3m(){
    if [[ $1 ]]; then
        /bin/w3m $@
    else
        /bin/w3m ~/Scripts/nitab-plain/nitab-plain.html
    fi
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
alias gd="fd -td -H --base-directory $PWD |fzf"
alias gf="fd -tf -H --base-directory $PWD|fzf"
function ef() {
    dir=$HOME
    [ $1 ] && dir=$1
    output=$(fd -tf -H --base-directory | fzf) && lvim "$dir/$output"
}
function sd(){
    dir=$HOME
    [ $1 ] && dir=$1
    output=$(fd -td -H  --base-directory "$dir"| fzf) && cd "$dir/$output"
}
alias neofetchm="neofetch --config $HOME/.config/neofetch/config.minimal.conf"
# }}}
# Binds{{{

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
# }}}
# Other (p10k, command not found){{{
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 
source /usr/share/doc/pkgfile/command-not-found.zsh
# }}}
# nnn cd on quit{{{
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
# }}}
