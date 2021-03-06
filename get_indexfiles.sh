#!/bin/bash
# Params:
# $1 Query string e.g. '*.hu'
# $2 Output dir e.g. cc_index
# $3 Logfile name e.g. get_index.log which will be get_index.log.1, get_index.log.2 etc.
# $4 Max retry on full redownload of specific pages

# https://stackoverflow.com/a/4774063
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

download_index () {
${SCRIPTPATH}/cdx-index-client.py --fl url,filename,offset,length,status,mime -z $1 -d $2 $4 2>&1 | tee $3
}

i=0
download_index $1 $2 "$3.$i" '-c all'
while [ ${i} -le $4 ] && grep "Max retries" -q "$3.$i"; do
    cat "$3.$i" | grep "Max retries" | sed 's/.*page \([0-9any]*\) for crawl \([A-Z0-9-]*\)-index/\2 \1/g' | \
    awk '{a[$1] = a[$1] " " $2} END {for (k in a) print "--coll",k,"--pages",a[k]}' | \
    {
     i=$(($i+1))
     echo "Doing $i th round of full retry " >&2
     rm -f "$3.$i"
     while read; do
         sleep 30  # Sleep to prevent ddos
         download_index $1 $2 "-a $3.$i" "$REPLY"
     done
    }
    i=$(($i+1))
done

if [ ${i} -lt $4 ]; then
    echo "Successfully finnished after $i iterations!" >&2
else
    echo "Finnished after ${i} of $4 iterations please check if everything is all right!" >&2
fi
