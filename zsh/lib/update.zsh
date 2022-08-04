update () {
    update_apt
    update_brew
    update_rust
    update_cargo
    update_node
    update_npm
}

__update_show_header () {
    printf "\033[1;36m\n%s\n\n\033[0m" "$1"
}

update_apt () {
    # Check for apt-get instead of apt because macOS has unrelated /usr/bin/apt binary
    if type apt-get &>/dev/null; then
        __update_show_header 'Updating APT packages'

        sudo apt update
        sudo apt upgrade -y
    fi
}

update_brew () {
    if type brew &>/dev/null; then
        __update_show_header "Updating Homebrew packages"

        brew update
        brew upgrade --fetch-HEAD
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
    if type fnm &>/dev/null; then
        __update_show_header "Updating Node.js"

        current_node_version=$(fnm current)
        new_node_version=$(fnm list-remote | tail -n 1)

        if [ "$current_node_version" = "$new_node_version" ]; then
            echo "Current version $current_node_version is the same as latest, skipping"
        else
            fnm install $new_node_version
            fnm default $new_node_version
            fnm use $new_node_version

            npm i -g npm pnpm yarn typescript ts-node prettier typescript-language-server vscode-langservers-extracted
        fi
    elif type nvm &>/dev/null; then
        __update_show_header "Updating Node.js"
        nvm install node --reinstall-packages-from=node
    fi
}

update_npm () {
    if type npm &>/dev/null; then
        __update_show_header "Updating global npm packages"

        npm list -g --json --depth 0 | \
            jq -r '.dependencies
                | keys
                | map(select(. != "corepack"))
                | map(. + "@latest")
                | .[]' | \
            xargs npm install -g
    fi
}
