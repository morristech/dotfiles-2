# misc:
alias ls="ls -AFhCHG"
alias vi="vim"
alias tmux="TERM=screen-256color-bce tmux"
alias pyserve="python -m SimpleHTTPServer"
alias ssh="ssh -v"

# redis:
alias rediscli="redis-cli -h localhost -p 6379"
alias redismon="rediscli monitor"

# git (also aliased in .gitconfig):
alias gp="git push origin HEAD"
alias gs="git status"
alias gd="git diff"

# directory shortcuts
alias downloads="cd ~/Downloads"
alias dev="cd ~/dev"
alias atools="cd $ANDROID_HOME/tools"

# android monitor:
alias amonitor="$ANDROID_HOME/tools/monitor"