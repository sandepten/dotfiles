# Neovim
# install bob
if ! command -v bob &> /dev/null
then
    echo "bob could not be found"
    echo "installing bob"
    brew install bob
fi

# install neovim
if ! command -v nvim &> /dev/null
then
    echo "neovim could not be found"
    echo "installing neovim"
    bob install nightly
fi
