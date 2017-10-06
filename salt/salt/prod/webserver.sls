#nginx:
#  pkg.installed: []
#  service.running:
#    - require:
#      - pkg: nginx

/etc/nginx/index.html:                        # ID declaration
  file:                                     # state declaration
    - managed                               # function
    - source: salt://webserver/index.html   # function arg
    - require:                              # requisite declaration
      - pkg: nginx                         # requisite reference

nginx:
  pkg.installed: []
  service.running:
    - watch:
       - file: myindexfile 
    - require:
      - pkg: nginx

myindexfile:
 file.managed:
 - name: /etc/nginx/index.html
 - source: salt://webserver/index.html   
