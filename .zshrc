export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

setopt interactivecomments

plugins=(
  # git
  # github # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/github
  zsh-better-npm-completion
  zsh-completions
  # aws
  # docker
  # pyenv
)
autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:$PATH"
export PATH=~/Library/Python/3.7/bin:$PATH

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
alias tf=terraform

alias o=open
alias e="open -e"
alias b=brew


bindkey "^U" backward-kill-line
bindkey "^X^_" redo
bindkey "^Q" push-input  # ctrl-q to push input to history







          # ----  END basic config  ---- #
          # ---- START user scripts ---- #







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


function url { documentation="
Create url file
$ url <url> <title?>
The file name will be <title> if supplied,
otherwise it downloads the page and gets the title
"
  case $# in
    0) echo $documentation ;;
    1) title=$(wget -qO- $1 | \
         perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si') ;;
    2) title=$2
  esac
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

alias ya="yarn add"
alias yga="yarn global add"


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
alias month="cd ~/Documents/21.07"

# pnpm
export PNPM_HOME="/Users/james/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export PATH="/usr/local/opt/postgresql@15/bin:$PATH"

alias kb="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/KB/"
