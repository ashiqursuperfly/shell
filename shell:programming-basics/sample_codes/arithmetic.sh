v1=`expr 2 + 3`
v2=`expr 4 \* 2`

v3=`expr $v1 + $v2`
echo "v1 + v2 = $v3"

v3=`expr $v1 \* $v2`
echo "v1 * v2 = $v3"

v3=`expr $v1 < $v2`
echo "v1 < v2 = $v3"

v3=`expr $v3 + $v2`
echo "(v1<v2) + v2 = $v3"

