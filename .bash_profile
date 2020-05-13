shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=8192
export HISTFILESIZE=8192
export HISTIGNORE='ls:bg:fg:history:pbc'
export HISTTIMEFORMAT='%F %T '

export CLOUDSDK_PYTHON=/usr/bin/python2.7
export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
export NOEXEC_EXCLUDE="compass"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
export SHELL="/usr/local/bin/bash"

source ~/.git-prompt.sh
source ~/.bash_aliases
source ~/.git-completion.sh
source ~/.kubectl.bash-completion
source /usr/local/etc/bash_completion.d/password-store

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kark/code/google-cloud-sdk/path.bash.inc' ]; then . '/Users/kark/code/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kark/code/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/kark/code/google-cloud-sdk/completion.bash.inc'; fi

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function setup() {
    export GOVERSION="1.13"
    export PATH="$PATH:$HOME/code/goroots/go$GOVERSION/bin:$HOME/code/go/bin"
    export GOROOT_BOOTSTRAP=$(go env GOROOT)

    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/shims:$PATH"

    _brew_prefix_openssl="/usr/local/opt/openssl@1.1"
    _brew_prefix_readline="/usr/local/opt/readline"
    export LDFLAGS="-L$_brew_prefix_openssl/lib -L$_brew_prefix_readline/lib"
    export CPPFLAGS="-I$_brew_prefix_openssl/include -I$_brew_prefix_readline/include"
    export CFLAGS="-I$_brew_prefix_openssl/include -I$_brew_prefix_readline/include"

    PATH=$PATH:$HOME/.rvm/bin:$HOME/.android/tools:$HOME/Library/Android/sdk/platform-tools:$HOME/code/tf

    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
}

setup &

eval "$(pyenv init -)"
