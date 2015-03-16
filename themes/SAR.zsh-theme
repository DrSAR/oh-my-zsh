# Shows little symbol '±' if you're currently at a git repo and '○' all other times
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '○'
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}
# Build the main prompt
if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
    PROMPT='
%{$fg[magenta]%}%m%{$reset_color%} (%{$fg[yellow]%}%n%{$reset_color%}) %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)${return_code}$(git_prompt_status)%{$reset_color%}
$(virtualenv_info)$(prompt_char) '

    ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    # Display exitcode on the right when >0
    return_code=" %(?..%{$fg[red]%}%?↵%{$reset_color%})"

    # Displays different symbols (simultaneously) depending on the current status of your git repo.
    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
    RPROMPT='<%D{%H:%M %Z %d.%m.}>'
else
    PROMPT='[%n@%m:%~$(git_prompt_info)]
%# '
    ZSH_THEME_GIT_PROMPT_PREFIX=" on"
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    RPROMPT='${return_code}$(git_prompt_status) ${date}'

    ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
    ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
fi

#all my aliases 
alias hgrep='history| grep '
alias pgrep='ps waux|grep '
alias rgrep='grep -r'
# thanks to http://stackoverflow.com/questions/22742299/global-alias-for-last-file-in-current-directory
alias -g lafi='`ls -rt | tail -n 1 | tee >({ printf "last file: "; cat; } >&2)`'
alias ip_ostwald_fwd='ssh -N -L 8900:localhost:8888 ostwald &; echo "go to (cmd-double-click): http://localhost:8900"'
alias grep_nocomment='grep "^[^#]"'

# setup for virtualenv following http://www.rosslaird.com/blog/first-steps-with-mezzanine/
# (this was necessitated by dabbling in mezzanine (a cms driven by django))
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh 
export PIP_VIRTUALENV_BASE=$WORKON_HOME

