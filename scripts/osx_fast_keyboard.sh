# On macOS Sierra, a restart was required to get these settings to apply "right"
echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1

echo "Set a shorter Delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Revert to default settings with:
# defaults delete NSGlobalDomain KeyRepeat
# defaults delete NSGlobalDomain InitialKeyRepeat
