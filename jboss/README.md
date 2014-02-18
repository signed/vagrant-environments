http://stackoverflow.com/questions/10752631/how-to-install-rvm-on-vagrant-ubuntu-12-04-lts-using-puppet

http://mestachs.wordpress.com/tag/veewee/

http://www.example42.com/?q=understandExample42PuppetModules
good read on how to structure your own modules


http://chrisyallop.com/2012/04/customising-a-vagrant-box-with-veewee/

# Vagrant plugins #
https://github.com/fgrehm/vagrant-cachier


puppet apply --verbose --debug --modulepath '/etc/puppet/modules:/tmp/vagrant-puppet/modules-0:/tmp/vagrant-puppet/modules-1' site.pp --detailed-exitcodes

# Still ToDo #
## The init script for jboss 7 does not properly report the status of the running service ##
http://stackoverflow.com/questions/6880902/start-jboss-7-as-a-service-on-linux