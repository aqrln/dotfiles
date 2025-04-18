if status is-interactive
    if command -v direnv &> /dev/null
        direnv hook fish | source
    end

    if command -v zoxide &> /dev/null
        zoxide init fish | source
    end
end
