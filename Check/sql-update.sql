DROP USER 'root'@'172.25.240.11';
DROP USER 'root'@'172.25.241.39';
GRANT ALL PRIVILEGES ON ehour.* to 'ecomm'@'172.25.240.11'IDENTIFIED BY 'H3lpM3Rh0nd@';
GRANT ALL PRIVILEGES ON virtuemart.* to 'ecomm'@'172.25.240.11'IDENTIFIED BY 'H3lpM3Rh0nd@';
GRANT ALL PRIVILEGES ON roundcube.* to 'mail'@'172.25.241.30'IDENTIFIED BY 'Th!$!$n0t@P@$$w0rd';
GRANT ALL PRIVILEGES ON *.* to 'Best1_user'@'localhost' IDENTIFIED BY 'BackupU$r' WITH GRANT OPTION;
DROP USER 'root'@'%';
FLUSH PRIVILEGES;