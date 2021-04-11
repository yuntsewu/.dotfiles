export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi



alias fj='kinit --password-file=$HOME/.kinit_auth -f && mwinit -o'

# npm local settings
if [ -d ~/.npm-packages ]; then
    NPM_PACKAGES="${HOME}/.npm-packages"
    export PATH="$PATH:$NPM_PACKAGES/bin"
    export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
fi


# Distro specific settings
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # ...
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
else
    # Unknown.
fi
