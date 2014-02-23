http://stackoverflow.com/questions/10752631/how-to-install-rvm-on-vagrant-ubuntu-12-04-lts-using-puppet

http://mestachs.wordpress.com/tag/veewee/

http://www.example42.com/?q=understandExample42PuppetModules
good read on how to structure your own modules


http://chrisyallop.com/2012/04/customising-a-vagrant-box-with-veewee/

# Vagrant plugins #
https://github.com/fgrehm/vagrant-cachier


puppet apply --verbose --debug --modulepath '/etc/puppet/modules:/tmp/vagrant-puppet/modules-0:/tmp/vagrant-puppet/modules-1' site.pp --detailed-exitcodes


# JBoss configuration #

[How to define multiple jboss 7 server instances based on the standalone folder using eclipse juno and jboss tools 4.0] (https://community.jboss.org/thread/221012)
[multiple standalone instance Jboss 7] (https://community.jboss.org/thread/235015)
[How to install JBoss AS 7 as a Linux service] (https://community.jboss.org/wiki/HowToInstallJBossAS7AsALinuxService)

# Still ToDo #
## The init script for jboss 7 does not properly report the status of the running service ##
http://stackoverflow.com/questions/6880902/start-jboss-7-as-a-service-on-linux