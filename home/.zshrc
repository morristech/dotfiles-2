# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
#ZSH_THEME="minimal"
ZSH_THEME="steeef"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git adb coffee gradle sublime vi-mode)

# User configuration

export PATH="$PATH:/usr/local:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

source $ZSH/oh-my-zsh.sh

# User customization below:

unsetopt correct_all
setopt correct
setopt no_share_history
unsetopt share_history

export ANDROID_HOME=~/android-sdk
export ANDROID_NDK="$ANDROID_HOME/ndk-bundle"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

source `brew --prefix`/etc/profile.d/z.sh
source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add custom aliases
if [ -f ~/aliases.sh ]; then
    source ~/aliases.sh
else
    echo "could not find extra aliases."
fi

# Add custom functions
if [ -f ~/functions.sh ]; then
    source ~/functions.sh
else
    echo "could not find extra functions."
fi

# Add any local stuff which isn't committed to the repo:
if [ -f ~/ignored.sh ]; then
    source ~/ignored.sh
fi

# https://superuser.com/questions/742171/zsh-z-shell-numpad-numlock-doesnt-work

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[On" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * / =
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
bindkey -s "^[OX" "="

# reverse history search
bindkey -v
bindkey '^R' history-incremental-search-backward
