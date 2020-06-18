# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
   autoload -Uz compinit
  compinit
fi


eval "$(pyenv init -)"

export PATH="/usr/local/sbin:$PATH"
export PATH=~/Library/Python/3.7/bin:$PATH

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
alias tf=terraform
complete -C /usr/local/bin/aws_completer aws






          # ----  END basic config  ---- #
          # ---- START user scripts ---- #







alias o=open
alias e="open -e"

function gc {
  local msg
  msg=$*

  git add .
  git commit -m "$msg"
}

alias yt='youtube-dl --extract-audio --audio-format mp3 --output "%(title)s.%(enc)s"'

function ffdone {
	ts osascript -e 'display notification "That shit is done bro" with title "FFMPEG" sound name "Submarine"' -e 'say "That shit is done bra" using "Alex" speaking rate 100 pitch 50 modulation 100'
}

# Extract the same frame from 2 videos
# $1: frame	$2: video 1	$3: video 2
function fex {
  ffmpeg -ss "$1" -i "$2" -vframes 1 -q:v 2 "${2%}.jpg";
  ffmpeg -ss "$1" -i "$3" -vframes 1 -q:v 2 "${3%}.jpg"
}

# Create url file
# $ url <url> <title?>
# The file name will be <title> if supplied, 
# otherwise it downloads the page and gets the title
function url {
  if [[ $2 ]]; then
    title=$2
  else
    title=$(wget -qO- $1 | \
    perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si')
  fi
  echo "[InternetShortcut]\nURL=$1" > $title.url
}


alias alice="sms alice"
alias cat=bat
alias gcc=gcc-9
export dotfiles=~/.config/dotfiles
export zrc=$dotfiles/.zshrc
alias ez="o $zrc"
az() { echo "$@" >> $zrc }
alias sz="source $zrc"

export PATH=$dotfiles/bin:$PATH

alias dotfiles-cd="cd $dotfiles"
alias dotfiles-status="git -C $dotfiles status"
alias dotfiles-pull="git -C $dotfiles pull"
dotfiles-push() {
  if [ $# -eq 0 ]
  then
    echo "You must provide a commit message"
  else
    git -C $dotfiles add .
    git -C $dotfiles commit -m "$1"
    git -C $dotfiles push
  fi
}

# get combined duration of all media passed
duration() {
  local sum=0
  local counter=0
  tput sc
  for i in $@; do
    tput el1
    tput rc
    if (( counter >= 40 )); then counter=1 fi
    printf %${counter}s |tr " " "."

    current=$(\
      ffprobe -v error -show_entries format=duration \
        -of default=noprint_wrappers=1:nokey=1 -i "$i" \
    )

    ((sum+=current))
    ((counter++))
  ; done
  tput el1
  tput rc
  printf '%dh:%dm:%ds\n' $(($sum/3600)) $(($sum%3600/60)) $(($sum%60))
}

#-#-#-#-#  ::  ⌁ BLUETOOTH ⌁  ::  #-#-#-#-#
#    connect my headphones
alias cmh="blueutil    --connect 00-86-10-11-01-b2"
# disconnect my headphones
alias dmh="blueutil --disconnect 00-86-10-11-01-b2"
#    connect Alice's headphones
alias cah="blueutil    --connect 38-18-4c-4b-40-bc"
# disconnect Alice's headphones
alias dah="blueutil --disconnect 38-18-4c-4b-40-bc"
#-#-#-#-#  :: :: :: ::: :: :: ::  #-#-#-#-#

alias movies='e ~/"Library/Mobile Documents/com~apple~TextEdit/Documents/Movies to Watch.rtf"'
