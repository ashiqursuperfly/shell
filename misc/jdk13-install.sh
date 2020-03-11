echo 'installing jdk13'
sudo apt update
sudo apt -y install wget
wget --no-check-certificate -c --header  "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/13+33/5b8a42f3905b406298b72d750b6919f6/jdk-13_linux-x64_bin.deb"
echo 'if any dependency errors occur try : sudo apt -f install'
sudo dpkg -i jdk-13_linux-x64_bin.deb
cat <<EOF | sudo tee /etc/profile.d/jdk13.sh
export JAVA_HOME=/usr/lib/jvm/jdk-13
export PATH=\$PATH:\$JAVA_HOME/bin
EOF
source /etc/profile.d/jdk13.sh
echo 'java-version:'
java -version
echo 'jdk path:'
echo $JAVA_HOME
