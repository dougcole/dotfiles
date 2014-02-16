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
alias cap_diff='bundle exec cap production deploy:pending:diff | view -'
alias ss='bundle exec rails s'
alias be='bundle exec'
alias cde='cd ~/workspace/estately'
alias cdm='cd ~/workspace/mlses'

export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

export EDITOR='vim'
export NODE_PATH=/usr/local/lib/node_modules

proj() { cd $(find ~/workspace -type d -maxdepth 1 | selecta) }
branches() { git for-each-ref --sort=-committerdate --format='%(committerdate) - %(committername) %(refname)' refs/heads/ }
remote_branches() { git for-each-ref --sort=-committerdate --format='%(committerdate) - %(committername) %(refname)' refs/remotes/origin/ }

source ~/.hub_open.sh
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.1.0
