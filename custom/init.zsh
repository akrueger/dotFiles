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
unalias gia
unalias gca
unalias gbl
unalias gbc
unalias gm
unalias gRa
unalias gra
unalias gri
unalias gdi


alias glg='git log --topo-order --all --graph --pretty=format:"${_git_log_fullgraph_format}" --date=relative'

alias gia='git add --all'

alias gca='git commit --verbose --amend'

alias gt='git tag -a'

alias gba='git checkout -b'
alias gbl='git branch -av'

alias gm='git merge --no-ff'
alias gmc='git merge --continue'

alias gRi='git rebase --interactive'
alias gRa='git rebase --abort'

alias grl='git remote --verbose'
alias gra='git remote add'
alias grx='git remote rm'
alias grp='git remote prune'

alias gwfR='git checkout --'

alias gdi='git status --ignored'
