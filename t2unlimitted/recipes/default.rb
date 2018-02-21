#
# Cookbook:: t2unlimitted
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

results = node['t2unlimitted']['status']

file results do
    action :delete
end

template '/home/ec2-user/t2.unlimitted.sh' do
  source 't2unlimitted.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :location => node['t2unlimitted']['status']
  )
end

execute 'configure_t2unlimitted' do
  command '/bin/bash /home/ec2-user/t2.unlimitted.sh'
end

ruby_block "Results" do
    only_if { ::File.exists?(results) }
    block do
        print "\n"
        File.open(results).each do |line|
            print line
        end
    end
end
