default['jekyll']['deploy_directory'] = '/home/deploy/applications/jekyll_blog'
default['jekyll']['repository'] = 'https://github.com/indika/hpstr-jekyll-theme'
default['jekyll']['reference'] = 'master'
default['jekyll']['user'] = 'deploy'
default['jekyll']['group'] = 'deploy'
default['jekyll']['access_rights'] = 0755

default['jekyll']['domain_name'] = node['ninjacircles.com']

default['jekyll']['packages'] = ['curl', 'libcurl4-openssl-dev', 'python-pygments']
default['jekyll']['options'] = ['rdiscount', 'pygments']

default['jekyll']['gem']['source'] = 'https://rubygems.org/'
default['jekyll']['gem']['binary'] = nil

default['jekyll']['rbenv']['activated'] = true
default['jekyll']['rbenv']['version'] = '1.9.3-p194'


default[:rbenv][:group_users]    = ['deploy']