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

bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
echo -e "[ -f ~/.zshrc.local ] && source ~/.zshrc.local" >> $HOME/.zshrc