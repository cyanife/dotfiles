#!/usr/bin/env zsh

# requirements
print -P "%F{33}▓▒░ %F{220}Checking for requirements…%f"
if ! [ -x "$(command -v git)" ]; then
    echo 'git is not installed.' >&2
    exit 1
fi
if ! [ -x "$(command -v svn)" ]; then
    echo 'subversion is not installed.' >&2
    exit 1
fi
if ! [ -x "$(command -v unzip)" ]; then
    echo 'unzip is not installed.' >&2
    exit 1
fi
if ! [ -x "$(command -v lua)" ]; then
    echo 'lua is not installed.' >&2
    exit 1
fi

ZINIT_HOME="$HOME/.zinit"
ZINIT_BIN="bin"

if [[ ! -f $ZINIT_HOME/$ZINIT_BIN/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing zdharma/zinit…%f"
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma/zinit "$ZINIT_HOME/$ZINIT_BIN"
    if [ $? -eq 0 ]; then
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f"
        echo -e "source $ZINIT_HOME/$ZINIT_BIN/zinit.zsh" >> $HOME/.zshrc
    else
        print -P "%F{160}▓▒░ The clone has failed.%f"
        exit 1
    fi
fi

print -P "%F{33}▓▒░ %F{220}Detecting & fixing permission problems…%f"
if [ -x "$(command -v compaudit)" ]; then
    compaudit | xargs sudo chmod g-w,o-w
fi
print -P "%F{33}▓▒░ %F{34}All Done!.%f"
