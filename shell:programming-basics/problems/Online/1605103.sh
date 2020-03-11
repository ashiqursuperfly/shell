error(){
	echo "ERROR: $1"
	exit
}

temp_files="../.temp"
working_dir=$1

if [ -z "$1" ]
then
    error "NO input Directory Specified!"
else
    echo "Working Dir:$1"
fi

cd $1

if [ -z "$2" ]
then
    echo "No Optional Param"
else
    echo "Showing All options"
fi

find . | sed -e "s/[^-][^\/]*\// |/g" -e "s/|\([^ ]\)/|-\1/" > $temp_files

i=0
for arg in "$@"
do
    i=`expr $i + 1`

    if [ $i -eq 1 ]; then
        continue
    fi
    echo "Filtering: $arg"

    new_temp="$temp_files$i"
    grep -v $arg $temp_files > $new_temp
    rm $temp_files
    temp_files="$new_temp"
done


cat $temp_files
rm $temp_files

