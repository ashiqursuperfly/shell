find_grade(){
    if [ $1 -gt 80 ]; then
        ret="A"
    elif [ $1 -gt 60 ]; then
        ret="B"
    elif [ $1 -gt 40 ]; then
        ret="C"
    else 
        ret="F"
    fi        
}

courses_file="course.txt"
temp_courses_file=".temp_courses"
cat $courses_file > $temp_courses_file

marks_array=()

students_arr=()
students_arr_size=0
addStudent(){
    students_arr[$students_arr_size]=$1
    students_arr_size=`expr $students_arr_size + 1`
}

number_of_courses=`wc -l $temp_courses_file | cut -d ' ' -f1` 

echo "Number Of Courses:-$number_of_courses"

for ((i=0;i<$number_of_courses;i++))
do
    course_name=`head -1 $temp_courses_file`
    echo $course_name
    sed -i 1d $temp_courses_file

    course_grades_file="$course_name.txt"

    number_of_students=`wc -l $course_grades_file | cut -d ' ' -f1`

    for ((j=1;j<=$number_of_students;j++))
    do
        marks_row=`sed "${j}q;d" $course_grades_file`
        std_id=`echo $marks_row | cut -d ' ' -f1`
        marks=`echo $marks_row | cut -d ' ' -f2`
        #echo "$std_id---$marks"

        marks_array["$std_id$i"]=$marks

        addStudent $std_id

    done

done    

csv_lines="StudentID,physics,math,CSE100,Total Marks,Average Marks,Grade"
for student_id in "${students_arr[@]}"
do
    total_marks_of_one_student=0
    temp_csv_line="$student_id"
    for ((course_id=0;course_id<$number_of_courses;course_id++))
    do
        t=${marks_array[$student_id$course_id]}

        if [ $t -ne -1 ]; then

            marks_array[$student_id$course_id]=-1
            total_marks_of_one_student=`expr $total_marks_of_one_student + $t`

            temp_csv_line="$temp_csv_line,$t"
        fi    
    done
    if [ $t -eq -1 ]; then
        continue
    fi
    avg_marks_of_one_student=`expr $total_marks_of_one_student \/ $number_of_courses`

    find_grade $avg_marks_of_one_student
    temp_csv_line="$temp_csv_line,$total_marks_of_one_student,$avg_marks_of_one_student,$ret"

    csv_lines="$csv_lines\n"
    csv_lines="$csv_lines$temp_csv_line"


    echo $temp_csv_line
    
done


printf "$csv_lines" > "grades_103.csv"


