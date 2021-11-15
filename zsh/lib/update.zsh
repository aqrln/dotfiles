update () {
    update_apt
    update_brew
    update_rust
    update_cargo
    update_node
    update_npm
}

__update_show_header () {
    printf "\033[1;36m\n$1\n\n\033[0m"
}

update_apt () {
    # Check for apt-get instead of apt because macOS has unrelated /usr/bin/apt binary
    if type apt-get &>/dev/null; then
        __update_show_header 'Updating APT packages'

        apt update
        apt upgrade -y
    fi
}

update_brew () {
    if type brew &>/dev/null; then
        __update_show_header "Updating Homebrew packages"

        brew update
        brew upgrade
    fi
}

update_rust () {
    if type rustup &>/dev/null; then
        __update_show_header "Updating Rust"
        rustup update
    fi
}

update_cargo () {
    if type cargo-install-update &>/dev/null; then
        __update_show_header "Updating Cargo crates"
        cargo install-update -a
    else
        __update_show_header "Installing cargo-update"
        cargo install cargo-update && update_cargo
    fi
}

update_node () {
    if type nvm &>/dev/null; then
        __update_show_header "Updating Node.js"
        nvm install node --reinstall-packages-from=node
    fi
}

update_npm () {
    if type npm &>/dev/null; then
        __update_show_header "Updating global npm packages"

        npm install -g npm@latest
        npm list -gp --depth 0 | \
            awk -F / '{
                if (NR > 1 && $NF != "npm" && $NF != "corepack")
                    print $NF "@latest"
            }' | \
            xargs npm install -g
    fi
}
