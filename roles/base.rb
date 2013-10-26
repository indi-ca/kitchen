name "jekyllblog"
description "Installs the Jekyll blog fooforge.com."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
    #'recipe[jekyll]'
)

# Attributes applied if the node doesn't have it set already.
default_attributes(
    'jekyll' => {
        'deploy_directory' => '/var/www/fooforge.com',
        'repository' => 'https://github.com/fooforge/fooforge.com.git',
        'user' => 'some_user',
        'group' => 'some_group',
        'domain_name' => 'fooforge.com',
        'packages' => ['curl', 'libcurl4-openssl-dev', 'python-pygments'],
        'options' => ['rdiscount', 'pygments'],
        'rbenv' => {
            'activated' => true,
        }
    }
)
# Attributes applied no matter what the node has set already.
#override_attributes(
#)