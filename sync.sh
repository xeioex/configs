#! /bin/bash

SKIPLIST=( '.gitconfigprivate' '.bash_history' '.viminfo' '..' '.' )

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

function __contains ()
{
        param=$1;
        #echo "compare $1"
        shift;
        declare -a arr=("${!1}")
        for elem in "${arr[@]}";
        do
                [[ "$param" == "$elem" ]] && return 1;
        done;
        #echo 'do not contain'
        return 0
}

if [ "$1" = "install" ]; then
        DEST_DIR="$HOME/"
        SRC_DIR="./"
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
        d=$(basename "$d")

        __contains $d SKIPLIST[@];
        if [[ $?  -gt 0  || -z $(echo $d|egrep -v '*~') ]]; then
                continue
        fi

        diff "$SRC_DIR$d" "$DEST_DIR$d" 2>/dev/null >/dev/null
        RES=$?

        if [[ $RES -eq 0 || $RES -eq 2 ]]; then
                continue
        fi
        echo ""
        echo "installing $d:"
        echo "===== diff start ====="
        colordiff "$DEST_DIR$d" "$SRC_DIR$d" 2>/dev/null
        echo "===== diff stop ====="

        echo "Do you want to install $d?"

        select yn in "y" "n" "q"; do
                case "$REPLY" in
                            "y" ) echo "copy $SRC_DIR$d to $DEST_DIR"; cp -r $SRC_DIR$d $DEST_DIR; break;;
                            "n" ) break;;
                            "q" ) exit 0;;
                            * ) echo "print y, n or q";;
                        esac
                done
        done
exit 0
