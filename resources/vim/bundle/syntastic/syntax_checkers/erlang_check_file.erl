#!/usr/bin/env escript
-export([main/1]).

main([FileName]) ->
    compile:file(FileName, [warn_obsolete_guard,
                            warn_unused_import,
                            warn_shadow_vars,
                            warn_export_vars,
                            strong_validation,
                            report,
                            {i, filename:dirname(FileName) ++ "/../include"}
                        ]).
