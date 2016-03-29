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

export ANDROID_HOME=~/android-sdk
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/Users/david.voiss/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

source `brew --prefix`/etc/profile.d/z.sh
source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add custom aliases
if [ -f `pwd`/aliases.sh ]; then
    source `pwd`/aliases.sh
else
    echo "could not find extra aliases."
fi

# Add custom functions
if [ -f `pwd`/functions.sh ]; then
    source `pwd`/functions.sh
else
    echo "could not find extra functions."
fi

# Add any local stuff which isn't committed to the repo:
if [ -f `pwd`/ignored.sh ]; then
    source `pwd`/ignored.sh
fi