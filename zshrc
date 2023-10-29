# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"


ZSH_DISABLE_COMPFIX=true 

ZSH_THEME="robbyrussell"

ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent fzf)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

 
 # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

alias vim="nvim"
#k8s alias
alias k="kubectl"
alias kns="kubens"
alias kctx="kubectx"

bindkey

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/sbin:$PATH:/usr/local/go/bin"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

export GPG_TTY=$(tty)

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude vendor'

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

function git_filtered_branches_last_week() {
  # Table 1: Date and Branch Name
  echo "Table 1: Date and Branch Name"
  git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:relative)|%(refname:short)' | \
  awk -F'|' 'BEGIN {print "Date|Branch Name"} $2 != "main" && $2 ~ /^naveen/ && $1 !~ /(weeks|months|years) ago/ {print $1 "|" $2}' | \
  column -t -s '|'
  
  # Table 2: Just Branch Names
  echo "Table 2: Just Branch Names"
  git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:relative)|%(refname:short)' | \
  awk -F'|' 'BEGIN {print "Branch Name"} $2 != "main" && $2 ~ /^naveen/ && $1 !~ /(weeks|months|years) ago/ {print $2}' | \
  column -t
}
function process_go_files() {
    # Change to the current directory (where the function is called from)
    cd "$(dirname "$0")"

    # Get the list of all changed files (including staged, unstaged, and untracked files)
    # The output will include the relative path to the files
    local changed_files=$(git status --porcelain | awk '{print $2}')

    # Filter the list to include only .go files
    local go_files=$(echo "$changed_files" | grep '\.go$')

    # Loop through each .go file
    for file in ${(f)go_files}; do
        # Convert the relative path to a full path
        local full_path=$(realpath "$file")

        # Run the gci command with specified options
        gci write -s "standard,default" "$full_path"

        # Run the gofmt command to format the Go file
        gofmt -w "$full_path"

        gofumpt -w "$full_path"

        # Run the goimports command to update imports in the Go file
        goimports -w "$full_path"

        git add "$full_path"

        # Print the processed file's full path
        echo "Processed: $full_path"
    done
    make lint
    make fmt
}
function update_last_commit() {
  # Set the new commit date to today's date
  export GIT_COMMITTER_DATE="$(date)"
  
  # Amend the last commit and include the sign-off
  git commit --amend --no-edit --date "$GIT_COMMITTER_DATE" -s
  
  # Unset the GIT_COMMITTER_DATE variable
  unset GIT_COMMITTER_DATE
}
function auto_review_dependencies_prs() {
  # Approve all PRs with the "dependencies" label that have no review
  gh pr list -S "is:pr is:open review:none label:dependencies sort:updated-desc" --json number | \
  jq '.[].number' | \
  xargs -L 1 gh pr review --approve

  # Comment "@dependabot rebase" on all PRs with the "dependencies" label that have been approved
  gh pr list -S "is:pr is:open review:approved label:dependencies" --json number | \
  jq '.[].number' | \
  xargs -L 1 gh pr comment -b "@dependabot rebase"

  # Comment "@dependabot merge" on all PRs with the "dependencies" label that have been approved
  gh pr list -S "is:pr is:open review:approved label:dependencies" --json number | \
  jq '.[].number' | \
  xargs -L 1 gh pr comment -b "@dependabot merge"
}


function auto_merge_prs() {
  # Update the local main branch
  git checkout main &&
  git pull &&
  
  # List the first pending pull request
  pr_number=$(gh pr list -S "is:pr is:open review:approved label:dependencies" --json number | \
              jq '.[].number' | head -n 1)
  
  # Check if there is a pending pull request
  if [ -n "$pr_number" ]; then
    # Rebase and enable auto-merge for the first pull request
    gh pr checkout "$pr_number" &&
    git rebase main &&
    git push --force-with-lease origin HEAD &&
    gh pr merge "$pr_number" --squash --auto
  else
    echo "No pending pull requests found."
  fi
  
  # Optionally, switch back to the main branch
  git checkout main
}

function getupstream(){
  git checkout main
  git pull --rebase upstream main
  git push origin main
}


export GPG_TTY=$(tty)
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export GOBIN=$GOPATH/bin
export KO_DOCKER_REPO=gcr.io/openssf
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1
eval $(/opt/homebrew/bin/brew shellenv)
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
eval "$(direnv hook zsh)"
source <(kubectl completion zsh)
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/node@16/bin:$PATH:/usr/local/go/bin"
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug 'wfxr/forgit'
ulimit -n 12288
#alias go="/Users/naveen/go/go1.18.4/bin/go"
export GOWORK=off
 [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
alias python=python3
