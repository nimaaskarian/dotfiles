# vim:foldmethod=marker
# NNN {{{
export NNN_COLORS="1234"
export NNN_BMS="S:$HOME/Scripts;D:$HOME/Downloads;B:$HOME/Documents/Books"
export NNN_TMPFILE="$HOME/.cache/nnn-lastd"
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;t:nmount;v:imgview;d:dragdrop'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_COLORS="2346"
export NNN_BMS="S:$HOME/Scripts;D:$HOME/Downloads;B:$HOME/Documents/Books"
export NNN_PLUG='g:git-changes;f:finder;o:fzopen;p:preview-tui;t:nmount;v:imgview;d:dragdrop'
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
export NNN_FIFO=/tmp/nnn.fifo
function nnn(){
    /bin/nnn -Cde $@;
    source $NNN_TMPFILE
# alias nnn="nnn -Cde"
# export NNN_OPENER=nuke
}
# }}}

export PATH=$PATH:$HOME/.local/bin/:$HOME/.config/emacs/bin
export EDITOR=lvim
