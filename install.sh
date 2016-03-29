#
# A quick little install script for my dotfiles.
#

echo "Installing home-brew dependencies..."

brew install vim
brew install zsh
brew install zsh-syntax-highlighting
brew install z

echo "Installing oh-my-zsh..."

curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

echo "Initiating git submodules..."

git submodule init