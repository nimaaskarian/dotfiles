cd ~
mv .zsh_history .zsh_history_old
strings .zsh_history_old > .zsh_history
fc -r .zsh_history
rm ~/.zsh_history_old
