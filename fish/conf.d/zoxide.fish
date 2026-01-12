if status is-interactive
    if command -v zoxide &>/dev/null
        zoxide init fish | source
    end
end
