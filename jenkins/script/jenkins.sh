echo "Installing jenkins..."
if grep -Fxq "deb http://pkg.jenkins-ci.org/debian binary/" "/etc/apt/sources.list"
then
    echo "Jenkins update site is already added"
else
    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
    echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list
fi
apt-get update
apt-get install -y jenkins
