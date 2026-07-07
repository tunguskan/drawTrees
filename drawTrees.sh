#!/bin/bash

rows=62
cols=99
read n

plotTree() {
    local x=$1 y=$2 height=$3 depth=$4 branchOffset=0

    for(( row=y, col=x; row>y-height; row-- )); do

        if (( row > y-height/2 )); then
            plottedTrees[$row*100+$col]='1'
            continue;
        fi

        (( branchOffset++ ))

        local branchA=$(( col-branchOffset ))
        local branchB=$(( col+branchOffset ))

        plottedTrees[$row*100+$branchA]='1'
        plottedTrees[$row*100+$branchB]='1'
    done

    (( depth <= 1 )) && return

     plotTree $branchA $((y-height)) $((height/2)) $((depth-1))
     plotTree $branchB $((y-height)) $((height/2)) $((depth-1))
}

buildGrid() {
    local grid=
    for ((y=0; y<=rows; y++)); do
      for ((x=0; x<=cols; x++)); do
        [[ -v plottedTrees[$y*100+$x] ]] && grid+="1" || grid+="_"
      done
      grid+=$'\n'
    done

    echo -n "$grid"
}

(( n <=5 && n >= 1 )) && plotTree 49 62 32 $n

buildGrid