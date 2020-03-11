### Arrays in Shell
# arr[2]="val2"

### initialiser
# array=(1 2 3 432 231 fdsf dsa)
# echo ${array[4]

fib=(1 1)


for((i=2;i<10;i++))
do
	t0=${fib[$i-1]}
	t1=${fib[$i-2]}
        t2=`expr $t0 + $t1`	
        fib[$i]=$t2
done

for((i=0;i<10;i++))
do
    echo ${fib[$i]}
done

## Iterating through an array like a list

for i in ${fib[*]} ## using @ will treat every space separated object as new
do
	echo $i
done




## accessing array length

echo ${#fib[*]}
echo ${#fib[@]}

