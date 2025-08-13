DIRCOLORS_FILES=(
    "$HOME/00.repos/dotfiles/shell/bliss.dircolors"
    "$HOME/00.repos/dotfiles/shell/dircolors"
)

if command -v dircolors >/dev/null 2>&1; then
    applied=false

    for f in "${DIRCOLORS_FILES[@]}"; do
        test -r $f && eval "$(dircolors -b $f)" || eval "$(dircolors -b)"
        applied=true
    done

    $applied || eval "$(dircolors -b)"
fi
