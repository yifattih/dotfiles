#!/bin/bash

# Temporary
alias tasks="nvim ${HOME}/Documents/tasks.md"

alias cls='clear'

alias -- -='cd -'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias _='sudo'

alias reown='sudo chown -R $(id -n -u):$(id -n -u)'

alias md='mkdir -p'

alias rf='rm'
alias rd='rm -r'

alias cdir='cp -r'

alias l='eza'
alias la='eza -a'
alias ll='eza -lah'
alias ls='eza --color=auto'

alias chrome='google-chrome > /dev/null 2>&1 &'
alias passman='1password > /dev/null 2>&1 &'

alias bat='batcat'

alias ghl='gh auth login -p ssh -h github.com'

alias v='nvim'
##############################################################################
##############################################################################
##############################################################################
################################### tmux
if [ -n "$TMUX" ]; then
  # sessions
  alias txn='tmux new-session -A -s dev'  # Start or attach to 'dev' session
  alias txns='tmux list-sessions'         # List sessions
  alias txkill='tmux kill-session -t dev' # Kill 'dev' session

  # windows
  alias txnw='tmux new-window'       # New window
  alias txw='tmux list-windows'      # List windows
  alias txrn='tmux rename-window'    # Rename current window
  alias txsw='tmux select-window -t' # Select window (requires arg)
  alias txmw='tmux move-window -t'   # Move window (requires arg)
  alias txkw='tmux kill-window'      # Kill current window

  # panes
  alias txh='tmux split-window -h'  # Horizontal split
  alias txv='tmux split-window -v'  # Vertical split
  alias txr='tmux select-pane -R'   # Move to right pane
  alias txl='tmux select-pane -L'   # Move to left pane
  alias txbot='tmux select-pane -D' # Move to bottom pane
  alias txtop='tmux select-pane -U' # Move to top pane
  alias txsp='tmux swap-pane -D'    # Swap pane down
  alias txmp='tmux move-pane -t'    # Move pane (requires arg)
  alias txkp='tmux kill-pane'       # Kill current pane

  # layouts
  alias txlay='tmux list-windows \; list-panes'   # Overview layout
  alias txeq='tmux select-layout even-horizontal' # Equal horizontal
  alias txev='tmux select-layout even-vertical'   # Equal vertical
  alias txtiled='tmux select-layout tiled'        # Tiled layout
  alias txzoom='tmux resize-pane -Z'              # Toggle zoom

  # utilities
  alias txc='tmux clear-history'              # Clear scrollback
  alias txtime='tmux display-message "%T"'    # Show current time
  alias txmsg='tmux display-message'          # Print message
  alias txcfg='tmux source-file ~/.tmux.conf' # Reload config

  # exit helpers
  alias txe='exit'             # Exit shell
  alias txx='tmux kill-server' # Kill all tmux
fi

##############################################################################
##############################################################################
##############################################################################
################################### git

# Functions added from git.zsh
# (https://github.com/ohmyzsh/ohmyzsh/blob/8cbe98469d9862d37d43ca4229dc8e915ec377a9/lib/git.zsh)
# The git prompt's git commands are read-only and should not interfere with
# other processes. This environment variable is equivalent to running with `git
# --no-optional-locks`, but falls back gracefully for older versions of git.
# See git(1) for and git-status(1) for a description of that flag.
#
# We wrap in a local function instead of exporting the variable directly in
# order to avoid interfering with manually-run git commands by the user.
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2>/dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2>/dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# From  official oh-my-zsh repository: https://github.com/ohmyzsh
# File URL: https://github.com/ohmyzsh/ohmyzsh/blob/8cbe98469d9862d37d43ca4229dc8e915ec377a9/plugins/git/git.plugin.zsh
# Modified by: @yifattih
#
# Functions

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
  git_current_branch
}

# Pretty log messages
# function _git_log_prettily(){
#   if ! [ -z $1 ]; then
#     git log --pretty=$1
#   fi
# }
# compdef _git _git_log_prettily=git-log

# Warn if the current branch is a WIP
function work_in_progress() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

# Similar to `gunwip` but recursive "Unwips" all recent `--wip--` commits not just the last one
function gunwipall() {
  local _commit=$(git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H)

  # Check if a commit without "--wip--" was found and it's not the same as HEAD
  if [[ "$_commit" != "$(git rev-parse HEAD)" ]]; then
    git reset $_commit || return 1
  fi
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo develop
}

#
# Aliases
# (sorted alphabetically)
#

alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gapt='git apply --3way'

alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch --delete 2>/dev/null'
alias gbD='git branch --delete --force'
alias gbg='git branch -vv | grep ": gone\]"'
alias gbgd='git branch --no-color -vv | grep ": gone\]" | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbgD='git branch --no-color -vv | grep ": gone\]" | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gcn!='git commit --verbose --no-edit --amend'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcans!='git commit --verbose --all --signoff --no-edit --amend'
alias gcam='git commit --all --message'
alias gcsm='git commit --signoff --message'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcb='git checkout -b'
alias gcf='git config --list'

# function gccd() {
#   command git clone --recurse-submodules "$@"
#   [[ -d "$_" ]] && cd "$_" || cd "${${_:t}%.git}"
# }
# compdef _git gccd=git-clone

alias gcl='git clone --recurse-submodules'
alias gclean='git clean --interactive -d'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_develop_branch)'
alias gcmsg='git commit --message'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcount='git shortlog --summary --numbered'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit --gpg-sign'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'

alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'

# function gdnolock() {
#   git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
# }
# compdef _git gdnolock=git-diff

# function gdv() { git diff -w "$@" | view - }
# compdef _git gdv=git-diff

alias gf='git fetch'
# --jobs=<n> was added in git 2.8
# is-at-least 2.8 "$git_version" \
#   && alias gfa='git fetch --all --prune --jobs=10' \
#   || alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

alias gfg='git ls-files | grep'

alias gg='git gui citool'
alias gga='git gui citool --amend'

# function ggf() {
#   [[ "$#" != 1 ]] && local b="$(git_current_branch)"
#   git push --force origin "${b:=$1}"
# }
# compdef _git ggf=git-checkout
# function ggfl() {
#   [[ "$#" != 1 ]] && local b="$(git_current_branch)"
#   git push --force-with-lease origin "${b:=$1}"
# }
# compdef _git ggfl=git-checkout

# function ggl() {
#   if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
#     git pull origin "${*}"
#   else
#     [[ "$#" == 0 ]] && local b="$(git_current_branch)"
#     git pull origin "${b:=$1}"
#   fi
# }
# compdef _git ggl=git-checkout

# function ggp() {
#   if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
#     git push origin "${*}"
#   else
#     [[ "$#" == 0 ]] && local b="$(git_current_branch)"
#     git push origin "${b:=$1}"
#   fi
# }
# compdef _git ggp=git-checkout

# function ggpnp() {
#   if [[ "$#" == 0 ]]; then
#     ggl && ggp
#   else
#     ggl "${*}" && ggp "${*}"
#   fi
# }
# compdef _git ggpnp=git-checkout

# function ggu() {
#   [[ "$#" != 1 ]] && local b="$(git_current_branch)"
#   git pull --rebase origin "${b:=$1}"
# }
# compdef _git ggu=git-checkout

alias ggpur='ggu'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'

alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
# is-at-least 2.30 "$git_version" \
#   && alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes' \
#   || alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease'

alias ghh='git help'

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'

alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'

alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"

alias gm='git merge'
alias gmom='git merge origin/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gma='git merge --abort'
alias gms="git merge --squash"

alias gp='git push'
alias gpd='git push --dry-run'
# is-at-least 2.30 "$git_version" \
#   && alias gpf='git push --force-with-lease --force-if-includes' \
#   || alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpr='git pull --rebase'
alias gpu='git push upstream'
alias gpv='git push --verbose'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote --verbose'

alias gsb='git status --short --branch'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status --short'
alias gst='git status'

# use the default stash push on git 2.13 and newer
# is-at-least 2.13 "$git_version" \
#   && alias gsta='git stash push' \
#   || alias gsta='git stash save'

alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='gsta --include-untracked'
alias gstall='git stash --all'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch $(git_main_branch)'
alias gswd='git switch $(git_develop_branch)'

alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'

alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase --verbose'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash --verbose'
alias gupom='git pull --rebase origin $(git_main_branch)'
alias gupomi='git pull --rebase=interactive origin $(git_main_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gluc='git pull upstream $(git_current_branch)'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'

alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'

alias gam='git am'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gama='git am --abort'
alias gamscp='git am --show-current-patch'

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}
##############################################################################
##############################################################################
##############################################################################
