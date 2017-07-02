# Path to your oh-my-zsh installation.
export ZSH=/Users/naveen/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

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
plugins=(git osx docker kubectl ssh-agent)


# User configuration

export GOPATH=$HOME/Go
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

#go path
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin



# export MANPATH="/usr/local/man:$MANPATH"

source /Users/naveen.srinivasan/.oh-my-zsh/oh-my-zsh.sh
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

#Port forward to linkerd
l5admin(){ kportforward l5d admin app=l5d 9000}

#clean up l5d admin port forwarding
l5clean(){lsof -t -i tcp:9000 | xargs kill}

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
alias python='python3'
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
