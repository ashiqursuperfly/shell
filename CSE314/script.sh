## Variables

# Variable types dont need to be defined
# Shouldn't use spaces while assigning variables like x = 3. Shell treats this 'x' as a probable command so its wrong. Correct: x=3
# By default all shell variables are treated as Strings
# If we try to use a variable without assigning, shell doesnt throw an error, just thinks of that variable as a variable with a empty string value
# e.g
x=3
echo $x

## User Input
read x
echo $x

## Arithmetic
expr 1 + 1 # operator must be space separated. expr 1+1 wont work.
expr $x + 1
### Interesting (storing the value of expr into a variable) :
a=`expr $x + 1`
echo $a


### Conditionals
echo 'enter a number'
read x

if [ $x -gt 10 ];then
	echo greater than 10
else
	echo less than or equals to 10
fi

# Alternate syntax

if [ $x -gt 10 ]
then
        echo greater than 10
else
        echo less than or equals to 10
fi

### Accessing Command Line Args
# $n to access nth argument
# $# returns number of args
# $0 returns filename
for a in $*
do
	echo $a
done
x=$#
echo $x args printed filename: $0

### Functions

myfunc(){
	echo this is a function	
}

### Calling a function:-
myfunc # this calls the function

### Functions with args
f(){
	echo func-arg: $1
	echo func-arg: $2
	echo fun-arg: $3
	
	## Question	
	# what if we want to access command line args in the function now?
	# Just call the function with the command line args too
	
	ret='success'
}
### VERY IMPORTANT : Each Shell script has only one SCOPE, no recursive calls. No Local variables. All variables GLOBAL to the script.

f arg1 232 'a'
echo function returned $ret

## alternate way
result=$(f arg1 arg2 arg3) # captures everything thats 'echo'
echo function returned $result
