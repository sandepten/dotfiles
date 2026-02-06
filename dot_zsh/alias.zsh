#! These are all the alias I like

# neovim
alias nv=nvim
alias vi=nvim
alias vim=nvim
alias yay=paru

alias prisma="npx prisma"
alias cat="bat --plain" # bat is a cat clone with syntax highlighting and Git integration
alias c='clear' # clear terminal

# ls eza replacements
alias ld='eza -lD' # lists only directories (no files)
alias lf='eza -lF --color=always | grep -v /' # lists only files (no directories)
alias lh='eza -dl .* --group-directories-first' # lists hidden files
alias ll='eza -al --group-directories-first' # lists all files (including hidden) with directories first
alias ls='eza -alF --color=always --sort=size | grep -v /' # lists only files sorted by size
alias lt='eza -al --sort=modified' # lists everything sorted by time updated
alias tree="eza --tree --level=2  --icons --git"

# git
alias gla='git log --oneline --graph --all'
nah() { # git full nuke
  git reset --hard
  git clean -df
  if [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then
    git rebase --abort
  fi
}
# cherry-pick -x
alias gcp='git cherry-pick -x'

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# yazi file explorer - with error handling
function y() {
	if ! command -v yazi >/dev/null 2>&1; then
		echo "yazi not found - install with: cargo install yazi"
		return 1
	fi
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp" 2>/dev/null)" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# port process and kill - with error handling
function whichport() {
  lsof -i tcp:$1 2>/dev/null || echo "No process found on port $1"
}
function killport() {
  local pids
  pids=$(lsof -i tcp:$1 2>/dev/null | awk 'NR!=1 {print $2}')
  if [[ -n "$pids" ]]; then
    echo "$pids" | xargs kill -9
    echo "Killed processes on port $1"
  else
    echo "No process found on port $1"
  fi
}

# cleanup node_modules in the current directory recursively
function cleanmodules() {
  find . -name "node_modules" -type d -prune -exec rm -rf {} + 2>/dev/null || true
}

# extract - improved error handling
function extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
    return 1
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) command -v pigz >/dev/null && pigz -dc "$1" | tar xv || tar zxvf "$1" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
    (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
      && tar --lzma -xvf "$1" \
      || lzcat "$1" | tar xvf - ;;
  (*.tar) tar xvf "$1" ;;
  (*.gz) command -v pigz >/dev/null && pigz -d "$1" || gunzip "$1" ;;
  (*.bz2) bunzip2 "$1" ;;
  (*.xz) unxz "$1" ;;
  (*.lzma) unlzma "$1" ;;
  (*.Z) uncompress "$1" ;;
  (*.zip|*.war|*.jar|*.sublime-package) mkdir -p "$extract_dir" && unzip "$1" -d "$extract_dir" ;;
  (*.rar) unrar x -ad "$1" 2>/dev/null || echo "unrar not found, install for .rar support" ;;
  (*.7z) 7za x "$1" 2>/dev/null || echo "7za not found, install for .7z support" ;;
  (*.deb)
    mkdir -p "$extract_dir/control" "$extract_dir/data"
    cd "$extract_dir" || continue
    ar vx "../${1}" > /dev/null 2>&1 || { echo "ar not found, install for .deb support"; cd ..; continue; }
    cd control && tar xzvf ../control.tar.gz 2>/dev/null
    cd ../data && tar xzvf ../data.tar.gz 2>/dev/null
    cd .. && rm -f *.tar.gz debian-binary 2>/dev/null
    cd .. || continue
    ;;
  (*)
    echo "extract: '$1' cannot be extracted (unsupported format)" 1>&2
    success=1
    ;;
esac

success=$?
(( success == 0 && remove_archive == 0 )) && rm -f "$1"
shift
  done
}

# finder - macOS only
if [[ "$(uname)" == "Darwin" ]]; then
  alias f='open -a Finder '
else
  alias f='xdg-open '  # Linux alternative
fi

# funny sudo
alias please='sudo'

# Decode Base64 (atob)
atob() {
  if [ -t 0 ]; then
    # If no pipe, use the first argument
    node -e "console.log(atob('$1'))"
  else
    # If data is piped in
    node -e "process.stdin.on('data', d => console.log(atob(d.toString().trim())))"
  fi
}

# Encode Base64 (btoa)
btoa() {
  if [ -t 0 ]; then
    node -e "console.log(btoa('$1'))"
  else
    node -e "process.stdin.on('data', d => console.log(btoa(d.toString().trim())))"
  fi
}


function generate_uuid() {
  # Generate a UUID and remove the trailing newline.
  uuid=$(uuidgen | tr -d '\n')
  # Optional: convert to lowercase, as some systems output uppercase by default
  # uuid=${uuid:l} 
  echo "$uuid"
}
