set history filename ~/.gdb_history
set history save

set logging file ~/.gdb/log.log
set logging on

handle SIGPIPE nostop noprint pass
add-auto-load-safe-path /opt/gcc/gcc-4.7.3/libstdc++.so.6.0.17-gdb.py
#source /home/build/workspace/undev/voltron/dbgentry.py

# do: 
# svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python gdb_printers
# sudo mv gdb_printers /usr/local/etc

python
import sys
sys.path.insert(0, '/usr/local/etc/gdb_printers')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
