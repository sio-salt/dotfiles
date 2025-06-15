PROMPT='[%{$fg_bold[green]%}%n%{$reset_color%} in %{$fg[cyan]%}%2~%{$reset_color%}$(git_prompt_info)]
%(?:%{$fg_bold[green]%}❯❯%{$reset_color%} :%{$fg_bold[red]%}❯❯%{$reset_color%} )'


ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}%1{✗%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"



# display vi mode
# RPS1_INS="%{$fg[green]%}[INS]%{$reset_color%}"
# RPS1_NOR="%{$fg[magenta]%}[NOR]%{$reset_color%}"
# RPS1_VIS="%{$fg[yellow]%}[VIS]%{$reset_color%}"
ZVM_PROMPT_INSERT="%{$fg[green]%}[INS]%{$reset_color%}"
ZVM_PROMPT_NORMAL="%{$fg[magenta]%}[NOR]%{$reset_color%}"
ZVM_PROMPT_VISUAL="%{$fg[yellow]%}[VIS]%{$reset_color%}"


# # insert mode at start
# RPS1=$RPS1_INS
RPS1=$ZVM_PROMPT_INSERT



# update RPS1 based on keymap and region
# function zle-line-pre-redraw {
#   if [[ $REGION_ACTIVE -ne 0 ]]; then
#     NEW_RPS1=$RPS1_VIS
#   elif [[ $KEYMAP == vicmd ]]; then
#     NEW_RPS1=$RPS1_NOR
#   elif [[ $KEYMAP == main ]]; then
#     NEW_RPS1=$RPS1_INS
#   fi
#
#   if [[ $RPS1 != $NEW_RPS1 ]]; then
#     RPS1=$NEW_RPS1
#     zle reset-prompt
#   fi
# }
#
#
# zle -N zle-line-pre-redraw


_update_rprompt_by_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)       RPS1=$ZVM_PROMPT_NORMAL ;;
    $ZVM_MODE_INSERT)       RPS1=$ZVM_PROMPT_INSERT ;;
    $ZVM_MODE_VISUAL*)      RPS1=$ZVM_PROMPT_VISUAL ;;
  esac
}

zvm_after_select_vi_mode_commands+=(_update_rprompt_by_vi_mode)

