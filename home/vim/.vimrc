let s:config_home = empty($XDG_CONFIG_HOME) ? $HOME . '/.config' : $XDG_CONFIG_HOME

execute 'set runtimepath^=' . s:config_home . '/nvim'
execute 'set runtimepath+=' . s:config_home . '/nvim/after'

execute 'source' expand(s:config_home . '/nvim/init.vim')
