# update the package index files from sources 

#upgrade_packages:
#  pkg
#   - refresh: True

# add the repos

{% for val in pillar.get('vmrepo_p', {}) %}
{{val}}:
  pkg.installed:
    - pkg: {{val}}
{% endfor %}

# add the packages

{% for val in pillar.get('apt_p', {}) %}
{{val}}:
  pkg.installed:
    - pkg: {{val}}
{% endfor %}


# add the users

{% for user in pillar.get('userlist', {}) %}
{{user}}:
  user.present:
    - name: {{user}}
    - password: $5$bDz8tFsnv/46v$5qUAD2Yp6DyXr3urtS8Gaitu/QJvGaqWjEx1xoIMU43
{% endfor %}

# add the admin group and the user to it.

admin:
  group.present:
   - members:
    {% for user in pillar.get('userlist', {}) %}
      - {{user}}
    {% endfor %}

# adjust the sshd config file..

/etc/ssh/sshd_config:
   file.append:
    - text:
       - "PermitRootLogin No"

# adjust the sudoers file..

/etc/sudoers:
   file.append:
    - text:
       - "admin  ALL=(ALL)       ALL"

copy snmpd.conf:
   file.managed:
     - name: /etc/snmp/snmpd.conf
     - source: salt://ram_initial/templates/snmpd.conf.template
     - user: root
     - group: root
     - mode: 644
     - makedirs: true
     - backup: minion
     - template: jinja

copy main.cf:
   file.managed:
     - name: /etc/postfix/main.cf
     - source: salt://ram_initial/templates/main.cf.template
     - user: root
     - group: root
     - mode: 644
     - makedirs: true
     - backup: minion
     - template: jinja

copy iptables.conf:
   file.managed:
     - name: /etc/sysconfig/iptables
     - source: salt://ram_initial/templates/iptables.6.template
     - user: root
     - group: root
     - mode: 644
     - makedirs: true
     - backup: minion
     - template: jinja

copy resolv.conf:
   file.managed:
     - name: /etc/resolv.conf
     - source: salt://ram_initial/templates/resolv.conf.template
     - user: root
     - group: root
     - mode: 644
     - makedirs: true
     - backup: minion
     - template: jinja

# copy the files 
# copy the files 

{% for file in ['rkhunter.conf'] %}
{{ file }}:
  file.managed:
     - name: /etc/{{ file }}
     - source: salt://ram_initial/files/{{ file }}
     - user: root
     - group: root
     - mode: 644
     - backup: minion
{% endfor %}

# restart nrpe

restart nrpe:
    service.running:
      - restart: True
      - name: nrpe

# create the aide database

/var/lib/aide/aide.db.new.gz:
  cmd:
    - run
    - name: aide --init && mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
    - unless: test -f /var/lib/aide/aide.db.gz 
