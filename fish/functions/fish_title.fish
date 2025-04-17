function fish_title
    if test "$TERM_PROGRAM" = "zed"
        return
    end

    set -q argv[1]; or set argv fish
    echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
end
