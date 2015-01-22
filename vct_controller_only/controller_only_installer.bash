#!/bin/bash

mgmt_prefix="fe80::42:acff:fe11:141/64"
managepy="python /home/confine/confine/manage.py"

service postgresql restart

su confine -c "sudo $managepy setuppostgres --db_user confine --db_password confine --db_name confine"

su confine -c "sudo $managepy syncdb --noinput"

su confine -c "sudo $managepy migrate --noinput"
#su vct -c "$managepy createsuperuser"

su confine -c "echo -e \"\\
from django.contrib.auth import get_user_model;\\
User = get_user_model()\n\\
if not User.objects.filter(username='confine').exists(): \\
User.objects.create_superuser('confine', 'confine@confine-project.eu', 'confine',name='confine'),exit()\n\" | $managepy shell"

#celeryd
$managepy setupceleryd --username confine

service rabbitmq-server restart
#tincd

$managepy setuptincd --noinput --mgmt_prefix $mgmt_prefix
service tinc restart

su confine -c "$managepy updatetincd"
su confine -c "$managepy setuppki --org_name VCT --noinput"

#Apache installation
apt-get install -y libapache2-mod-wsgi apache2 apache2-bin apache2-data
$managepy setupapache --noinput --user confine --processes 2 --threads 25

su confine -c "$managepy collectstatic --noinput"
su confine -c "$managepy loaddata firmwareconfig"
#su confine -c "$managepy loaddata "$VCT_DIR/server/vct/fixtures/firmwareconfig.json"
su confine -c "$managepy syncfirmwareplugins"

#su confine -c "sudo $managepy startservices --no-tinc --no-celeryd --no-celerybeat --no-apache2"
#su confine -c "sudo $managepy restartservices"

