#!/usr/bin/env zsh

#cd "$(dirname "${BASH_SOURCE}")";

cd $(dirname ${(%):-%x})

git pull origin master;

function doIt() {
    echo "Updating"
    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude ".osx" \
        --exclude ".idea/" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE" \
        --exclude ".gitignore" \
        -avh --no-perms ./ ~;
    chmod 700 ~/.ssh
    chmod 700 ~/.gnupg
    chmod 600 ~/.ssh/authorized_keys
    source ~/.zshrc;
}

if [[ "$1" == "--force" || "$1" == "-f" ]]; then
    doIt;
else
    if read -q '? This may overwrite existing files in your home directory. Are you sure? (y/n) ?'; then
      echo "\n"
      doIt; 
    fi
fi;
unset doIt;
