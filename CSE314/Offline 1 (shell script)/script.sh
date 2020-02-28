## Utils ##
debug=1
log(){
        if [ $debug -eq  1 ] ; then
                echo $1
		echo ""
        fi
}

## Script ##

error_msg="please pass atleast one command line arg r: <input_file_name>"
if [ $# -eq 0 ]; then
	echo $error_msg
	exit

elif [ $# -eq 2 ]; then
	working_dir=$1
	input_file=$2
	log "working_dir=$working_dir input_file=$input_file"

elif [ $# -eq 1 ]; then
	input_file=$1
	working_dir="root"
	log "no working_dir provided assuming already in working_dir; input_file=$input_file"
	
else 
	echo "invalid number of command line args provided"
	exit
fi

search_zone=`head -1 input.txt`
search_query=`tail -1 input.txt`
number_of_lines=`tail -2 input.txt | head -1`

log "inputs: $search_zone $search_query $number_of_lines"

if [ $working_dir != "root" ]; then
      	cd $working_dir
fi

log "working_dir contents"
log "`ls`"

















