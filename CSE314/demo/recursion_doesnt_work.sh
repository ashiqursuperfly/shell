f(){
   v=$1
#   echo $v
  
   if [ $v != "recursion" ];then
  	 f "recursion"
   else
  	echo "end $v"	   
   fi 

   echo $v
  
}

f "x"


