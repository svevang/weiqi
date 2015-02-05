#
# Cookbook Name:: weiqi-chef
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# udpate our apt-cache
include_recipe 'apt::default'

# utf8 en-US is the default
include_recipe 'locale::default'

package "git"
package "vim"
package "curl"
package "ack-grep"
package "mongodb-server"
package "default-jre"
package "chromium-browser"
package "supervisor"

bash "install nvm" do
  user "vagrant"
  group "vagrant"
  code "git clone https://github.com/creationix/nvm.git /home/vagrant/.nvm && cd /home/vagrant/.nvm && git checkout `git describe --abbrev=0 --tags`"
  not_if "test -e /home/vagrant/.nvm/nvm.sh"
end

bash "setup nvm for interactive shells" do
  user "vagrant"
  code "echo 'source /home/vagrant/.nvm/nvm.sh' >> /home/vagrant/.bashrc"
  not_if "grep nvm.sh /home/vagrant/.bashrc"
end

bash "install node versions" do
  user "vagrant"
  code "source /home/vagrant/.nvm/nvm.sh && nvm install 0.10"
  not_if "source /home/vagrant/.nvm/nvm.sh && nvm list | grep 0.10"
end

bash "use 0.10 node by default" do
  user "vagrant"
  code "echo 'nvm use 0.10' >> /home/vagrant/.bashrc"
  not_if "grep 'nvm use 0.10' /home/vagrant/.bashrc"
end

# setup selenium and webdriver

bash "download the standalone selenium server" do
  user "vagrant"
  cwd "/home/vagrant"
  code "curl -O http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar"
  not_if "test -e selenium-server-standalone*.jar"
end

template "/etc/supervisor/conf.d/supervisor_selenium.conf" do
  source "supervisor_selenium.conf.erb"
  mode '0644'
  owner 'root'
  group 'root'
end

service "supervisor" do
  action :restart
end
