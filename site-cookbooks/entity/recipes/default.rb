package "cron"

include_recipe "cron"




directory node.app.web_dir do
  owner node.user.name
  mode "0755"
  recursive true
end

directory "#{node.app.web_dir}/public" do
  owner node.user.name
  mode "0755"
  recursive true
end

directory "#{node.app.web_dir}/logs" do
  owner node.user.name
  mode "0755"
  recursive true
end

template "#{node.nginx.dir}/sites-available/#{node.app.name}.conf" do
  source "nginx.conf.erb"
  mode "0644"
end

nginx_site "#{node.app.name}.conf"

cookbook_file "#{node.app.web_dir}/public/index.html" do
  source "index.html"
  mode 0755
  owner node.user.name
end




node[:base_packages].each do |pkg|
    package pkg do
        :upgrade
    end
end






# Upstart

cookbook_file "/etc/init/django_instance-gunicorn.conf" do
  source "django_instance-gunicorn.conf"
  owner "root"
  group "root"
  mode 0644
end

service "django_instance-gunicorn" do
  provider Chef::Provider::Service::Upstart
  enabled true
  running true
  supports :restart => true, :reload => true, :status => true
  action [:enable, :start]
end


service "nginx" do
  action :restart
end

service "django_instance-gunicorn" do
  action :restart
end



# Problem with this is that it is not idempotent
cron "daily-logwatch" do
  minute 0
  hour 23
  command "/usr/sbin/logwatch --detail high"
  mailto "indika.piyasena@gmail.com"
  user "root"
  action :create
end

cron "python-gumtree-scraper" do
  minute 5
  hour 23
  command "/home/deploy/applications/scrape.sh"
  user "deploy"
  action :create
end

cron "python-gumtree-scraper-2" do
  minute 7
  hour 11
  command "/home/deploy/applications/scrape.sh"
  user "deploy"
  action :create
end
