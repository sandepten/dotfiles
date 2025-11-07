#— Define where Zinit lives
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

#— Initialize completions
autoload -U compinit && compinit
zinit cdreplay -q

#— Turbo-load lightweight snippets
zinit ice turbo depth=1 lucid
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::vscode

#— Fast syntax highlighting & autosuggestions
zinit ice atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice atload"!_zsh_autosuggest_start" lucid
zinit light zsh-users/zsh-autosuggestions

#— zsh-completions, loaded after compinit
zinit light zsh-users/zsh-completions

#— fzf & fzf-tab
zinit ice from"gh-r" as"program" atclone"./install --bin"
zinit light junegunn/fzf

zinit ice depth=1
zinit light Aloxaf/fzf-tab

#— Atuín history tracker
zinit load atuinsh/atuin

#— zsh-vi-mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

#— Starship prompt
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship
