#!/bin/bash

#List of indices to merge
indices=$(curl -s -XGET "http://x.x.x.x:9200/_cat/indices?v" | awk 'NR>1 {print $3}')
formatted_indices="List of indices to merge:\n$indices"
echo -e "$formatted_indices"

for index in $indices
do
    echo "Merging index: $index"
    curl -XPOST "http://x.x.x.x:9200/$index/_forcemerge?pretty"
    if [ $? -eq 0 ]
    then
	    echo "Successfully merge $index"
	    echo "~~~~~~~~~~~~~~~~~~~~~~~~"
	    exit 0
    else
	    echo "Could not merge $index" >&2
	    exit 1
    fi
    # Wait for 120 seconds after each merge
    sleep 120
done
