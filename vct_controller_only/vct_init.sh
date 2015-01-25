#!/bin/sh
exec /sbin/setuser confine sudo /usr/bin/python /home/confine/confine/manage.py startservices --no-tinc --no-celeryd --no-celerybeat --no-apache2 >> /var/log/vctdocker.log 2>&1 && exec /sbin/setuser confine sudo /usr/bin/python /home/confine/confine/manage.py restartservices >> /var/log/vctdocker.log 2>&1

#managepy="python /home/confine/confine/manage.py"
#su confine -c "sudo $managepy startservices --no-tinc --no-celeryd --no-celerybeat --no-apache2"
#su confine -c "sudo $managepy restartservices"


