# add group

{% for group,gid in pillar.get('groups',{}).items() %}
 {{ group }}:
  group.present:
    - gid: {{ gid }}
{% endfor %}


# add user

{% for user, args in pillar.get('users', {}).items() %}
 {{ user }}:
  user.present:
    - uid: {{ args['uid'] }}
    - name: {{ args['name'] }}
    - shell: {{ args['shell'] }}
    - home: {{ args['home'] }}
    - gid: {{ args['groups'] }}
    - password: {{ args['password'] }}
{% endfor %}

# add to sudoers

 /etc/sudoers:
   file.append:
    - text:
       - "{{ pillar.get('ansible_user') }} ALL=(ALL) ALL"

# create .ssh dir and set permissions

 create the ssh dir:
   file.directory:
     - name: /opt/{{ pillar.get('ansible_user') }}/.ssh
     - user: {{ pillar.get('ansible_user') }}
     - group: {{ pillar.get('ansible_group') }}
     - mode: 644
     - makedirs: True

# copy authorized_keys and set permissions

 copy the auth key:
   file.managed:                        
     - name: /opt/{{ pillar.get('ansible_user') }}/.ssh/authorized_keys
     - source: salt://ansible/files/authorized_keys 
     - user: {{ pillar.get('ansible_user') }}
     - group: {{ pillar.get('ansible_group') }}
     - mode: 600
