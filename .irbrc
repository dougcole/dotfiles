require 'irb/ext/save-history'

# Adds readline functionality
IRB.conf[:USE_READLINE] = true
# Auto indents suites
IRB.conf[:AUTO_INDENT] = true
# Where history is saved
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
# How many lines to save
IRB.conf[:SAVE_HISTORY] = 1000
#no output
#IRB.conf[:PROMPT][ IRB.conf[:PROMPT_MODE] ][:RETURN]=''
