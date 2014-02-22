@echo off
netsh advfirewall firewall add rule name="block 10.x" dir=out proflie=any remoteip=10.0.0.0/8 action=block
netsh advfirewall firewall set all logging filename "C:\temp\pfirewall.log"
netsh advfirewall set all logging droppedconnections enable
netsh advfirewall set all logging maxfilesize=5120

REM change all passwords in aD
dsquery user ou=Users,dc=team,dc=local | dsmod user -pwd RedTeamSucks! -mustchpwd yes
