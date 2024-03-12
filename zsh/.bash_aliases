#INFO: weather
alias weather="curl wttr.in/Lagos,Nigeria"

alias cls="clear"
alias rg="ranger"
alias nf="neofetch"
alias zc="nvim ~/.zshrc"
alias ls="ls -la --color"

#INFO: directory aliases
alias code="cd ~/Desktop/me/coder"
alias neodots="cd ~/.config/nvim"
alias dots="cd ~/.dots"
alias obsi="cd ~/Documents/blursidian"
alias vim="vim -S https://raw.githubusercontent.com/sijirama/neodots/main/.vimrc"
alias e="xdg-open ."

#INFO: Wifi Management
alias wifi="nmcli d wifi list"

#INFO: git aliases
alias gs='git status'
alias ga='git add .'
alias gp='git push'

gitall() {
    git add .
    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then
        git commit -m "$1"
    else
        git commit -m update
    fi
    git push
} 

gac () {
    git commit -m "$1"
}


#INFO: cool aliases
alias mypwd="echo My current directory is $(pwd)"
alias fman="compgen -c | fzf | xargs man"

#INFO: Tmux aliases

# List all tmux sessions
alias tl='tmux list-sessions'

# Attach to last tmux session
alias tal='tmux attach'

# Attach to an existing tmux session
alias ta='tmux attach -t'

# Kill a tmux session
alias tk='tmux kill-session -t'

# Kill a tmux session
alias tsk='tmux kill-session'

# Create a new tmux window
alias tw='tmux new-window'

# Kill the current tmux window
alias tkw='tmux kill-window'

# Create a new tmux session
alias tns='tmux new-session'
