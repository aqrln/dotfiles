setup_completions() {
    if type brew &>/dev/null; then
        export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    fi

    if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
        export FPATH="$HOME/.zsh/completions:$FPATH"
    fi


    autoload -Uz compinit

    # Use cached completions if less than 24 hours old
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"

    # Fast load without security checks (-C flag)
    # Only run the full check weekly
    if [[ -n "$zcompdump"(#qNmh-168) ]]; then
        # If older than a week, do a full security check
        compinit -d "$zcompdump"
    else
        # Fast load without security checks if updated recently
        compinit -C -d "$zcompdump"
    fi
}
