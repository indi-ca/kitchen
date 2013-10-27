default['jekyll']['deploy_directory'] = '/home/deploy/applications/ninjacircles'
default['jekyll']['repository'] = 'https://github.com/indika/ninjacircles'
default['jekyll']['reference'] = 'publish'
default['jekyll']['user'] = 'deploy'
default['jekyll']['group'] = 'deploy'
default['jekyll']['access_rights'] = 0755

default['jekyll']['domain_name'] = node['ninjacircles.com']

default['jekyll']['packages'] = ['curl', 'libcurl4-openssl-dev', 'python-pygments']
default['jekyll']['options'] = []
#default['jekyll']['options'] = ['rdiscount', 'pygments']

default['jekyll']['gem']['source'] = 'https://rubygems.org/'
default['jekyll']['gem']['binary'] = nil

default['jekyll']['rbenv']['activated'] = true
default['jekyll']['rbenv']['version'] = '1.9.3-p194'

