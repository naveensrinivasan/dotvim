# Disable local Time Machine snapshots
sudo tmutil disablelocal

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

#git settings
git config --global user.name "naveen"

git config --global user.email "172697+naveensrinivasan@users.noreply.github.com"

git config --global credential.helper osxkeychain

git config --global user.signingkey 408593DE

git config --global commit.gpgsign true

#sign commits
git config --global alias.commit commit -S
