if [ "$1" = "skipcheck" ]
then
        cp -r ./* ~/
        exit 0
fi


for d in ./.*
do
        if [ -d $d ] 
        then
                continue
        fi
        echo "installing $d:"
        echo "===== diff start ====="
        colordiff ~/$d $d
        echo "===== diff stop ====="

        echo "Do you wish to install $d?"  

        select yn in "y" "n" "q";
        do  
                case "$REPLY" in
                            "y" ) echo "copy $d to ~/$d"; cp $d ~/$d; break;;
                            "n" ) break;;
                            "q" ) exit 0;;
                            * ) echo "print y, n or q";;
                        esac
                done
        done
exit 0
