set history filename ~/.gdb_history
set history save

set logging file ~/.gdb/log.log
set logging on

handle SIGPIPE nostop noprint pass
#source /home/build/workspace/undev/voltron/dbgentry.py

# do: 
# svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python gdb_printers
# sudo mv gdb_printers /usr/local/etc
