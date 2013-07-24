if [ "$2" = "skipcheck" ]; then
        if [ "$1" = "install" ]; then
                echo "installing: cp -r ./* ~/"
                cp -r ./* ~/
        elif [ "$1" = "upload" ]; then
                echo "uploading: cp -r ~/\.* ./"
                cp -r ~/\.* ./
        else
                echo "specify: install or upload"
                exit 1
        fi
                exit 0
fi


# TODO
# default SKIPLIST (.gitconfigprivate, .bash_history)
#default COPYLIST (.vim)

if [ "$1" = "install" ]; then
        DEST_DIR="$HOME/"
        SRC_DIR="./"
        SKIPLIST=
elif [ "$1" = "upload" ]; then
        DEST_DIR="./"
        SRC_DIR="$HOME/"
else
        echo "specify: install or upload"
        exit 1
fi

echo "DEST DIR: $DEST_DIR"
echo "SRC DIR: $SRC_DIR"

for d in $SRC_DIR.*
do
        if [ -d $d ]; then
                continue
        fi

        d=$(basename "$d")

        echo ""
        echo "installing $d:"
        echo "===== diff start ====="
        colordiff "$SRC_DIR$d" "$DEST_DIR$d" 2>/dev/null
        RES=$?
        echo "===== diff stop ====="

        if [[ "$RES" -eq "0" || "$RES" -eq "2" ]]; then
                continue
        fi

        echo "Do you want to install $d?"

        select yn in "y" "n" "q"; do
                case "$REPLY" in
                            "y" ) echo "copy $SRC_DIR$d to $DEST_DIR$d"; cp $SRC_DIR$d $DEST_DIR$d; break;;
                            "n" ) break;;
                            "q" ) exit 0;;
                            * ) echo "print y, n or q";;
                        esac
                done
        done
exit 0
