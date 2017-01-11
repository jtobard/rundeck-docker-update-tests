
#uncomment to use local deb file
#cp /app/rundeck.deb /tmp/rundeck.deb
#cp /app/rundeck-upd.deb /tmp/rundeck-upd.deb

echo "* installing rundeck"

dpkg -i --force-confnew /tmp/rundeck.deb

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
dpkg -i --force-confnew /tmp/rundeck-upd.deb

cp -r /app/etc/rundeck/rundeck-config.properties /etc/rundeck/rundeck-config.properties

sed 's,https://localhost:4443,'$SERVER_URL',g' -i /etc/rundeck/rundeck-config.properties
sed 's,rundeckdb,'$MYSQL_DATABASE',g' -i /etc/rundeck/rundeck-config.properties
sed 's,rundeckuser,'$MYSQL_USER',g' -i /etc/rundeck/rundeck-config.properties
sed 's,rundeckpassword,'$MYSQL_PASSWORD',g' -i /etc/rundeck/rundeck-config.properties

echo "*launching rundeck service"
/etc/init.d/rundeckd start

echo "*tail -f updated rundeck log"
timeout 90 tail -f /var/log/rundeck/service.log

echo "*stoping new rundeck"
/etc/init.d/rundeckd stop


#iterate over conf file
while read line; do
	TABLE=$( echo "$line" |cut -f1 )
	FIELD=$( echo "$line" |cut -f2 )
	EXPECTED=$( echo "$line" |cut -f3 )

	OUTPUT="$(mysql -h mysql -u rundeck -prundeck rundeck -e 'DESCRIBE '$TABLE';' | grep $FIELD | cut -f 2)"

	echo "Testing $TABLE.$FIELD = $EXPECTED"

	if [ "$OUTPUT" = "$EXPECTED" ]; then
	  echo "expected field value:$OUTPUT OK"
	  echo "expected field value:$OUTPUT OK" >> /etc/rundeck/result.log
	else
		echo "unexpected field value:$OUTPUT"
		echo "unexpected field value:$OUTPUT" >> /etc/rundeck/result-error.log
		exit 1
	fi

done </app/fields.conf


exit 0
