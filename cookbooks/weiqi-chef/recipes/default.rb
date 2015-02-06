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

bash "install node versions" do
  user "vagrant"
  code "source /home/vagrant/.nvm/nvm.sh && nvm install #{node[:weiqi][:nodejs_version]}"
  not_if "source /home/vagrant/.nvm/nvm.sh && nvm list | grep #{node[:weiqi][:nodejs_version]}"
end

bash "use vagrant's interactive env" do
  user "vagrant"
  code "echo 'source ~/interactive_config.sh' >> /home/vagrant/.bashrc"
  not_if "grep 'interactive_config.sh' /home/vagrant/.bashrc"
end

template "/home/vagrant/interactive_config.sh" do
  source "interactive_config.sh.erb"
  mode '0644'
  owner 'vagrant'
  group 'vagrant'
end

# setup selenium and webdriver

bash "install mocha" do
  user "vagrant"
  code "/home/vagrant/.nvm/v#{node[:weiqi][:nodejs_version]}/bin/npm install -g mocha"
end

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
