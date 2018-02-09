name                'tomcat_test'
maintainer          'Andres Torres'
maintainer_email    'andres.torresduran@gmail.com'
license             'Public domain'
description         'Install Tomcat'
version             '0.1.0'
issues_url 'https://gitlab.com/auxis/AndresTorres/issues' if respond_to?(:issues_url)
source_url 'https://gitlab.com/auxis/AndresTorres/' if respond_to?(:source_url)
chef_version '>= 2.4.17' if respond_to?(:chef_version)
supports %i[redhat centos]
license 'Apache-2.0'
depends 'tomcat'
depends 'java'
