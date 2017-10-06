ldapport: 389
dnsport: 53
httpport: 80
ldap01: 89.221.186.77
ldap02: 89.221.186.78
dns01: 89.221.177.165
dns02: 89.221.178.86
repo01: ftp.surfnet.nl
debiansec01: security.debian.org
debianftp: ftp.nl.debian.org
debianftpip: 130.89.149.21
rootpath: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
pword: auth3nt1cat0r
userlist:
 - dlaporta
 - spimblett
 - jgroeneveld
 - blubberdink
 - bvdeijk
 - jdhartigh
 - azwijnenburg

deluserlist:
 - wthoorn

ldap_p:
    - libnss-ldap
    - ldap-utils
    - libpam-ldap
    - nscd
