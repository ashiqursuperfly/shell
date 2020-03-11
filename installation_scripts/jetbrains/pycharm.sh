printf 'Installing Pycharm\n\n'
while [ 0 == 0 ]
do
printf 'Select Edition: \n1. Professional \n2. Community \n3. Skip\n'
read input
if [ $input == 1 ]
then
    printf 'Installing Pycharm Professional\n'
    sudo snap install pycharm-professional --classic
    break  
elif [ $input == 2 ]
then
    printf 'Installing Pycharm Community\n'
    sudo snap install pycharm-community --classic
    break
elif [ $input == 3 ]
then
    printf 'Not Installing Pycharm\n'
    break    
else
    printf 'Invalid Input\n'
fi
done
