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
    echo  -e "no watchlist file found, download from \n http://172.31.10.30:8027/file/adx/watchlist/YYYY/MM/YYYYMMDD_watchlist.csv"; exit 101
fi