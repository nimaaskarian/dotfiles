# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
zsh-autosuggestions
git
zsh-syntax-highlighting
vi-mode
)
ZSH_THEME="powerlevel10k/powerlevel10k"
VI_MODE_SET_CURSOR=true
source $ZSH/oh-my-zsh.sh
wav2mp3 (){
for file in *.wav
do
	ffmpeg -i $file -vn -ar 44100 -ac 2 -b:a 320k "${file%%.*}.mp3"
done
}
alias download-notify="notify-send Downloaded -i download"
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_طUS.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='lvim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="/home/nima/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/nima/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/nima/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/nima/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/nima/perl5"; export PERL_MM_OPT;
path+=(
    $(ruby -e 'puts File.join(Gem.user_dir, "bin")')
)
source $(dirname $(gem which colorls))/tab_complete.sh
alias ls='lsd'
alias la='ls -lA'
alias lt='ls --tree'
alias lg='colorls --gs'

eval $(thefuck --alias)
alias py=python3
alias wscan='iwctl station wlan0 scan'
alias wgetn='iwctl station wlan0 get-networks'
alias wcon='wscan && iwctl station wlan0 connect'
alias wdc='iwctl station wlan0 disconnect'
# alias ensvc="sudo systemctl enable --now"
# alias disvc="sudo systemctl disable"
# alias svc="sudo systemctl status"
alias s="sudo systemctl"
alias z="zathura"
alias p="sudo pacman"
alias np="pacman"
alias pwc='echo -n $(pwd) | xclip -selection clipboard'

alias ins='sudo pacman -S'
alias upg='sudo pacman -Syu'
alias urins='yay -S'
alias uins='sudo pacman -Rns'
alias uruins='yay -Rns'
alias pacls="pacman -Qe"
alias paci="pacman -Qi"
alias pacf="pacman -Qs"
alias clean="sudo pacman -Sc"
alias repf="pacman -Ss"
alias repi="pacman -Si"
alias rollbk="sudo pacman -U"
# alias np="node /home/nima/player -n"
# alias pp="node /home/nima/player -p"
# alias p="playerctl -p $(node /home/nima/player)"
alias urpacls="yay -Qe"
alias urpaci="yay -Qi"
alias urpacf="yay -Qs"
alias urclean="yay -Sc"
alias urepf="yay -Ss"
alias urepi="yay -Si"
alias saveron="xset s on dpms"
alias saveroff="xset s off -dpms"
alias sus="systemctl suspend"
alias s="systemctl"
alias toil="toilet -f pagga"
alias tb="taskbook"
alias c="xclip -se c"
alias cpy="~/Scripts/cpp-interpreter/cpp.py"
alias cap="xclip-copyfile"
alias t="todo.sh"
alias h="htop"
alias mv="mv -vi"
alias zbarimg="zbarimg --raw -q"
alias glone="~/Scripts/glone.py"

function watch(){
  wd=$PWD
  cd "$HOME/.bingewatcher"
  series=$(fd -i1 $@ | xargs)
  echo $series
  cd "$HOME/Downloads/Movies"
  mpv $(fd -i "$@"| grep $(bw -e "$series")) && bw "$series" 1
  cd $wd
}
alias pm="pulsemixer"
alias cc="PAGER='/home/nima/Scripts/glowless' calcurse"

calcurse_output=$(cc -at -d 2)
if [[ $(printf $calcurse_output | wc -c) -gt 0 ]]; then
  printf 'today: '
  date +'%m/%d/%y'
  printf '\n'
  printf "$calcurse_output\n"
fi

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v "^?" backward-delete-char
