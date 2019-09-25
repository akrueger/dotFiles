### User configuration sourced by interactive shells

### Editors
export EDITOR='code'
export VISUAL='code'

### z
. ~/z.sh

### Path
# Homebrew
export PATH="/usr/local/bin:$PATH"

# MariaDB
export PATH="/usr/local/opt/mariadb@10.0/bin:$PATH"

# Visual Studio Code
export PATH="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin:$PATH"

# Posgres
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# EdgeDB
export PATH="/Library/Frameworks/EdgeDB.framework/bin:$PATH"

# Jenv
export PATH="$HOME/.jenv/bin:$PATH"

# Ant
export PATH="/usr/local/opt/ant@1.9/bin:$PATH"

# gpg-agent
# export GPG_TTY=$(tty)
# [ -f ~/.gnupg/.gpg-agent-info ] && source ~/.gnupg/.gpg-agent-info
# if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
#     export GPG_AGENT_INFO
# else
#     eval $( gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf )
# fi

### Jenv
eval "$(jenv init -)"

### Nodenv
eval "$(nodenv init -)"

### Rbenv
eval "$(rbenv init -)"

### Powerline
#POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_INSTALLATION_PATH=~/.zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(node_version custom_java ssh public_ip)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=$'\u250C'
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=$'\u2514''\u25AA'
DEFAULT_USER=$USER
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_NETWORK_ICON=''
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_NODE_ICON=$'\ue718'
POWERLEVEL9K_JAVA_ICON=$'\ue738'
POWERLEVEL9K_PUBLIC_IP_TIMEOUT=60
POWERLEVEL9K_NODE_VERSION_FOREGROUND='016'
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND='001'
POWERLEVEL9K_PUBLIC_IP_BACKGROUND='006'
POWERLEVEL9K_PUBLIC_IP_FOREGROUND='016'
POWERLEVEL9K_PUBLIC_IP_ICON=$'\uf0ac'
POWERLEVEL9K_CUSTOM_JAVA='echo $(jenv version-name) $POWERLEVEL9K_JAVA_ICON'

### Source zim
# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh
