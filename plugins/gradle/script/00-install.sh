#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

curl http://services.gradle.org/distributions/gradle-1.6-bin.zip > gradle.zip
unzip gradle.zip
rm gradle.zip
mv gradle-1.6 /usr/local/lib/gradle

echo 'export GRADLE_HOME=/usr/local/lib/gradle' > /etc/profile.d/90-gradle.sh
echo 'export PATH=$PATH:$GRADLE_HOME/bin' >> /etc/profile.d/90-gradle.sh
chmod 755 /etc/profile.d/90-gradle.sh
