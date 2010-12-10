#############################################################################
#
# mycomplete.bash: Custom functions for context-aware bash shell autocomplete
#
# Author: Joy Dutta (jdutta@gmail.com)
#
#############################################################################

function _my_ssh_complete_()
{
    local cmd="${1##*/}"
    local word=${COMP_WORDS[COMP_CWORD]}
    local line=${COMP_LINE}
    local hosts="`cat ~/.ssh/known_hosts | cut -f1 -d' '`"
    local use=""
    if [ "$word" == "" ]; then
        use="$hosts"
    else
        use="`echo $hosts | grep $word`"
    fi

    COMPREPLY=($(compgen -W "$use"  -- "${word}"))
}

complete -F _my_ssh_complete_ ssh yssh

function _my_screen_complete_()
{
    local cmd="${1##*/}"
    local word=${COMP_WORDS[COMP_CWORD]}
    local line=${COMP_LINE}
    local screens="`screen -ls | egrep "[0-9]*\.[a-z]" | awk '{print $1;}' | cut -f2 -d"."`"
    local use=""
    if [ "$word" == "" ]; then
        use="$screens"
    else
        use="`echo $screens | grep $word`"
    fi

    COMPREPLY=($(compgen -W "$use"  -- "${word}"))
}

complete -F _my_screen_complete_ screen
