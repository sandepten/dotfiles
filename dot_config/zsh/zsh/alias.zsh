#! These are all the alias I like

# neovim
alias nv=nvim
alias vi=nvim
alias vim=nvim

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

# yazi file explorer
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# port process and kill
function whichport() {
  lsof -i tcp:$1
}
function killport() {
  lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill -9
}

# clenaup node_modules in the current directory recursively
function cleanmodules() {
  find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
}

# extract
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
      (*.tar.gz|*.tgz) [ -z $commands[pigz] ] && tar zxvf "$1" || pigz -dc "$1" | tar xv ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
    (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
      && tar --lzma -xvf "$1" \
      || lzcat "$1" | tar xvf - ;;
  (*.tar) tar xvf "$1" ;;
  (*.gz) [ -z $commands[pigz] ] && gunzip "$1" || pigz -d "$1" ;;
  (*.bz2) bunzip2 "$1" ;;
  (*.xz) unxz "$1" ;;
  (*.lzma) unlzma "$1" ;;
  (*.Z) uncompress "$1" ;;
  (*.zip|*.war|*.jar|*.sublime-package) unzip "$1" -d $extract_dir ;;
  (*.rar) unrar x -ad "$1" ;;
  (*.7z) 7za x "$1" ;;
  (*.deb)
    mkdir -p "$extract_dir/control"
    mkdir -p "$extract_dir/data"
    cd "$extract_dir"; ar vx "../${1}" > /dev/null
    cd control; tar xzvf ../control.tar.gz
    cd ../data; tar xzvf ../data.tar.gz
    cd ..; rm *.tar.gz debian-binary
    cd ..
    ;;
  (*)
    echo "extract: '$1' cannot be extracted" 1>&2
    success=1
    ;;
esac

(( success = $success > 0 ? $success : $? ))
(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
shift
  done
}

# finder
alias f='open -a Finder '

# funny sudo
alias please='sudo'

# tmux
# Bind the widget to Ctrl+P
# bindkey '^P' _fzf_tmux_switcher
bindkey -s ^p "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"
