if [[ -v ITERM_SESSION_ID ]]; then
    if [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
        source "${HOME}/.iterm2_shell_integration.zsh"
    fi

    alias dark="it2setcolor preset 'GitHub Dark'"
    alias light="it2setcolor preset 'GitHub Light'"
fi
