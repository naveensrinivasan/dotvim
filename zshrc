# Path to your oh-my-zsh installation.
export ZSH=/Users/naveen/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=13
 export HISTCONTROL=ignoreboth:erasedups

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
 DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx docker kubectl ssh-agent tmux tmuxinator zsh-autosuggestions)


# User configuration
export GOPATH=$HOME/Go
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export GOBIN=$GOPATH/bin

#go path
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin



# export MANPATH="/usr/local/man:$MANPATH"

source /Users/naveen.srinivasan/.oh-my-zsh/oh-my-zsh.sh
#
POWERLEVEL9K_MODE='awesome-patched'

# Disable dir/git icons
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

DISABLE_AUTO_TITLE="true"

POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(kubecontext os_icon context dir vcs)
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \uE868  %d.%m.%y}"

POWERLEVEL9K_STATUS_VERBOSE=true
export DEFAULT_USER="$USER"
# aws 

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="${EDITOR} ~/.zshrc"
alias ohmyzsh="${EDITOR} ~/.oh-my-zsh"

#tmux alias
#tl: list sessions
alias tl='tmux ls'
#tn <name>: create a session named <name>
alias tn='tmux -CC -2 new -s'
#ta <name>: attach to a session named <name>
alias ta='tmux -CC -2 attach -t'

#alias hub 
alias git=hub


# Kubernetes
alias k='kubectl'
alias kap='kubectl get po --all-namespaces'
alias kp='kubectl get po'
alias ksc='kubectl get secrets'
alias ks='kubectl get services'
alias h='helm'

#Port forward to linkerd
prom(){ 
  promclean
  export POD_NAME=$(kubectl get pods --namespace katana -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace katana port-forward $POD_NAME 9090 
  }

#clean up l5d admin port forwarding
promclean(){lsof -t -i tcp:9090 | xargs kill}

getlabel (){
kubectl get deployment $1  -o json |  jq --raw-output '.metadata.labels'
}
b64cp(){
  echo $1 | base64 
  echo $1 | base64 | pbcopy
}


rn(){
  echo -n  $1 |base64 -D | tr -d '\n' | base64 | pbcopy
  echo -n  $1 |base64 -D | tr -d '\n' | base64 
}


#Port forward k8s
# $1 servicename
# $2 portname
# $3 pod selector
# $4 local port
kportforward() {
ADMINPORT=$(kubectl get svc $1  -o json |jq '.spec.ports[]| select(.name=="'$2'").port')
POD=$(kubectl get pods  --selector $3 \
  -o template --template '{{range .items}}{{.metadata.name}} {{.status.phase}}{{"\n"}}{{end}}' \
  | grep Running | head -1 | cut -f1 -d' ')
echo $POD
echo $4
echo $ADMINPORT
kubectl port-forward  $POD $4:$ADMINPORT &
sleep 2
open http://localhost:$4
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# ------------------------------------
# Docker alias and function
# ------------------------------------

#rm removes all docker images
alias drm='docker rm $(docker ps -a -q)'
#dps
alias dps='docker ps'
# Get latest container ID
alias dl="docker ps -l -q"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Docker tag
alias dtag="docker tag"

#grep alias 
alias ga="alias | grep"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }
# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi --force $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

newgoprj() {mkdir -p $GOPATH/src/github.com/naveensrinivasan/$1}
goprj() {cd $GOPATH/src/github.com/naveensrinivasan/$1}
# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# show all alias realted kubectl
kalias() { alias | grep 'kubectl' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# show all alias realted kubectl
galias() { alias | grep 'git' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

fdelete() { find . -name $1 -print0 | xargs -0 rm}

# Get docker machine ip
docker-ip() {
  docker-machine ip 2> /dev/null
}

#doker linter
#https://github.com/lukasmartinelli/hadolint
alias dlint="docker run --rm -i  lukasmartinelli/hadolint <"
alias lockscreen='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'


function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
bindkey '^s' pet-select

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# Vi style:
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
#!/bin/bash
alias util='kubectl get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''

# Get CPU request total (we x20 because because each m3.large has 2 vcpus (2000m) )
alias cpualloc='util | grep % | awk '\''{print $1}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { print sum/(NR*20), "%\n" } }'\'''

# Get mem request total (we x75 because because each m3.large has 7.5G ram )
alias memalloc='util | grep % | awk '\''{print $5}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { print sum/(NR*75), "%\n" } }'\'''

_apex()  {
  COMPREPLY=()
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local opts="$(apex autocomplete -- ${COMP_WORDS[@]:1})"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _apex apex

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/naveen.srinivasan/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/naveen.srinivasan/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/naveen.srinivasan/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/naveen.srinivasan/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
source <(kops completion zsh)
source <(helm completion zsh)

removecontainers() {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
}

armaggedon() {
    removecontainers
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}

# added by travis gem
[ -f /Users/naveen.srinivasan/.travis/travis.sh ] && source /Users/naveen.srinivasan/.travis/travis.sh

function forwardAuth {
        lsof -t -i tcp:10103 | xargs kill
        local auth=$(kp --all-namespaces | grep "auth3-bulwark" | awk '{print $2}' | sed -n 1p)
        kubectl -n katana port-forward $auth 10103:10103
}
alias mongo-start='docker run -itd -p 127.0.0.1:27017:27017 -d mongo:3.4.6'
alias tar='gtar'
### Wrapper for env
export WORKON_HOME=$HOME/.virtualenv
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
source /usr/local/bin/virtualenvwrapper.sh
export GOROOT=/usr/local/opt/go/libexec
