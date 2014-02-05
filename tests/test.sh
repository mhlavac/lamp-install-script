vagrant destroy -f
vagrant up

lampIp=192.168.201.100

# Check if mysql.lamp is available
wget --header="Host: mysql.lamp" -O "mysql.lamp.html" -o /dev/null $lampIp
if [ `grep -c "<title>phpMyAdmin" "mysql.lamp.html"` -eq 1 ]; then
    echo -e "\033[32mmysql.lamp - ok"
else
    echo -e "\033[31mmysql.lamp - fail"
fi

# Check if mysql.lamp is logged in as a root
if [ `grep -c "input_username" "mysql.lamp.html"` -eq 0 ]; then
    echo -e "\033[32mmysql.lamp - root logged in - ok"
else
    echo -e "\033[31mmysql.lamp - root logged in - fail"
fi

rm "mysql.lamp.html"

# Check RockMongo is available at mongo.lamp
wget --header="Host: mongo.lamp" -O "mongo.lamp.html" -o /dev/null $lampIp
if [ `grep -c "RockMongo" "mongo.lamp.html"` -eq 2 ]; then
    echo -e "\033[32mmongo.lamp - ok"
else
    echo -e "\033[31mmongo.lamp - fail"
fi

# Check if RockMongo is on loggin page
if [ `grep -c "input.*username" "mongo.lamp.html"` -eq 1 ]; then
    echo -e "\033[32mmongo.lamp - login page - ok"
else
    echo -e "\033[31mmongo.lamp - login page - fail"
fi

rm "mongo.lamp.html"

wget --header="Host: lamp" -O "lamp.html" -o /dev/null $lampIp
if [ `grep -c "Lamp setup" "lamp.html"` -eq 1 ]; then
    echo -e "\033[32mlamp - ok"
else
    echo -e "\033[31mlamp - fail"
fi

# Test creation of new project

vagrant ssh -c 'sudo mkdir /var/www/test.lamp; sudo chmod -R 777 /var/www/test.lamp; echo "hello world!" > /var/www/test.lamp/web/index.html'

wget --header="Host: test.lamp" -O "test.lamp.html" -o /dev/null $lampIp
if [ `grep -c "hello world!" "test.lamp.html"` -eq 1 ]; then
    echo -e "\033[32mproject creation - ok"
else
    echo -e "\033[31mproject creation - fail"
fi

if [ `host "test.lamp" $lampIp | grep -c "has address $lampIp"` -eq 1 ]; then
    echo -e "\033[32mproject creation - dns - ok"
else
    echo -e "\033[31mproject creation - dns - fail"
fi

# Test removal of project

vagrant ssh -c "sudo rm -rf /var/www/test.lamp"
wget --header="Host: test.lamp" -O "test.lamp.html" -o /dev/null $lampIp
if [ `grep -c "hello world!" "test.lamp.html"` -eq 0 ]; then
    echo -e "\033[32mproject removal - wget - ok"
else
    echo -e "\033[31mproject removal - wget - fail"
fi

if [ `host "test.lamp" $lampIp | grep -c "not found"` -eq 1 ]; then
    echo -e "\033[32mproject removal - dns - ok"
else
    echo -e "\033[31mproject removal - dns - fail"
fi
