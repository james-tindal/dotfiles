# https://apple.stackexchange.com/a/167143/368688

# set up iTerm2
brew cask install iTerm2
defaults delete com.googlecode.iterm2
cp com.googlecode.iterm2.plist ~/Library/Preferences
defaults read -app iTerm
# Run on startup
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/iTerm.app", hidden:true}'

# set up zsh
brew install zsh
echo /usr/local/bin/zsh | sudo tee -a /etc/shells > /dev/null
chsh -s /usr/local/bin/zsh
ln -s ~/.config/dotfiles/.zshrc ~/.zshrc

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --skip-chsh --unattended --keep-zshrc

open /Applications/iTerm.app
