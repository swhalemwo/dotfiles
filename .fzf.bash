# Setup fzf
# ---------
if [[ ! "$PATH" == */home/johannes/.fzf/bin* ]]; then
  export PATH="$PATH:/home/johannes/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/johannes/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/johannes/.fzf/shell/key-bindings.bash"

