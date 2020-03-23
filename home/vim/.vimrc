set runtimepath^=$XDG_CONFIG_HOME/nvim
set runtimepath+=$XDG_CONFIG_HOME/nvim/after

execute 'source' expand("$XDG_CONFIG_HOME/nvim/init.vim")
