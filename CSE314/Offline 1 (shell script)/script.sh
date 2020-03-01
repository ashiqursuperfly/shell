## Constants ##
begin="begin"
end="end"
temp_file="_temp"
output_dir="../_output_dir_1605103"
csv_file_name="../_output_csv_1605103.csv"
csv_header="File Path,Line Number,Line Containing Searched String"

## Utils ##
debug=0
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

format_file_name(){
	local_file_name=$1
	local_search_query=$2
	local_search_zone=$3

	if [ $local_search_zone == $begin ]; then
		line_no=`grep "$search_query" -i -n "$local_file_name" | cut -d':' -f1 | head -1`
	elif [ $local_search_zone == $end ]; then
		line_no=`grep "$search_query" -i -n "$local_file_name" | cut -d':' -f1 | tail -1`
	else 
		error "Invalid Search Zone inside file name formatter"
	fi		
	
	local_file_name=$(echo $local_file_name | cut -c 2-) # remove the '.' from prefix "./"
	
	local_file_ext=`echo $local_file_name | rev | cut -d'.' -f 1 | rev` # assuming last . separated value is extension
	local_ext_length=`echo -n $local_file_ext | wc -m`
	actual_file_name_length=`echo -n $local_file_name | wc -m`

	if [ $local_ext_length -eq $actual_file_name_length ]; then
		log "No Extension for file $local_file_name"
		file_name_without_ext=$local_file_name
		local_file_ext=""
	else
		local_ext_length=`expr $local_ext_length + 2`	
		file_name_without_ext=`echo $local_file_name | rev | cut -c "$local_ext_length"- | rev ` 
		local_file_ext=".$local_file_ext"	
	fi


	file_name_without_ext=`tr '/' '.' <<<"$file_name_without_ext"` # replace all '/' by '.'" 
	file_name_without_ext="$working_dir$file_name_without_ext"
	
	log "format file name : $local_file_name $local_search_query $local_search_zone $line_no $local_file_ext $local_ext_length $actual_file_name_length $file_name_without_ext"

	ret="$file_name_without_ext"_"$line_no$local_file_ext"
	ret2="$line_no"
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

## TODO : try to list only human readable files
find ./ -type f -printf '%h/%f\n' > $temp_file 
n=`wc -l $temp_file | cut -d ' ' -f1`

# cat $temp_file
log "total files: $n"

csv_text=$csv_header
count_of_files_matching_criteria=0
for ((i=0; i<$n; i++))
do
	file=`head -1  $temp_file`
       
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

	mkdir -p "$output_dir"

	if grep -q -i "$search_query" <<< "$lines"; then
		log "Found:" 
		log "$file"
		
		count_of_files_matching_criteria=`expr $count_of_files_matching_criteria + 1`

		unmodified_full_path="$working_dir"$(echo $file | cut -c 2-)

		format_file_name "$file" "$search_query" "$search_zone"
		
		matched_line=`sed "${line_no}q;d" "$file"`

		new_csv_text=""$unmodified_full_path",$ret2,"$matched_line""
		
		log "CSV: $new_csv_text"
		
		csv_text="$csv_text\n"
		csv_text="$csv_text$new_csv_text"
		
		#log "modified: $ret $ret2"
		cp "$file" "$ret"
		mv "$ret" $output_dir

	fi
done

rm $temp_file
echo "Number of Files Matching Criteria: $count_of_files_matching_criteria"

#echo -e $csv_text

printf "$csv_text" > "$csv_file_name"
