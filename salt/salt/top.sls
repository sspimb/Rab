dev:
  'simonldap2*':
    - ansible.ansible
prod:
  'simon-min*':
    - openldap.extras
    - openldap.main
  'simon-tst*':
    - openldap.main
  't*':
    - ram_initial.main
