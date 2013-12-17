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

# Jenkins settings + php template
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin checkstyle cloverphp dry htmlpublisher jdepend plot pmd violations xunit ant gradle mailer
java -jar jenkins-cli.jar -s http://localhost:8080 safe-restart
curl https://raw.github.com/sebastianbergmann/php-jenkins-template/master/config.xml | java -jar jenkins-cli.jar -s http://localhost:8080 create-job php-template
java -jar jenkins-cli.jar -s http://localhost:8080 reload-configuration
