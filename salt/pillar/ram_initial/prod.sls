ram_initial: prod
apt_p:
 - libselinux-python
 - vmware-tools-esx
 - epel-release
 - nrpe
 - nagios-plugins-users
 - nagios-plugins-load
 - nagios-plugins-swap
 - nagios-plugins-disk
 - nagios-plugins-procs
 - net-snmp
 - net-snmp-utils
 - rkhunter
 - aide

vmrepo_p:
 - http://packages.vmware.com/tools/esx/5.1/repos/vmware-tools-repo-RHEL6-9.0.0-2.x86_64.rpm
 - https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
