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
plugins=(git rails cap)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
if [[ -s /Users/dougcole/.rvm/scripts/rvm ]] ; then source /Users/dougcole/.rvm/scripts/rvm ; fi

alias git_delete_merged_remotes="git branch -a --merged | awk --field-separator=/ '/remotes\/origin/ && !/\/master$/ { print $3 }' | xargs git push --delete origin"
alias cap_diff='bundle exec cap production deploy:pending:diff | gview -'
alias ss='bundle exec unicorn_rails -p 3000'
alias cde='cd ~/workspace/estately'

export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=500000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

