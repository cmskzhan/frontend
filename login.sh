#!/bin/bash
#auto login draft version #1 by Kai Zhang

options=("adx" "dfm" "sca" "nsx" "nzx" "pds" "pse" "Internals" "Quit");



function mainmenu {
PS3='client short code: '

select opt in "${options[@]}"
do
    case $opt in
        "adx")
            echo  -e  "\t Abu Dhabi Securities Exchange"
			ip3front="10.30.100"
            submenu $ip3front;
            ;;
        "dfm")
            echo -e "\t Dubai Financial MArket"
			ip3front="10.30.102"
            submenu $ip3front;
            ;;
          "sca")
		    echo -e "\t Security and Commodities Authority"
			ip3front="10.30.104"
            submenu $ip3front;
            ;;
          "nsx")
		    echo -e "\t National Stock Exchange of Australia"
			ip3front="10.30.116"
            submenu $ip3front;
            ;;
          "nzx")
		    echo -e "\t New Zealand Exchange"
			ip3front="10.30.114"
            submenu $ip3front;
            ;;
          "pds")
		    echo -e "\t Philippine Dealing & Exchange Corp (PDEx)"
			ip3front="10.30.112"
            submenu $ip3front;
            ;;
          "pse")
		    echo -e "\t Palestine Exchange (PEX)"
			ip3front="10.30.106"
            submenu $ip3front;
            ;;
		  "Internals")
		    echo -e "\t 1. nemesis1.smarts-systems.com \n \t 2. TRUEEX jumpbox \n \t 3. PDS testbed "
			subInternalMenu;
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
}

function submenu {
echo -e "1. Production \t 2. Replica \t 3. Staging" 
read p;
if [ $p -eq 1 ] ; then
   ip4back="3"
   elif [ $p -eq 2 ]; then 
     ip4back="33"
	 elif [ $p -eq 3 ]; then
	   ip4back="13"
	   else 
	     echo "invalid input";break;
fi
  
hostip=$1.$ip4back
./kaitest.sh $hostip	
}

function subInternalMenu {
read p;
if [ $p -eq 1 ] ; then	
   expect -c "
   spawn ssh sroot@10.116.176.10
   expect sroot { send sroot\n  } 
   interact 
   "
   elif [ $p -eq 2 ]; then 
   expect -c "
   spawn ssh kzh@10.116.200.14
   expect password { send Maya4pro++\n } 
   expect $ { send ssh sroot@104.153.168.244 \n }
   interact 
   "
	 elif [ $p -eq 3 ]; then
	   ip4back="13"
	   else 
	     echo "invalid input";break;
fi

}


mainmenu

