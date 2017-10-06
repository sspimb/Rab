base:
 'simonlda*':
   - ansible.users
   - ansible.groups
   - ansible.ansible
   - ldapclients.dev
 'simon-min*':
   - ldapclients.prod
   - openldap.global
 'simon-tst*':
   - ldapclients.prod
   - openldap.global
 't*':
   - ldapclients.prod
   - ram_initial.prod
   - openldap.global
