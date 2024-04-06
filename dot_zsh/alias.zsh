#! These are all the alias I like

# Basic
alias pn=pnpm
alias px=pnpx
alias nv=nvim
alias prisma="npx prisma"
alias minecraft="java -jar ~/Downloads/SKlauncher-3.1.1.jar"
alias cat=bat # bat is a cat clone with syntax highlighting and Git integration

# exa replace ls
alias ls="exa"
alias ll="exa -alh"
alias la="exa -la"
alias l="exa -l --git"
alias tree="exa --tree --level=3"

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
