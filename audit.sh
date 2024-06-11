#!/bin/bash

current_time=`date`
computer_info=`hostnamectl`
installed=`grep "install" /var/log/dpkg.log`
packages=`dpkg -l`
full_filename="$1"

echo "Script execution time $current_time" > $full_filename
echo "$computer_info" >> $full_filename
echo "$installed" >> $full_filename
echo "$packages" >> $full_filename
