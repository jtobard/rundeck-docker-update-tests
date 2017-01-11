
* fresh start to test

```
docker-compose rm -f
docker-compose build
docker-compose up
```

fields to test:

Update the fields.conf file with this structure:
table(tabulation)field(tabulation)expected field type

using one line per field to test, like this:

```
project	id	bigint(20)
project	description	varchar(255)
```


To test different versions of .deb edit Dockerfile fields:
```
ADD http://dl.bintray.com/rundeck/rundeck-deb/rundeck-2.6.9-1-GA.deb /tmp/rundeck.deb
ADD http://dl.bintray.com/rundeck/rundeck-deb/rundeck-2.7.1-1-GA.deb /tmp/rundeck-upd.deb
```

pointing to the new urls to test.

Also it is possible to use previously downloaded debs instead of downloading, by uncomment
these lines in the install.sh file:
```
#cp /app/rundeck.deb /tmp/rundeck.deb
#cp /app/rundeck-upd.deb /tmp/rundeck-upd.deb
```
And comment or remove these lines from Dockerfile:
```
ADD http://dl.bintray.com/rundeck/rundeck-deb/rundeck-2.6.9-1-GA.deb /tmp/rundeck.deb
ADD http://dl.bintray.com/rundeck/rundeck-deb/rundeck-2.7.1-1-GA.deb /tmp/rundeck-upd.deb
```


The final result file will be located at  (BASE)/volume/etc/result.log and if it fails, at result-error.log