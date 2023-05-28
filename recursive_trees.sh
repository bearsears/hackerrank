#!/bin/bash
declare -A f_tree
for ((i = 0; i < 63; i++))
do
    for (( j = 0; j < 100; j++))
    do
        f_tree[$i, $j]='_'
    done
done


function recurse {
    #let $1 be a limit, $2 be a starting point y, $3 be starting point x, and $4 be steps
    limit=$(($1 + 0))
    y=$(($2 + 0))
    x=$(($3 + 0))
    steps=$(($4 + 0))
    if [ $limit -eq 0 ] 
    then
        return
    fi
    #go up
    for ((i = 0; i < steps; i++))
    do
        #echo $i, $y, $x
        f_tree[$y, $x]='1'
        ((y -= 1))
    done
    #go left
    xl=$(($x - 1))
    yl=$y
    for ((i = 0; i < steps; i++))
    do
        f_tree[$yl, $xl]='1'
        ((yl -= 1))
        ((xl -= 1))
    done
    ((xl += 1))
    
    #go right
    xr=$(($x + 1))
    yr=$y
    for ((i = 0; i < steps; i++))
    do
        f_tree[$yr, $xr]='1'
        ((yr -= 1))
        ((xr += 1))
    done
    ((xr -= 1))
    #echo $1 $2 $3 $4
    recurse $(($1 - 1)) $(($2 - $4 * 2)) $(($3 - $4)) $(($4 / 2))
    recurse $(($1 - 1)) $(($2 - $4 * 2)) $(($3 + $4)) $(($4 / 2))
       
    
};

read N

recurse N 62 49 16

for ((i = 0; i < 63; i++))
do
    for (( j = 0; j < 100; j++))
    do
        printf "%s" ${f_tree[$i, $j]}
    done
    printf "\n"
done

