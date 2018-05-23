#
# Cookbook:: t2unlimitted
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

package 'httpd'

template '/var/www/html/index.html' do
  source 'index.html.erb'
  mode '0755'
  owner 'root'
  variables(
   :motd => "this is the message mate!",
   :myenvars => "#{node[:testing][:att1]}"
)
end

service "httpd" do
  action :restart
end
