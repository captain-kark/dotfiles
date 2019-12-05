source ~/.bash_aliases
source ~/.git-prompt.sh
source ~/.git-completion.sh
source /usr/local/etc/bash_completion.d/password-store

export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
export NOEXEC_EXCLUDE="compass"
export SHELL="/usr/local/bin/bash"

export GOVERSION="1.13"
export PATH="$PATH:$HOME/code/goroots/go$GOVERSION/bin:$HOME/code/go/bin"
export GOROOT_BOOTSTRAP=$(go env GOROOT)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin:$HOME/.android/tools:$HOME/Library/Android/sdk/platform-tools:$HOME/code/tf

export CLOUDSDK_PYTHON=/usr/bin/python2.7
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kark/code/google-cloud-sdk/path.bash.inc' ]; then . '/Users/kark/code/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kark/code/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/kark/code/google-cloud-sdk/completion.bash.inc'; fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(pyenv init -)"
