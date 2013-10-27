node.default['rbenv']['user_installs'] = [
    { 'user'    => 'deploy',
      'rubies'  => ['1.9.3-p0'],
      'global'  => '1.9.3-p0',
      'gems'    => {
          '1.9.3-p0'    => [
              { 'name'    => 'bundler',
                'version' => '1.1.rc.5'
              },
              { 'name'    => 'rake' }
          ],
      }
    }
]


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