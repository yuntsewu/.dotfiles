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

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi



alias fj='kinit --password-file=$HOME/.kinit_auth -f && mwinit -o'

# npm local settings
if [ -d ~/.npm-packages ]; then
    NPM_PACKAGES="${HOME}/.npm-packages"
    export PATH="$PATH:$NPM_PACKAGES/bin"
    # Preserve MANPATH if you already defined it somewhere in your config.
    # Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
    export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
else
    if [ ! -f $HOME/.kinit_auth ]; then
        read -p "Enter Amazon corp password: " amazon_password
    fi
    echo $amazon_password > .kinit_auth

    if [ ! -f $HOME/.nextcloud_auth ]; then
        read -p "Enter NextCloud password: " nextcloud_password
    fi
    echo $nextcloud_password > .nextcloud_auth
    print "404: ~/.npm-packages not found.\nmkdir ~/.npm-packages\nnpm config set prefix "${HOME}/.npm-packages""
    mkdir ~/.npm-packages
    npm config set prefix "${HOME}/.npm-packages"
    npm install -g \
        expo-cli \
        joplin
    
    # setup joplin for first time
    export NEXTCLOUD_PASS=$(cat $HOME/.nextcloud_auth)
    unsetopt correct_all # Turn off annoying auto correct messages
    joplin config sync.target 5
    joplin config sync.5.path https://cloud.yuntsewu.com/remote.php/dav/files/ytw/Documents/Notes
    joplin config sync.5.username ytw
    joplin config sync.5.password $NEXTCLOUD_PASS
    joplin config editor vim
    joplin sync
    joplin export ~/notes/ --format md
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
