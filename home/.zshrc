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
plugins=(git rails cap knife bundler)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/Applications/TextMate.app/Contents/SharedSupport/Support/bin

unsetopt correct_all

function git_delete_merged_remotes() {
  git remote prune origin
  git branch -a --merged |
  awk -F '/' '/remotes\/origin/ && !/\/master$/ { print $3 }' |
  xargs git push --delete origin
}
alias cap_diff='bundle exec cap production deploy:pending:diff | view -'
alias ss='bundle exec unicorn_rails'
alias cde='cd ~/workspace/estately'
alias cdm='cd ~/workspace/mlses'

export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

export EDITOR='vim'
export NODE_PATH=/usr/local/lib/node_modules

source ~/.hub_open.sh
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
