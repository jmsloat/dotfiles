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

zvm_after_init_commands+=('[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh')

alias vim='nvim'
alias vimrc='nvim ~/.config/nvim/init.vim'
alias chrome='google-chrome-stable'
alias google-chrome='google-chrome-stable'
export EDITOR='nvim'

export CHROME_EXECUTABLE='google-chrome-stable'

ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
export PATH=$PATH:/home/sloat/go/bin
export PATH=$PATH:/home/sloat/snap/flutter/bin
export PATH=/home/jsloat/.nimble/bin:$PATH
export PATH=/home/jsloat/go/bin:$PATH
export PATH=/home/jsloat/.local/bin:$PATH
export PATH=/home/jsloat/.local/share/bin:$PATH
export PATH=/home/jsloat/.local/share/bob/nvim-bin:$PATH

bindkey '^ ' autosuggest-accept
