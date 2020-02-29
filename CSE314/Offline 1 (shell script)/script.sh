## Constants ##
begin="begin"
end="end"
temp_file="_temp"
output_dir="../_output_dir_1605103"

## Utils ##
debug=1
log(){
        if [ $debug -eq  1 ] ; then
                echo $1
		echo ""
        fi
}

error(){
       	echo "ERROR: $1"
	exit
}

## Script ##

error_msg="Please pass atleast one command line arg r: <input_file_name>"
if [ $# -eq 0 ]; then
	error "$error_msg"

elif [ $# -eq 2 ]; then
	working_dir=$1
	input_file=$2
	log "working_dir=$working_dir input_file=$input_file"

elif [ $# -eq 1 ]; then
	input_file=$1
	working_dir="root"
	log "no working_dir provided assuming already in working_dir; input_file=$input_file"
	
else 
	error "invalid number of command line args provided"
fi

if [ -f $input_file ]; then
	search_zone=`head -1 input.txt`
	search_query=`tail -1 input.txt`
	number_of_lines=`tail -2 input.txt | head -1`
	log "inputs: $search_zone $search_query $number_of_lines"
else
	error "Please enter a valid file name"
fi

if [ $working_dir != "root" ]; then
      	cd $working_dir
fi

log "working_dir contents"
log "`ls`"


#r1=`grep -H -R -i "$search_query" | cut -d: -f1 | uniq`
#r2=`grep -i -r -m $number_of_lines "$search_query" | cut -d: -f1 | uniq`

find ./ -type f -printf '%h/%f\n' > $temp_file 
n=`wc -l $temp_file | cut -d ' ' -f1`

# cat $temp_file

log "total files: $n"

for ((i=0; i<$n; i++))
do
	file=`head -1  $temp_file`
	#log "Searching:"
        #log "$file"
       
       	sed -i 1d $temp_file

	if [ $search_zone == $begin ]; then
		lines=`head -$number_of_lines "$file"`
	        # log "$lines"

	elif [ $search_zone == $end ]; then	
		lines=`tail -$number_of_lines "$file"`
		# log "$lines"
	else
		error "invalid search_zone $search_zone"
	fi

	if grep -q -i "$search_query" <<< "$lines"; then
	        log "Found:" 
		log "$file"
		mkdir -p "$output_dir"
                cp "$file" "$output_dir"
	fi
done


rm $temp_file









































