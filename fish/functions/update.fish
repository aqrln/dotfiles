function update
    update_nix
    update_brew
    update_rust
    update_cargo
    update_node
    update_npm
    update_deno
    update_rudy_lldb_client

    update_completions
end

function __update_show_header
    printf "\033[1;36m\n%s\n\n\033[0m" $argv[1]
end

function update_nix
    if command -v nixos-rebuild &>/dev/null
        __update_show_header "Updating NixOS"
        sudo nixos-rebuild switch --upgrade-all
    end

    if command -v darwin-rebuild &>/dev/null
        __update_show_header "Updating Darwin with Nix"
        nix-channel --update
        sudo nix-channel --update
        darwin-rebuild switch
    end
end

function update_brew
    if command -v brew &>/dev/null
        __update_show_header "Updating Homebrew"
        brew update
        brew upgrade --fetch-HEAD
    end
end

function update_rust
    __update_show_header "Updating Rust"
    if command -v rustup &>/dev/null
        rustup update
    end
end

function update_cargo
    if command -v cargo-install-update &>/dev/null
        __update_show_header "Updating Cargo crates"
        cargo install-update -a
    else
        __update_show_header "Installing cargo-update"
        cargo install cargo-update && update_cargo
    end
end

function update_node
    if command -v fnm &>/dev/null
        __update_show_header "Updating Node.js"

        set current_node_version (fnm current)
        set new_node_version (fnm list-remote | tail -n 1)

        if [ $current_node_version = $new_node_version ]
            echo "Current version $current_node_version is the same as latest, skipping"
        else
            fnm install $new_node_version
            fnm default $new_node_version
            fnm use $new_node_version
        end
    end
end

function update_npm
    if command -v npm &>/dev/null && string match -qr "^$HOME" (which npm)
        __update_show_header "Updating npm packages"
        npm update -g
        npm i -g prettier@latest vscode-langservers-extracted@latest @prisma/language-server@dev @vtsls/language-server@latest
    end
end

function update_deno
    if command -v deno &>/dev/null && string match -qr "^$HOME" (which deno)
        __update_show_header "Updating Deno"
        deno upgrade
    end
end

function update_completions
    __update_show_header "Updating completions"
    if command -v op &>/dev/null
        op completion fish > ~/dotfiles/fish/completions/op.fish
    end
end

function update_rudy_lldb_client
    __update_show_header "Updating rudy-lldb client"
    mkdir -p ~/.lldb
    curl https://raw.githubusercontent.com/samscott89/rudy/refs/heads/main/rudy-lldb/python/rudy_lldb.py -o ~/.lldb/rudy_lldb.py
end
