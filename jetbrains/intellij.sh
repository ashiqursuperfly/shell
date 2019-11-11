printf 'Installing IntelliJ\n\n'
while [ 0 == 0 ]
do
printf 'Select Edition: \n1. Professional \n2. Community \n3. Skip\n'
read input
if [ $input == 1 ]
then
    printf 'Installing IntelliJ Professional\n'
    sudo snap install intellij-idea-ultimate --classic
    break  
elif [ $input == 2 ]
then
    printf 'Installing IntelliJ Community\n'
    sudo snap install intellij-idea-community --classic
    break
elif [ $input == 3 ]
then
    printf 'Not Installing IntelliJ\n'
    break    
else
    printf 'Invalid Input\n'
fi
done