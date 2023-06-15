# vim:fileencoding=utf-8:foldmethod=marker
# Calcurse startup{{{
calcurse_output=$(calcurse -at -d 1)
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
# General {{{
source ~/.nnn_variables
HISTFILE=~/.cache/zsh_history
HISTSIZE=10000
SAVEHIST=100000
# ^W don't delete whole argument
WORDCHARS=' *?_-".[]~=&;!#$%^(){}<>/'
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
zmodload zsh/complist

# _variables
export PATH=$PATH:$HOME/.local/bin/
export EDITOR=lvim
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

# zinit light kutsan/zsh-system-clipboard
zinit light jeffreytse/zsh-vi-mode
# }}}
# Aliases{{{
   
alias c="wl-copy"
alias bw="~/Documents/Learning/cpp/bingewatcher-cpp/bw"
alias cc="PAGER='/home/nima/Scripts/glowless' calcurse"
alias ls='nnn'
alias la='nnn -H'
alias lt='exa --icons --tree'
alias l='exa --icons -l'
alias lg='exa --icons -l --git'
alias py=python3
function z(){
    zathura "$@" &!
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
function ef() {
output=$(OPTIONS=-tf ~/Scripts/fd-fzf.sh $*) && $EDITOR $output
}
function sdir() {
output=$(~/Scripts/fd-fzf.sh $*) && cd $output
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
bindkey -M emacs "^[[Z" reverse-menu-complete
bindkey -M viins "^[[Z" reverse-menu-complete
bindkey -M vicmd "^[[Z" reverse-menu-complete
bindkey -v "^?" backward-delete-char 
bindkey ' ' magic-space
bindkey '^I^I' autosuggest-accept
# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[' undo
# }}}
# Other (p10k, command not found){{{
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 
source /usr/share/doc/pkgfile/command-not-found.zsh
# }}}
