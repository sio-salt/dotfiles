# -------------------------------------
# My custom aliases for bash/zsh shell
# -------------------------------------

alias ls='ls --color=auto -hF'
alias ll='ls -alF'
alias la='ls -A'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias up='z .. ; ls'
alias upup='z ../.. ; ls'
alias upupup='z ../../.. ; ls'
alias upupupup='z ../../../.. ; ls'
alias upupupupup='z ../../../../.. ; ls'
alias upupupupupup='z ../../../../../.. ; ls'
alias nv='nvim'
alias 10back='source $HOME/00.repos/c.cli-tools/backcd.bash/backcd.bash'
alias python="uv run python"
alias py="python"

function zl() {
    z $1
    ls
}

function _find_activate_venv_bash() {
    local dir="$PWD"
    local home_top="$(dirname "$HOME")"

    if [[ $dir != *"${HOME}"* ]]; then
        echo "Not under \$HOME"
        return 1
    fi

    shopt -s nullglob # Unmatched globs vanish

    while [[ $dir != "$home_top" && $dir != / ]]; do
        local -a venvs=()

        # Collect candidate venv directories in this level only
        for d in "$dir"/*/ "$dir"/.[!.]*/; do
            [[ -f $d/bin/activate ]] && venvs+=("${d%/}")
        done

        case ${#venvs[@]} in
        0)
            dir=$(dirname "$dir")
            continue
            ;; # nothing here ─ go up
        1)
            source "${venvs[0]}/bin/activate" # exactly one ─ auto-activate
            echo "Activated: ${venvs[0]}"
            return 0
            ;;
        *) # multiple ─ ask
            echo "Select virtual environment in '$dir':"
            select v in "${venvs[@]}" "Cancel"; do
                ((REPLY == ${#venvs[@]} + 1)) && {
                    echo "Cancelled."
                    return 1
                }
                if [[ $REPLY =~ ^[0-9]+$ && $REPLY -ge 1 && $REPLY -le ${#venvs[@]} ]]; then
                    source "${venvs[REPLY - 1]}/bin/activate"
                    echo "Activated: ${venvs[REPLY - 1]}"
                    return 0
                fi
                echo "Invalid choice."
            done
            ;;
        esac
    done

    echo "No Python venv found"
    return 1
}

function _find_activate_venv_zsh {
    emulate -L zsh   # Start a local, clean zsh environment
    setopt null_glob # Unmatched globs vanish (bash: shopt -s nullglob)

    local dir=$PWD
    local home_top=${HOME:h} # One level above $HOME  (bash: dirname "$HOME")

    # Must be under $HOME
    if [[ $dir != *"${HOME}"* ]]; then
        echo "Not under \$HOME"
        return 1
    fi

    # Walk up the directory tree until home_top or /
    while [[ $dir != $home_top && $dir != / ]]; do
        local -a venvs=() # Candidate venvs in this level

        # Collect candidate venv directories at this depth only
        for d in "$dir"/*/ "$dir"/.[!.]*/; do
            [[ -f $d/bin/activate ]] && venvs+=("${d%/}")
        done

        case ${#venvs} in
        0)
            dir=${dir:h} # Go one level up
            continue
            ;;
        1)
            source "${venvs[1]}/bin/activate"
            echo "Activated: ${venvs[1]}"
            return 0
            ;;
        *)
            echo "Select virtual environment in '$dir':"
            select v in "${venvs[@]}" "Cancel"; do
                if ((REPLY == ${#venvs} + 1)); then
                    echo "Cancelled."
                    return 1
                elif ((REPLY >= 1 && REPLY <= ${#venvs})); then
                    source "${venvs[REPLY]}/bin/activate"
                    echo "Activated: ${venvs[REPLY]}"
                    return 0
                else
                    echo "Invalid choice."
                fi
            done
            ;;
        esac
    done

    echo "No Python venv found"
    return 1
}

if [ -n "$ZSH_VERSION" ]; then
    alias venv='_find_activate_venv_zsh'
elif [ -n "$BASH_VERSION" ]; then
    alias venv='_find_activate_venv_bash'
fi

# -------------------------------------
# WSL aliases
# -------------------------------------
if uname -r | grep -iq microsoft; then
    function explorerfunc() {
        if [ $# = 0 ]; then
            explorer.exe .
        elif [ $# = 1 ]; then
            if [ ! -e $1 ]; then
                echo "error: $1 does not exist"
                return 1
            fi
            relpath=$(realpath $1 | xargs realpath --relative-to=$(pwd))
            echo $relpath
            winpath=$(echo $relpath | sed "s:\/:\\\:g")
            echo \".\\$winpath\"
            explorer.exe \"$winpath\"
        else
            echo "ERROR : too many arg"
        fi
    }

    function cdexplorer() {
        expdir="$1"
        if [ "$expdir" = "" ]; then
            cd ~
        fi
        drive=${expdir:0:2}
        #echo $drive

        cdg=''
        if [ "$drive" = "C:" ]; then
            cdg=c
        elif [ "$drive" = "D:" ]; then
            cdg=d
        elif [ "$drive" = "G:" ]; then
            cdg=g
        else
            echo "ERROR : unknown drive"
        fi

        cd $(echo "$expdir" | sed 's:\\:/:g' | sed "s|$drive|/mnt/$cdg|g")
        result=$?
        if [ $result = 0 ]; then
            :
        else
            echo "ERROR"
        fi
    }
    function clexplorer() {
        expdir="$1"
        if [ "$expdir" = "" ]; then
            cd ~
        fi
        drive=${expdir:0:2}

        cdg=''
        if [ "$drive" = "C:" ]; then
            cdg=c
        elif [ "$drive" = "D:" ]; then
            cdg=d
        elif [ "$drive" = "G:" ]; then
            cdg=g
        else
            echo "ERROR : unknown drive"
        fi

        cd $(echo "$expdir" | sed 's:\\:/:g' | sed "s|$drive|/mnt/$cdg|g")
        result=$?
        if [ $result = 0 ]; then
            #echo $result
            ls
        else
            echo "ERROR"
        fi
    }

    alias explorer='explorerfunc'
    alias expl='explorer'
    alias clip="/mnt/c/Windows/System32/clip.exe"
    alias cdx=cdexplorer
    alias clx=clexplorer
    alias Chemcraft="/mnt/c/Chemcraft/Chemcraft.exe"
fi
