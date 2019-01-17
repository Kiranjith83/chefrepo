#
# Cookbook:: t2unlimitted
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

package 'httpd'


instance = search("aws_opsworks_instance", "self:true").first
Chef::Log.info("********** For instance '#{instance['instance_id']}', the instance's operating system is '#{instance['os']}' **********  the instance's HOSTNAME  is '#{instance['hostname']}'  ")

template '/var/www/html/index.html' do
  source 'index.html.erb'
  mode '0755'
  owner 'root'
  variables(
   :motd => "this is the message mate!",
   :myenvars => "#{node[:testing][:attl]}",
   :myhostname => "#{instance[:hostname]}"
)
end

service "httpd" do
  action :restart
end

