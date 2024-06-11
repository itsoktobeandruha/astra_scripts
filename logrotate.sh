#!/bin/sh


if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi



cat <<EOT > /etc/logrotate.d/kernlog
/var/log/parsec/kernel.mlog {
    size 500M
    missingok
    rotate 7
    compress
    notifempty
    postrotate
                systemctl restart parlogd
    endscript
}
EOT

echo "/usr/sbin/logrotate /etc/logrotate.d/kernlog" > /etc/cron.hourly/logrotate.sh
chmod ug+x /etc/cron.hourly/logrotate.sh

systemctl enable cron.service
systemctl start cron.service