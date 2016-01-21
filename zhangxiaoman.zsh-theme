# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
# 
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/
# 2016-01-21 21:59:07 zhangxiaoman



# Directory info.
local current_dir='${PWD/#$HOME/~}'

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[blue]%}"
YS_VCS_PROMPT_PREFIX2="%{$fg[red]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY="%{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN="%{$fg[green]%}o"


# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) ${YS_VCS_PROMPT_DIRTY}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) ${YS_VCS_PROMPT_CLEAN}"
# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
    # make sure this is a hg dir
    if [ -d '.hg' ]; then
        echo -n "${YS_VCS_PROMPT_PREFIX1}hg(${YS_VCS_PROMPT_PREFIX2}"
        echo -n $(hg branch 2>/dev/null)
        if [ -n "$(hg status 2>/dev/null)" ]; then
            echo -n "%{$fg[blue]%}) $YS_VCS_PROMPT_DIRTY"
        else
            echo -n "%{$fg[blue]%}) $YS_VCS_PROMPT_CLEAN"
        fi
        echo -n "$YS_VCS_PROMPT_SUFFIX"
    fi
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $ 
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$fg[cyan]%}%n \
%{$fg[white]%}: \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${hg_info}\
${git_info} 
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
RPROMPT="%{$fg[green]%}[%*]%{$reset_color%}"


if [[ "$USER" == "root" ]]; then
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
%{$fg[white]%}at \
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
fi
