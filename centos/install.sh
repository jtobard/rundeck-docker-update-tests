
echo "* installing rundeck"

yum install -y --nogpgcheck /tmp/rundeck.rpm /tmp/rundeck-config.rpm


echo "*launching rundeck service"


/etc/init.d/rundeckd start
echo "*sleep 60 sec"
sleep 60
echo "*tail log"
tail /var/log/rundeck/service.log

echo "*stoping old rundeck"
/etc/init.d/rundeckd stop

echo "*updating rundeck"
yum update -y /tmp/rundeck-config-upd.rpm /tmp/rundeck-upd.rpm


echo "*launching rundeck service"
/etc/init.d/rundeckd start

echo "*tail -f updated rundeck log"
timeout 90 tail -f /var/log/rundeck/service.log

echo "*stoping new rundeck"
/etc/init.d/rundeckd stop

exit