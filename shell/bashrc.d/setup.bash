shell=$(basename "$SHELL")

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# --- Setup fzf ------
if [[ ! "$PATH" == */home/kato/.fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}/home/kato/.fzf/bin"
fi
source <(fzf --"$shell")
# --------------------

# --- completion ------
command -v starship >/dev/null 2>&1 && eval "$(starship init $shell)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init $shell)"
command -v uv >/dev/null 2>&1 && eval "$(uv generate-shell-completion $shell)"
command -v uvx >/dev/null 2>&1 && eval "$(uvx --generate-shell-completion $shell)"
command -v ruff >/dev/null 2>&1 && eval "$(ruff generate-shell-completion $shell)"
command -v jj >/dev/null 2>&1 && source <(jj util completion $shell)
command -v rg >/dev/null 2>&1 && eval "$(rg --generate complete-$shell)"
command -v fd >/dev/null 2>&1 && eval "$(fd --gen-completions $shell)"

command -v molgeom >/dev/null 2>&1 && eval "$(_MOLGEOM_COMPLETE=${shell}_source molgeom)"
# ---------------------

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi
