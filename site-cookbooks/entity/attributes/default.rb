#default['jekyll']['deploy_directory'] = '/home/deploy/applications/www/jekyll'
#default['jekyll']['repository'] = 'https://github.com/fooforge/fooforge.com.git'
#default['jekyll']['reference'] = 'master'
#default['jekyll']['user'] = 'deploy'
#default['jekyll']['group'] = 'deploy'
#default['jekyll']['access_rights'] = 0755
#
#default['jekyll']['domain_name'] = node['ninjacircles.com']
#
#default['jekyll']['packages'] = ['curl', 'libcurl4-openssl-dev', 'python-pygments']
#default['jekyll']['options'] = ['rdiscount', 'pygments']
#
#default['jekyll']['gem']['source'] = 'https://rubygems.org/'
#default['jekyll']['gem']['binary'] = nil
#
#default['jekyll']['rbenv']['activated'] = true
#default['jekyll']['rbenv']['version'] = '1.9.3-p194'




# Attributes applied if the node doesn't have it set already.
#default_attributes(
#    'jekyll' => {
#        'deploy_directory' => '/var/www/fooforge.com',
#        'repository' => 'https://github.com/fooforge/fooforge.com.gi',
#        'user' => 'some_user',
#        'group' => 'some_group',
#        'domain_name' => 'fooforge.com',
#        'packages' => ['curl', 'libcurl4-openssl-dev', 'python-pygments'],
#        'options' => ['rdiscount', 'pygments'],
#        'rbenv' => {
#            'activated' => true,
#        }
#    }
#)
# Attributes applied no matter what the node has set already.
#override_attributes(
#)