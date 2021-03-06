#if [ -f /etc/bashrc ]; then
#    source /etc/bashrc
#fi

#if [ -f ~/.profile ]; then
#    source ~/.profile
#fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi

ulimit -S -c 0  # Don't want any coredumps.

#-------------------------------------------------------------
# Shell Prompt
#-------------------------------------------------------------


if [[ "${DISPLAY%%:0*}" != "" ]]; then  
    HILIT=${red}   # remote machine: prompt will be partly red
else
    HILIT=${cyan}  # local machine: prompt will be partly cyan
fi

#  --> Replace instances of \W with \w in prompt functions below
#+ --> to get display of full path name.

#function fastprompt()
#{
#    unset PROMPT_COMMAND
#    case $TERM in
#        *term | rxvt )
#            PS1="${HILIT}[\h]$NC \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
#        linux )
#            PS1="${HILIT}[\h]$NC \W > " ;;
#        *)
#            PS1="[\h] \W > " ;;
#    esac
#}


_powerprompt()
{
    LOAD=$(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")
    BAT=$(~/bin/batstat.sh)
}

function powerprompt()
{

    PROMPT_COMMAND=_powerprompt
#    case $TERM in
#        *  )  
            PS1='\n${HILIT}[\u@\h | \A - $BAT] $(__git_ps1 "(%s)") \n \w \n ->'
        #linux )
        #    PS1="${HILIT}[\A - \$LOAD]$NC\n[\u@\h \#] \W > " ;;
        #* )
        #    PS1="[\A - \$LOAD]\n[\u@\h \#] \W > " ;;
#    esac
}

powerprompt     # This is the default prompt -- might be slow.
#fastprompt    # If too slow, use fastprompt instead. ...

#PATH=$PATH:~/bin
#PS1='\n${HILIT}[\u@\h | \A - $BAT] $(__git_ps1 "(%s)")$NC \[\033] \n \w \n ->'
