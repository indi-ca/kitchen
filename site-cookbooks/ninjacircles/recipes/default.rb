#
# Cookbook Name:: ninjacircles
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

application_home = '/home/deploy/applications'
target_dir = "ninjacircles"


unless node['jekyll']['packages'].empty?
  node['jekyll']['packages'].each do |pkg|
    package pkg do
      action :upgrade
    end
  end
end

#unless node['jekyll']['rbenv']['activated']
#  gem_package 'bundler' do
#    source node['jekyll']['gem']['source']
#    gem_binary node['jekyll']['gem']['binary']
#    action :install
#  end
#else
#  rbenv_gem 'bundler' do
#    rbenv_version node['jekyll']['rbenv']['version']
#    action :upgrade
#  end
#end

directory node['jekyll']['deploy_directory'] do
  owner node['jekyll']['user']
  group node['jekyll']['group']
  mode node['jekyll']['access_rights']

  recursive true
end





git node['jekyll']['deploy_directory'] do
  repository node['jekyll']['repository']
  reference node['jekyll']['reference']
  user node['jekyll']['user']
  group node['jekyll']['group']

  action :checkout
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

  rbenv_script 'Deploy Jekyll blog' do
    rbenv_version node['jekyll']['rbenv']['version']
    root_path node['rbenv']['root_path']
    cwd node['jekyll']['deploy_directory']

    code <<-EOH
      touch findme.touchfile
      bundle install
    EOH

    #code %{ bundle install && source /etc/profile.d/rbenv.sh && #{jekyll_command} }
    #code %{ bundle install &&  #{jekyll_command} }
  end
end


bash 'post-init' do
  user 'deploy'
  cwd node['jekyll']['deploy_directory']
  code <<-EOH
    git config receive.denyCurrentBranch warn
    git checkout publish
    bundle install
  EOH
  action :run
end


template_source = "post-update.erb"
template_name = "#{application_home}/#{target_dir}/.git/hooks/post-update"

template template_name do
  source template_source
  owner  "deploy"
  group  "deploy"
  mode   0755
  variables(
      :application_home => application_home,
      :target_dir => target_dir
  )
end
