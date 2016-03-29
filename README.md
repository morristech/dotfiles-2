# Dotfiles

Requires [homebrew](https://github.com/Homebrew/homebrew) and uses the [homesick](https://github.com/technicalpickles/homesick) gem to handle syncing repo between different machines and linking to the home directory.

### Installation

Copy and paste the code below to install dependencies.

```sh
# Install home-brew dependencies
brew install vim
brew install zsh
brew install zsh-syntax-highlighting
brew install z
brew install diff-so-fancy

# Install oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

```sh
# Install the homesick gem
gem install homesick
# Clone this repo
homesick clone git@github.com:dvoiss/dotfiles.git
# Symlink it
homesick symlink dotfiles
```
