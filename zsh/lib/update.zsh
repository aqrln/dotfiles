function update {
    update_apt
    update_brew
    update_nix
    update_rust
    update_cargo
    update_node
    update_npm
}

function update_apt {
    # Check for apt-get instead of apt because macOS has unrelated /usr/bin/apt binary
    if type apt-get &>/dev/null; then
        apt update
        apt upgrade -y
    fi
}

function update_brew {
    if type brew &>/dev/null; then
        brew update
        brew upgrade
    fi
}

function update_nix {
    if type nix-env &>/dev/null; then
        nix-channel --update nixpkgs
        nix-env -u '*'
    fi
}

function update_rust {
    if type rustup &>/dev/null; then
        rustup update
        rustup upgrade
    fi
}

function update_cargo {
    if type cargo-install-update &>/dev/null; then
        cargo install-update -a
    else
        cargo install cargo-update && update_cargo
    fi
}

function update_node {
    if type nvm &>/dev/null; then
        nvm install node --reinstall-packages-from=node
    fi
}

function update_npm {
    if type npm &>/dev/null; then
        npm install -g npm@latest
        npm list -gp --depth 0 | \
            awk -F / '{ if (NR > 1 && $NF != "npm") print $NF "@latest" }' | \
            xargs npm install -g
    fi
}
