
echo "* installing rundeck"

dpkg -i  /tmp/rundeck.deb

cp -r /app/etc/rundeck/rundeck-config.properties /etc/rundeck/rundeck-config.properties

sed 's,https://localhost:4443,'$SERVER_URL',g' -i /etc/rundeck/rundeck-config.properties
sed 's,rundeckdb,'$MYSQL_DATABASE',g' -i /etc/rundeck/rundeck-config.properties
sed 's,rundeckuser,'$MYSQL_USER',g' -i /etc/rundeck/rundeck-config.properties
sed 's,rundeckpassword,'$MYSQL_PASSWORD',g' -i /etc/rundeck/rundeck-config.properties





echo "*launching rundeck service"


/etc/init.d/rundeckd start
echo "*sleep 60 sec"
sleep 60
echo "*tail log"
tail /var/log/rundeck/service.log

echo "*stoping old rundeck"
/etc/init.d/rundeckd stop

echo "*updating rundeck"
dpkg -i /tmp/rundeck-upd.deb

echo "*launching rundeck service"
/etc/init.d/rundeckd start

echo "*tail -f updated rundeck log"
timeout 90 tail -f /var/log/rundeck/service.log

echo "*stoping new rundeck"
/etc/init.d/rundeckd stop

exit
