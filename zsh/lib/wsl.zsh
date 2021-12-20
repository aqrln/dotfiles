if [[ -n "$WSL_DISTRO_NAME" ]]; then
    x11-forward () {
        export DISPLAY=$(ip route | awk '/^default/{print $3; exit}'):0
        export LIBGL_ALWAYS_INDIRECT=1
        printf "Start X11 using \033[1;36mvcxsrv -ac\033[0m in Windows.\n"
    }
fi
