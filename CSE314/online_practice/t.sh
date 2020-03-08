v=`file dummy.txt`
if [ grep -i "ASCII" <<< $v ]    
