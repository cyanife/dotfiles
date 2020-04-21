#!/usr/bin/env zsh

ZINIT_HOME="${$HOME/.zinit}"
ZINIT_BIN="bin"

if [[ ! -f $ZINIT_HOME/$ZINIT_BIN/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing zdharma/zinit…%f"
    command mkdir -p "$ZINIT_HOME" && command chmodi g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma/zinit "$ZINIT_HOME/$ZINIT_BIN"
    if [ $? -eq 0 ]; then
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f"
        echo -e "source $ZINIT_HOME/$ZINIT_BIN/zinit.zsh" >> $HOME/.zshrc
    else
        print -P "%F{160}▓▒░ The clone has failed.%f"
        exit 1
    fi
fi

sudo apt install --yes subversion unzip
compaudit | xargs sudo chmod g-w,o-w

