# Set ZSH and theme
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git fzf autojump)
source $ZSH/oh-my-zsh.sh

# ssh
export GPG_TTY=$(tty)
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Plugins

# Editor settings
export EDITOR='nvim'

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias vim="nvim"
alias k="kubectl"
alias kns="kubens"
alias kctx="kubectx"
alias python=python3

# Go setup
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/go/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# GPG setup
export GPG_TTY=$(tty)

# Autojump setup
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Kubectl completion
source <(kubectl completion zsh)

# FZF setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude vendor'
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# Set locales
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8



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
