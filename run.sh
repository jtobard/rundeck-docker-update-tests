
echo "* installing rundeck"

dpkg -i  /tmp/rundeck.deb
#cp -r /app/etc/* /etc
#sed 's,https://localhost:4443,'$SERVER_URL',g' -i /etc/rundeck/rundeck-config.groovy
#sed 's,rundeckdb,'$MYSQL_DATABASE',g' -i /etc/rundeck/rundeck-config.groovy
#sed 's,rundeckuser,'$MYSQL_USER',g' -i /etc/rundeck/rundeck-config.groovy
#sed 's,rundeckpassword,'$MYSQL_PASSWORD',g' -i /etc/rundeck/rundeck-config.groovy
#sed 's,tochange,'$PASSWORD',g' -i /etc/rundeck/realm.properties
#PASSWORD=""


if [ ! -f /var/lib/rundeck/.ssh/id_rsa ]; then
    echo "* Generating rundeck ssh key"

    mkdir -p /var/lib/rundeck/.ssh
    ssh-keygen -t rsa -b 4096 -f /var/lib/rundeck/.ssh/id_rsa -N ''
fi


echo "*launching rundeck service"

chown -R rundeck:rundeck /tmp/rundeck
chown -R rundeck:rundeck /etc/rundeck
chown -R rundeck:rundeck /var/rundeck
chown -R rundeck:rundeck /var/log/rundeck
chown -R rundeck:rundeck /var/lib/rundeck

cat /var/lib/rundeck/.ssh/id_rsa.pub

. /lib/lsb/init-functions
. /etc/rundeck/profile

#DAEMON="${JAVA_HOME:-/usr}/bin/java"
#DAEMON_ARGS="${RDECK_JVM} -cp ${BOOTSTRAP_CP} com.dtolabs.rundeck.RunServer /var/lib/rundeck ${RDECK_HTTP_PORT}"
#rundeckd="$DAEMON $DAEMON_ARGS"
/etc/init.d/rundeckd start
echo "*sleep 60 sec"
sleep 60
#echo "*tail -f log"
#tail -f /var/log/rundeck/service.log

echo "*stoping old rundeck"
/etc/init.d/rundeckd stop

echo "*updating rundeck"
dpkg -i /tmp/rundeck-upd.deb

echo "*launching rundeck service"
/etc/init.d/rundeckd start

echo "*tail -f updated rundeck log"
tail -f /var/log/rundeck/service.log
