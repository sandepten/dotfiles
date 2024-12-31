#! These are the path requirements for the system

# Go
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/sandepten/.local/bin

# fnm
FNM_PATH="/home/sandepten/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/sandepten/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

PATH=~/.console-ninja/.bin:$PATH

export PATH="$PATH:$(go env GOPATH)/bin"
## nvim as default editor
export EDITOR=/opt/homebrew/bin/nvim
