#! These are all the alias I like

# Basic
alias nv=nvim
alias vi=nvim
alias prisma="npx prisma"
alias cat="bat --plain" # bat is a cat clone with syntax highlighting and Git integration

# exa replace ls
alias c='clear'                                                        # clear terminal
# alias l='eza -lh  --icons=auto'                                        # long list
# alias ls='eza -1   --icons=auto'                                       # short list
# alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
# alias ld='eza -lhD --icons=auto'                                       # long list dirs
# alias lt='eza --icons=auto --tree'                                     # list folder as tree
alias ld='eza -lD' # lists only directories (no files)
alias lf='eza -lF --color=always | grep -v /' # lists only files (no directories)
alias lh='eza -dl .* --group-directories-first' # lists hidden files
alias ll='eza -al --group-directories-first' # lists all files (including hidden) with directories first
alias ls='eza -alF --color=always --sort=size | grep -v /' # lists only files sorted by size
alias lt='eza -al --sort=modified' # lists everything sorted by time updated
alias tree="eza --tree --level=2  --icons --git"

# git
alias gla='git log --oneline --graph --all'

# AUR Helper
alias un='$aurhelper -Rns'                                             # uninstall package
alias up='$aurhelper -Syu'                                             # update system/package/aur
alias pl='$aurhelper -Qs'                                              # list installed package
alias pa='$aurhelper -Ss'                                              # list availabe package
alias pc='$aurhelper -Sc'                                              # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -

# JS Ecosystem
p() { # detect package manager and run it
  if [[ -f bun.lockb ]]; then
    command bun "$@"
  elif [[ -f pnpm-lock.yaml ]]; then
    command pnpm "$@"
  elif [[ -f yarn.lock ]]; then
    command yarn "$@"
  elif [[ -f package-lock.json ]]; then
    command npm "$@"
  else
    command pnpm "$@"
  fi
}

# Others
nah() {
  git reset --hard
  git clean -df
  if [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then
    git rebase --abort
  fi
}

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
