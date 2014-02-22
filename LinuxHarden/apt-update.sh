#!/bin/sh
change passwords /dev/null
password   required   pam_unix.so obscure sha512
pam L  auth     requisite  pam_securetty.so
/p/com-auth null
/e/p/su        auth        requisite   pam_wheel.so group=wheel debug
/e/p/c-s session    optional     pam_tmpdir.so
/e/p/o 
auth     required       pam_securetty.so
       auth     required       pam_unix_auth.so
       auth     required       pam_warn.so
       auth     required       pam_deny.so
       account  required       pam_unix_acct.so
       account  required       pam_warn.so
       account  required       pam_deny.so
       password required       pam_unix_passwd.so
       password required       pam_warn.so
       password required       pam_deny.so
       session  required       pam_unix_session.so
       session  required       pam_warn.so
       session  required       pam_deny.so

login.defs LOG_OK_LOGINS		yes
            LOG_OK_LOGINS  yes
            ENCRYPT_METHOD  SHA512
awk -F : '{if ($3<1000) print $1}' /etc/passwd > /etc/ftpusers
/e/s/a.con  -:wheel:ALL EXCEPT LOCAL

            
remove users
remove groups
sudoers
home  0750 
 #  find /var/log -type f -exec ls -l {} \; | cut -c 17-35 |sort -u
       (see to what users do files in /var/log belong)
       #  find /var/log -type f -exec ls -l {} \; | cut -c 26-34 |sort -u
       (see to what groups do files in /var/log belong)
       # find /var/log -perm +004
       (files which are readable by any user)
       #  find /var/log \! -group root \! -group adm -exec ls -ld {} \;
       (files which belong to groups not root or adm)
checksecurity
clamav
logcheck
chat  /bin, /sbin/, /usr/bin, /usr/sbin, /usr/lib
http://www.debian.org/doc/manuals/securing-debian-howto/ch12.en.html
portsentry

#replace old sources list with updated version
sed -i -e 's/us.archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
apt-get -y remove cups portmap nfs-common avahi-daemon seahorse

# update system
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoremove -y

crontab -r


#install unzip for scripts, and tiger for hardening

apt-get install unzip tiger 

for i in `sudo lsof -i | grep LISTEN | cut -d " " -f 1 |sort -u` ; do
       pack=`dpkg -S $i |grep bin |cut -f 1 -d : | uniq`
       echo "Service $i is installed by $pack";
       init=`dpkg -L $pack |grep init.d/ `
       if [ ! -z "$init" ]; then
         echo "and is run by $init"
       fi
     done
     
for i in `/usr/sbin/lsof -i |grep LISTEN |cut -d " " -f 1 |sort -u`; \
       > do user=`ps ef |grep $i |grep -v grep |cut -f 1 -d " "` ; \
       > echo "Service $i is running as user $user"; done


