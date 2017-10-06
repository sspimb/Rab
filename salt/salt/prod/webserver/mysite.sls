{% if pillar.get('webserver_role', '') %}
/var/www/mysite:
  file.recurse:
    - source: salt://webserver/src/mysite
    - env: {{ pillar['webserver_role'] }}
    - user: www-data
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
{% endif %}
