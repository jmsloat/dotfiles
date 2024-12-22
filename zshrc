source ~/.antigen.zsh

antigen use oh-my-zsh
antigen bundle zsh-aliases-exa
antigen bundle sudo
antigen bundle tmux
antigen bundle fzf
antigen bundle jeffreytse/zsh-vi-mode

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme af-magic
antigen apply

zvm_after_init_commands+=()

alias vim='nvim'
alias vimrc='nvim ~/.config/nvim/init.vim'
alias chrome='google-chrome-stable'
alias google-chrome='google-chrome-stable'
export EDITOR='nvim'

export CHROME_EXECUTABLE='google-chrome-stable'
export WEZTERM_CONFIG_FILE='/home/jsloat/.config/wezterm/wezterm.lua'
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
export PATH=$PATH:/home/sloat/go/bin
export PATH=$PATH:/home/sloat/snap/flutter/bin
export PATH=/home/jsloat/.nimble/bin:$PATH
export PATH=/home/jsloat/go/bin:$PATH
export PATH=/home/jsloat/.local/bin:$PATH
export PATH=/home/jsloat/.local/share/bin:$PATH
export PATH=/home/jsloat/.local/share/bob/nvim-bin:$PATH

export WLR_NO_HARDWARE_CURSORS=1


# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
	# Append a command directly
	bindkey '^ ' autosuggest-accept
}
# bun completions
[ -s "/home/jsloat/.bun/_bun" ] && source "/home/jsloat/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/jsloat/.opam/opam-init/init.zsh' ]] || source '/home/jsloat/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
