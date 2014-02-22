#!/bin/bash
find / -mmin -5 > ~administrator/skeptic files
sed -i 's/md5/sha512 rounds=50/' /etc/pam.d/common-password

passwd -l
for N in `cut -d: -f1 /etc/passwd`; do
  M=`id -u $N`
  if [ $M -lt 500 -a $N =! 'root' ]; then
    usermod -L -s /dev/null $N
  fi
done

echo "administrator ALL=(ALL)  ALL" >> /etc/sudoers
/etc/init.d/ntp stop
/etc/init.d/sshd stop


aptitude remove portmap nfs-kernel-server nfs-common apache2 php5 -purge -y
sed -i 's/us.archive/old-releases/' /etc/apt/sources.list
echo 'deb http://old-releases.ubuntu.com/ubuntu hardy-update main restricted universe multiverse'
echo 'deb http://old-releases.ubuntu.com/ubuntu hardy-scurity main restricted universe multiverse'
aptitude update
aptitude safe-upgrade

#SQL STUFF
mysql -u root < sql-update.sql
sed -i '/^# log/s/# //' /etc/my.cnf
/etc/init.d/mysql restart
mkdir ~/my
mysqldump -u root -A > my/all-db.sql
chattr +i my/all-db.sql


#firewall
wget firewall -O - | tr -d '\r' > firewall-rules
iptables -P INPUT DROP
echo "change passwords now"
bash
passwd -l adam
iptables-restore < firewall

#NTP
do-release-upgrade

#send logs to remote server
