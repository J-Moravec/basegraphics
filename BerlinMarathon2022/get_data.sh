#!/usr/bin/env bash
mkdir -p data

#for (( i = 1; i < 356; i++ )); do
#        echo ${i}
#        url="https://berlin.r.mikatiming.com/2022/?page=${i}&event=BML&num_results=100&pid=search&search%5Bage_class%5D=%25&search%5Bsex%5D=%25&search%5Bnation%5D=%25&search_sort=name"
#        wget -O data/berlin.html ${url}
#        grep type-fullname data/berlin.html | tr '>' '\t' | cut -f 3 | tr '<' '\t' | cut -f1 | uniq > data/runner_${i}.tsv
#        grep Finish data/berlin.html | tr '>' '\t' | grep -v 'pan class' | cut -f 4 | tr '<' '\t' | cut -f1 > data/times_${i}.tsv
#done

cat data/times_* | grep -v Finish | grep -v DSQ > $1
