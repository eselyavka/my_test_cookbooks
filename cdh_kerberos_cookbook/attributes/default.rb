default['system']['timezone'] = 'Europe/Moscow'
default['cdh_kerberos_cookbook']['java']['repo'] = 'ppa:webupd8team/java'
default['cdh_kerberos_cookbook']['java']['installer'] = 'oracle-java8-installer'
default['cdh_kerberos_cookbook']['java']['jce'] = 'oracle-java8-unlimited-jce-policy'
default['cdh_kerberos_cookbook']['kerberos']['realm'] = 'DEVOPS.EXAMPLE.COM'
default['cdh_kerberos_cookbook']['kerberos']['domain'] = 'localhost'
default['cdh_kerberos_cookbook']['tls']['keystore']['file'] = '/etc/hadoop/conf/keystore.jks'
default['cdh_kerberos_cookbook']['tls']['truststore']['file'] = '/etc/hadoop/conf/truststore.jks'
default['cdh_kerberos_cookbook']['tls']['keystore']['passwd'] = 'changeme'
default['cdh_kerberos_cookbook']['tls']['keystore']['key']['passwd'] = 'changeme'
default['cdh_kerberos_cookbook']['tls']['truststore']['passwd'] = 'changeme'
default['cdh_kerberos_cookbook']['tls']['crt']['ou'] = 'ops'
default['cdh_kerberos_cookbook']['tls']['crt']['o'] = 'ops'
default['cdh_kerberos_cookbook']['tls']['crt']['l'] = 'Saint-Petersburg'
default['cdh_kerberos_cookbook']['tls']['crt']['s'] = 'Saint-Petersburg'
default['cdh_kerberos_cookbook']['tls']['crt']['c'] = 'RU'
