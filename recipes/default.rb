include_recipe 'yum-epel'

yum_package 'clamav'

yum_package 'clamav-update' unless node["platform_version"].to_f < 7.0 

user 'clam' do
	system true
	shell "/bin/bash"
	action :create
end

directory "/var/log/clamav" do
	owner 'clam'
	action :create
end

# template "/etc/freshclam.conf" do
#   source "freshclam.conf.erb"
#   action :create
# end

file "/var/log/clamav/freshclam.log" do
	owner 'clam'
	action :create_if_missing
end

cron "clam database update" do
	user 'clam'
  	minute "0"
  	hour "0"
  	weekday "1"
  	command "/usr/bin/freshclam --quiet"
end

file "/var/log/clamav/clamscan.log" do
	owner 'clam'
	action :create_if_missing
end

cron "clamscan" do
	user 'clam'
	minute "0"
	hour "0"
	weekday "1"
	command "/usr/bin/clamscan -i --exclude-dir=^/sys --exclude-dir=^/dev --exclude-dir=^/proc --quiet -l /var/log/clamav/clamscan.log -r /"
end