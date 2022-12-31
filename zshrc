source ~/.antigen.zsh


ZSH_THEME="eastwood"
plugins=(
    git 
    zsh-aliases-exa 
    sudo 
    jsontools 
    golang 
    tmux
)

antigen use oh-my-zsh
antigen bundle zsh-aliases-exa
antigen bundle sudo
antigen bundle tmux

antigen theme robbyrussell
antigen apply

alias vim='nvim'
alias vimrc='nvim ~/.config/nvim/init.vim'
alias chrome='google-chrome-stable'
alias google-chrome='google-chrome-stable'
export EDITOR='nvim'

export CHROME_EXECUTABLE='google-chrome-stable'

export PATH=$PATH:/home/sloat/go/bin
export PATH=$PATH:/home/sloat/snap/flutter/bin
export PATH=/home/jsloat/.nimble/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=/home/jsloat/.local/bin:$PATH
export PATH=/home/jsloat/go/bin:$PATH
