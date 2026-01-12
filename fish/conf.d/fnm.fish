if command -v fnm &>/dev/null
    set -l fnm_args --shell fish --fnm-dir "$HOME/.fnm"
    if status is-interactive
        set -a fnm_args --use-on-cd
    end
    fnm env $fnm_args | source
end
