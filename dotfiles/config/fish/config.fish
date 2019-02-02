fish_vi_key_bindings

# disable left vi prompt
# if you want to use it elsewhere, use the function fish_default_mode_prompt
function fish_mode_prompt
end

# show exit status if not 0
function fish_right_prompt
    set exit_status $status
    if [ $exit_status != "0" ]
        set_color --bold red
        echo -n "$exit_status"
    end
end

function fish_prompt
    if [ $status != "0" ]
        set_color --bold red
    else
        set_color --bold green
    end
    if [ -n "$RANGER_LEVEL" ]
        echo -n "(ranger) "
    end
    echo -n (prompt_pwd)
    echo -n ' > '
end

function fish_greeting
end

# colored less/man
export LESS=-R
export LESS_TERMCAP_mb=\e'[1;31m'     # begin bold
export LESS_TERMCAP_md=\e'[1;36m'     # begin blink
export LESS_TERMCAP_me=\e'[0m'        # reset bold/blink
export LESS_TERMCAP_so=\e'[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=\e'[0m'        # reset reverse video
export LESS_TERMCAP_us=\e'[1;32m'     # begin underline
export LESS_TERMCAP_ue=\e'[0m'        # reset underline

# del to move to my trash
function del
    ~/scripts/trash.sh $argv
end

# start ranger and change working directory on exit
function rangercd
    set tmp (mktemp)
    ranger "--cmd=set column_ratios 1,1" --choosedir="$tmp" "$argv"
    cd (cat $tmp)
    rm -f $tmp
end

abbr r rangercd


abbr ll "ls -lh $argv"
abbr la "ls -alh $argv"

abbr p "sudo pacman"
abbr pss "pacman -Ss"

abbr .. 'cd ..; pwd'
abbr ... 'cd ..; ..'
abbr .... 'cd ..; ...'

abbr gs 'git status'
abbr ga 'git add'
abbr gc 'git commit'
abbr gd 'git diff'
abbr gl 'git log'
abbr gpl 'git pull'
abbr gps 'git push'

abbr e 'emacsclient -t '

export EDITOR="emacsclient_t"
export TERMINAL="termite"
export BROWSER="firefox"
export READER="zathura"

# start x if not running already
[ -z "$DISPLAY" ]; and [ (tty) = /dev/tty1 ]; and startx
