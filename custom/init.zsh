#
# Custom aliases/settings
#

# any custom stuff should go here.
# ensure that 'custom' exists in the zmodules array in your .zimrc

# General
alias e=${(z)VISUAL:-${(z)EDITOR}}
alias cp="${ALIASES[cp]:-cp} -r -i"
alias mv="${ALIASES[mv]:-mv} -i"
alias y=yarn

# Toggle hidden files in Finder
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# List hidden files
alias tree='tree -a'

# Safe delete
alias rm=trash

# GNU getopt homebrew binary symlink path
alias ggetopt='/usr/local/opt/gnu-getopt/bin/getopt'

# Recent directory presence
alias dir='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

### Git ###

# Log variables
_git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
_git_log_fullgraph_format='%C(green)%h%C(reset) %<|(50,trunc)%s %C(bold blue)<%an>%C(reset) %C(yellow)(%cd)%C(reset)%C(auto)%d%C(reset)%n'

# Working tree (w)
alias gws='git status --short'
alias gwR='git reset --hard'
alias gwfR='git checkout --'

# Index (i)
alias gia='git add --all'
alias gir='git reset'
alias gix='git rm -r --cached'

# Commit (c)
alias gc='git commit --verbose'
alias gcm='git commit --message'
alias gco='git checkout'
alias gcs='git show --word-diff'
alias gcsn='git show --name-status'
alias gcf='git log --all --grep'
alias gcfr='git log -g --grep-reflog'

# Branch (b)
alias gbl='git branch -avv'
alias gbs='git checkout'
alias gba='git checkout -b'
alias gbx='git branch --delete'
alias gbX='git branch --delete --force'
alias gbrX='git push --delete'

# Remote (r)
alias grl='git remote --verbose'
alias gra='git remote add'
alias grx='git remote rm'

# Fetch (f)
alias gf='git fetch --prune'
alias gfc='git clone'
alias gfm='git pull'

# Merge (m)
alias gm='git merge'
alias gmnf='git merge --no-ff'
alias gmt='git mergetool'
alias gmab='git merge --abort'

# Push (p)
alias gp='git push'
alias gpt='git push --tags'

# Rebase (R)
alias gRi='git rebase --interactive'
alias gRab='git rebase --abort'

# Log (l)
alias gl='git log --topo-order --pretty=format:"${_git_log_medium_format}"'
alias glf='git log --topo-order --stat --pretty=format:"${_git_log_medium_format}"'
alias glfo='git log --name-status --oneline'
alias glg='git log --topo-order --all --graph --pretty=format:"${_git_log_fullgraph_format}" --date=relative'

# Stash (s)
alias gs='git stash save --include-untracked'
alias gsl='git stash list'
alias gss='git stash show --word-diff'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsx='git stash drop'

# Diff (d)
alias gd='git diff --no-ext-diff --word-diff'
alias gdt='git difftool'
alias gdtg='git difftool --gui'
alias gdf='git diff --name-status'
alias gdp='git format-patch -1'

# Tag (t)
alias gtl='git tag -l'
alias gta='git tag -a'
alias gtx='git tag -d'

# Patch
alias gap='git am'

# Ignore (ig)
alias gig='git status --ignored'

# Repo
alias git_repo_size='git count-objects -vH'
