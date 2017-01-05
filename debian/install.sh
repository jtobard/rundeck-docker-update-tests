
echo "* installing rundeck"

dpkg -i  /tmp/rundeck.deb


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