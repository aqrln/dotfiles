function update {
    if type apt-get &>/dev/null; then
        apt update
        apt upgrade -y
    fi

    if type brew &>/dev/null; then
        brew update
        brew upgrade
    fi

    if type nix-env &>/dev/null; then
        nix-channel --update nixpkgs
        nix-env -u '*'
    fi

    if type rustup &>/dev/null; then
        rustup update
        rustup upgrade
    fi

    if type cargo-install-update &>/dev/null; then
        cargo install-update -a
    fi

    if type nvm &>/dev/null; then
        nvm install node --reinstall-packages-from=node
    fi

    if type npm &>/dev/null; then
        npm install -g npm@latest
        npm update -g
    fi
}