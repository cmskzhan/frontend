#!/bin/bash
# if there are multiple FullDay running, this script can only find 1 and stop it. 
echo "Reprocess Full day!"

RUNDAY=`date +%Y%m%d`
YEAR=`date +%Y`
MM=`date +%m`
current_time=`date +%X`

MARKET=adx
FAV_PATH_PREFIX=/smarts/data/${MARKET}/track/${YEAR}/${MM}/${RUNDAY}

#chekc watchlist
if [ -e "/smarts/data/$MARKET/watchlist/${YEAR}/${MM}/${RUNDAY}_watchlist.csv" ]
then
	echo "Watchlist file found"
	elif [ -e "/smarts/data/$MARKET/watchlist/${YEAR}/${MM}/${RUNDAY}_watchlist.csv.gz" ]
		then gunzip /smarts/data/$MARKET/watchlist/${YEAR}/${MM}/${RUNDAY}_watchlist.csv.gz
else 
    echo "no watchlist file found, download from \n http://172.31.10.30:8027/file/adx/watchlist/YYYY/MM/YYYYMMDD_watchlist.csv"
fi


#mv fav to /tmp
echo "Backing up fav to tmp"
mv $FAV_PATH_PREFIX* /tmp


#chech if Fullday is still running
ps -fu sroot | grep FullDay | grep $MARKET   > /dev/null && (echo "wait till end of day at 14:30"; exit 101 ) || (echo "No FullDay found, Process to reprocess"; SmartsControl.pl --jobset adx --job ReprocessData -d $RUNDAY --start )


SmartsControl.pl --jobset adx --job ReprocessAlerts -d $RUNDAY --start
/smarts/builds/latest-alice/bin/alertserver -ABK -m adx -l 9999 -official  $RUNDAY
favop sort -m adx $RUNDAY --algorithm legacy

 
 if [ -e "/smarts/proc/flag/$RUNDAY.$MARKET.EndOfDay.flag" ]
 then
    echo "EOD flag present"
	else
	echo "check /smarts/proc/flag/$RUNDAY.$MARKET.EndOfDay.flag"
fi
	
 if [ -e "//smarts/proc/flag/$RUNDAY.$MARKET.StartOfDay.flag" ]
 then
    echo "EOD flag present"
	else
	echo  " check//smarts/proc/flag/$RUNDAY.$MARKET.StartOfDay.flag"; 
fi




