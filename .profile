# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
#PATH="$HOME/bin:$HOME/.local/bin:usr/local/stata"

PATH="/bin:/usr/bin:/usr/local/bin:$HOME/bin"
# PATH="/bin:/usr/bin:/usr/local/bin:$HOME/bin:/usr/local/stata"

# export XDG_CURRENT_DESKTOP=GNOME

function eyd3(){
    eyeD3 --add-image "$1:FRONT_COVER" *.mp3
}

function eyd3fl(){
    eyeD3 --add-image "$1:FRONT_COVER" *.flac
}



# adds folder to syncthing
function stfad(){
    dir="$(basename "$1")"
    id=$(date +%s)
    stman folder add "$1" --label "$dir" "$id"
    # "laptop"
}

# stman folder add laptop ~/Music/Planet\ Funk/The\ Great\ Shake/ laptop --label The\ Great\ Shake
# stman folder add ~/Music/Throwing\ Snow/Embers/ --label Embers 12345



export PATH="$HOME/.cargo/bin:$PATH"
