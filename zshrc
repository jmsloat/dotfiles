# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_THEME="spaceship"
plugins=(
    git 
    zsh-aliases-exa 
    sudo 
    git 
    jsontools 
    golang 
    tmux
    # zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
fpath+=$HOME/.zsh/pure

alias vim='nvim'
alias vimrc='nvim ~/.config/nvim/init.vim'
alias chrome='google-chrome-stable'
alias google-chrome='google-chrome-stable'
export EDITOR='nvim'

export CHROME_EXECUTABLE='google-chrome-stable'

export PATH=$PATH:/home/sloat/go/bin
export PATH=$PATH:/home/sloat/snap/flutter/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
