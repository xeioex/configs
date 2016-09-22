set history filename ~/.gdb_history
set history save

set logging file ~/.gdb/log.log
set logging on

handle SIGPIPE nostop noprint pass
