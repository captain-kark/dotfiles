shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=16348
export HISTFILESIZE=16348
export HISTIGNORE='ls:bg:fg:history:pbc'
export HISTTIMEFORMAT='%F %T '

export CLOUDSDK_PYTHON=/usr/bin/python2.7
export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
export NOEXEC_EXCLUDE="compass"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
export SHELL="/usr/local/bin/bash"

source ~/.git-prompt.sh
source ~/.bash_aliases

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kark/code/google-cloud-sdk/path.bash.inc' ]; then . '/Users/kark/code/google-cloud-sdk/path.bash.inc'; fi

if [ -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then . "$(brew --prefix)/etc/profile.d/bash_completion.sh"; fi
if [ -f '/Users/kark/code/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/kark/code/google-cloud-sdk/completion.bash.inc'; fi

source <(kub completion bash)
source /usr/local/etc/bash_completion.d/password-store
source ~/.git-completion.sh

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export GOVERSION="1.13"
export PATH="$PATH:$HOME/code/goroots/go$GOVERSION/bin:$HOME/code/go/bin"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(pyenv init -)"

function setup() {
    export GOROOT_BOOTSTRAP=$(go env GOROOT)
    _brew_prefix_openssl="/usr/local/opt/openssl@1.1"
    _brew_prefix_readline="/usr/local/opt/readline"
    export LDFLAGS="-L$_brew_prefix_openssl/lib -L$_brew_prefix_readline/lib"
    export CPPFLAGS="-I$_brew_prefix_openssl/include -I$_brew_prefix_readline/include"
    export CFLAGS="-I$_brew_prefix_openssl/include -I$_brew_prefix_readline/include"
}
