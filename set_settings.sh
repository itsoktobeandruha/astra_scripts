#!/bin/bash


if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

echo "other::1ffff:0" > /etc/parsec/auddb/other:0

sed -i 's/pam_tally.so per_user.*/pam_tally.so per_user deny=3 lock_time=5 unlock_time=900/' /usr/share/pam-configs/tally
#sed -i  's/pam_tally.so$/pam_tally.so deny=3 lock_time=5 unlock_time=900/' /usr/share/pam-configs/tally

sed -i 's/pam_cracklib.so.*/pam_cracklib.so retry=3 difok=3 minlen=8 lcredit=-2 ucredit=-1 dcredit=-5 ocredit=-4/' /usr/share/pam-configs/cracklib  

sed -i 's/PASS_MAX_DAYS.*/PASS_MAX_DAYS  90/' /etc/login.defs 
sed -i 's/PASS_WARN_AGE.*/PASS_WARN_AGE  14/' /etc/login.defs