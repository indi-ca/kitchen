#
# Cookbook Name:: ninjacircles
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"




packages = ['curl', 'libcurl4-openssl-dev', 'python-pygments']
options = ['rdiscount', 'pygments']

r_version = '1.9.3-p194'


virtual_env_home = '/home/deploy/.virtualenvs'
application_home = '/home/deploy/applications'
target_dir = 'jekyll_blog'


#rbenv[:group_users] = ['deploy']
rbenv_ruby r_version

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end


rbenv_gem 'bundler' do
  ruby_version r_version
  action :upgrade
end


directory "#{application_home}/#{target_dir}" do
  owner "deploy"
  group "deploy"
  mode 0755

  recursive true
end



git node['jekyll']['deploy_directory'] do
  repository node['jekyll']['repository']
  reference node['jekyll']['reference']
  user node['jekyll']['user']
  group node['jekyll']['group']

  action :sync
end



# Build command with options if defined for blog generation
unless node['jekyll']['options'].empty?
  options = node['jekyll']['options'].each { |opt| opt.prepend('--')}
  options = options.join(' ')
  jekyll_command = "jekyll #{options}"
else
  jekyll_command = "jekyll"
end

unless node['jekyll']['rbenv']['activated']
  execute 'Deploy Jekyll blog' do
    cwd node['jekyll']['deploy_directory']

    command "bundle install && #{jekyll_command}"
    action :run
  end
else
  #rbenv_script 'Deploy Jekyll blog' do
  #  rbenv_version node['jekyll']['rbenv']['version']
  #  root_path node['rbenv']['root_path']
  #  cwd node['jekyll']['deploy_directory']
  #
  #  code %{ bundle install && source /etc/profile.d/rbenv.sh && #{jekyll_command} }
  #end

  rbenv_execute 'Deploy Jekyll blog' do
    ruby_version node['jekyll']['rbenv']['version']
    cwd node['jekyll']['deploy_directory']

    command %{ bundle install }
  end

end