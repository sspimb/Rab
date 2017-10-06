{% if grains['id'] == 'bp'%} 

dns01:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,RELATED,ESTABLISHED
    - dport: {{ pillar.get('dnsport') }} 
    - proto: tcp
    - save: True
    - destination: {{ pillar.get('dns01') }}

dns02:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,RELATED,ESTABLISHED
    - dport: {{ pillar.get('dnsport') }} 
    - proto: tcp
    - save: True
    - destination: {{ pillar.get('dns02') }}

aptget01:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,RELATED,ESTABLISHED
    - dport: {{ pillar.get('httpport') }} 
    - proto: tcp
    - save: True
    - destination: {{ pillar.get('repo01') }}

aptget02:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,RELATED,ESTABLISHED
    - dport: {{ pillar.get('httpport') }} 
    - proto: tcp
    - save: True
    - destination: {{ pillar.get('debiansec01') }}

{% endif %}

{% if grains['id'] == 'brain'%} 

/etc/hosts:
   file.append:
    - text:
       - "{{ pillar.get('debianftpip') }} {{ pillar.get('debianftp') }}"


debianftp:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,RELATED,ESTABLISHED
    - dport: {{ pillar.get('httpport') }} 
    - proto: tcp
    - save: True
    - destination: {{ pillar.get('debianftp') }}

{% endif %}

ldap01:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,RELATED,ESTABLISHED
    - dport: {{ pillar.get('ldapport') }} 
    - proto: tcp
    - save: True
    - destination: {{ pillar.get('ldap01') }}

ldap02:
  iptables.insert:
    - position: 1
    - table: filter
    - family: ipv4
    - chain: OUTPUT
    - jump: ACCEPT
    - match: state
    - connstate: NEW,RELATED,ESTABLISHED
    - dport: {{ pillar.get('ldapport') }} 
    - proto: tcp
    - save: True
    - destination: {{ pillar.get('ldap02') }}


# save the changes


iptables-save:
  cmd:
    - run
    - name: /sbin/iptables-save > /etc/iptables-save
    - onlyif: test -f /etc/iptables-save

iptables.conf:
  cmd:
    - run
    - name: /sbin/iptables-save > /etc/iptables/iptables.conf
    - onlyif: test -f /etc/iptables/iptables.conf

iptables-conf:
  cmd:
    - run
    - name: /sbin/iptables-save > /etc/iptables/iptables-conf
    - onlyif: test -f /etc/iptables/iptables-conf
