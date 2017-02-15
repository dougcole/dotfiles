# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"
plugins=(git rails cap knife)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=~/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/Applications/TextMate.app/Contents/SharedSupport/Support/bin

unsetopt correct_all

function git_delete_merged_remotes() {
  git remote prune origin
  git branch -a --merged |
  grep 'remotes/origin' |
  grep -v master |
  cut -c 18-999 | #cut out "  remotes/origin/"
  xargs git push --delete origin
}
alias ss='bundle exec rails s'
alias be='bundle exec'
alias we='cd ~/work/estately'

export EDITOR='vim'

proj() { cd $(find ~/work -type d -maxdepth 1 | selecta) }
branches() { git for-each-ref --sort=-committerdate --format='%(committerdate) - %(committername) %(refname)' refs/heads/ }
remote_branches() { git for-each-ref --sort=-committerdate --format='%(committerdate) - %(committername) %(refname)' refs/remotes/origin/ }

eval "$(/Users/dougcole/work/est/bin/est init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
