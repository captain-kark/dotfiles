alias less='less -R'

alias ~='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cp='cp -i'
alias dc=docker-compose
alias emacs='emacs --no-splash'
function killport { kill $(lsof -i :$@ | tail -n 1 | cut -f 5 -d ' '); }
alias kub=kubectl
function kub-context { kub config get-contexts $(kub config current-context) --no-headers | awk '{printf $2; if ($5) printf ".%s",$5}'; }
function gcp-context { python -c 'from pathlib import Path as P; from configparser import ConfigParser as C; c = C(); c.read(P.home() / ".config/gcloud/configurations/config_default"); print(c.get("core", "project"))'; }
alias tf=terraform
alias ll='ls -lAh'
alias ln='ln -is'
alias ls='ls -lh'
alias mkdir='mkdir -pv'
alias mv='mv -i'
function nmb { $(npm bin)/$@; }
alias noisy='unset PS1_NO_VERBOSE'
alias quiet='export PS1_NO_VERBOSE=1'
alias sudo='sudo '

function e {
  if [ -z "$1" ]
  then
    TMP="$(mktemp /tmp/stdin-XXX)"
    cat >$TMP
    emacsclient -a emacs -n $TMP
    rm $TMP
  else
    emacsclient -a emacs -n "$@"
  fi
}

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time24h="\t"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

##
# https://stackoverflow.com/a/27452329
# set the last command's return code in the next PS1
trapDbg() {
   local c="$BASH_COMMAND"
   if [ "$c" != "pc" ]; then
     export _cmd="$c"
   fi
}
pc() {
   local r=$?
   trap "" DEBUG
   [[ -n "$_cmd" ]] && _returncode="$r " || _returncode=""
   export _returncode
   export _cmd=
   trap 'trapDbg' DEBUG
}
export PROMPT_COMMAND=pc
trap 'trapDbg' DEBUG

export PS1='$(echo "'$IBlue$Time24h$Color_Off'")$(command -v kubectl &>/dev/null; \
if [ $? -eq 0 ]; then \
  CONTEXT="$(gcp-context)"; \
  if [[ "$CONTEXT" =~ "prod" ]]; then \
     echo -n " '$IRed'$CONTEXT'$Color_Off'"; \
  else \
    echo -n " '$Cyan'$CONTEXT'$Color_Off'"; \
  fi
fi)$(command -v kubectl &>/dev/null; \
if [ $? -eq 0 ]; then \
  CONTEXT="$(kub-context)"; \
  if [[ "$CONTEXT" =~ "prod" ]]; then \
     echo -n " '$IRed#'$CONTEXT'#$Color_Off'"; \
  else \
    echo -n " '$Yellow'[$CONTEXT]'$Color_Off'"; \
  fi
fi)$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    echo "'$IGreen$(__git_ps1 " (%s) ")$BYellow$PathShort$Color_Off'"; \
    [ -z $PS1_NO_VERBOSE ] && git lg 1 --color; \
  else \
    echo "'$BIRed$(__git_ps1 " {%s} ")$BYellow$PathShort$Color_Off'"; \
    [ -z $PS1_NO_VERBOSE ] && git status -s; \
  fi)"; \
else \
  echo " '$Yellow$PathShort$Color_Off'"; \
fi)\n$(if [ -z $_returncode ]; then
  echo "'$Yellow'\$?=?'$Color_Off'"; \
elif [ $_returncode -eq 0 ]; then \
  echo "'$IGreen'\$?=0'$Color_Off'"; \
else
  echo "'$BIRed'\$?=$_returncode'$Color_Off'"; \
fi
): '