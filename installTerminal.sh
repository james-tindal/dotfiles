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

# Install applescript List & Record Tools     # No longer works as of Mojave
curl -L http://latenightsw.com/archives/ListRecordTools1.0.6.dmg -o ListRecordTools1.0.6.dmg
hdiutil attach ListRecordTools1.0.6.dmg
md ~/Library/ScriptingAdditions
cp -r "/Volumes/List & Record Tools 1.0.6/List & Record Tools.osax" ~/Library/ScriptingAdditions
hdiutil detach "/Volumes/List & Record Tools 1.0.6"
rm ListRecordTools1.0.6.dmg
