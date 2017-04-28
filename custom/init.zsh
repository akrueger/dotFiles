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

# Zim git restructure
unalias glg
unalias gls
unalias glG
unalias gfc
unalias gia
unalias gca
unalias gcf
unalias gcF
unalias gcs
unalias gbl
unalias gbc
unalias gm
unalias gma
unalias gR
unalias gRl
unalias gRa
unalias gRx
unalias gRm
unalias gRu
unalias gRp
unalias gRs
unalias gRb
unalias gr
unalias gra
unalias grc
unalias gri
unalias grs
unalias gsd
unalias gwd
unalias gwD
unalias gdi
unalias gs

alias glf='git log --topo-order --stat --pretty=format:"${_git_log_medium_format}"'
alias glg='git log --topo-order --all --graph --pretty=format:"${_git_log_fullgraph_format}" --date=relative'

alias gia='git add --all'

alias gcs='git show --word-diff'
alias gcsn='git show --name-status'
alias gcf='git log --all --grep'
alias gcfr='git log -g --grep-reflog'

alias gtl='git tag -l'
alias gta='git tag -a'
alias gtx='git tag -d'

alias gba='git checkout -b'
alias gbs='git checkout'
alias gbl='git branch -av'

alias gm='git merge --no-ff'
alias gmab='git merge --abort'

alias gRi='git rebase --interactive'
alias gRab='git rebase --abort'

alias grl='git remote --verbose'
alias gra='git remote add'
alias grx='git remote rm'
alias grp='git remote prune'

alias gwfR='git checkout --'

alias gi='git status --ignored'

alias gs='git stash save --include-untracked'
alias gss='git stash show --word-diff'

alias gd='git diff --no-ext-diff --word-diff'
alias gdt='git difftool'
alias gdtg='git difftool --gui'
alias gdp='git format-patch -1'

alias gap='git am'

alias git_repo_size='git count-objects -vH'
