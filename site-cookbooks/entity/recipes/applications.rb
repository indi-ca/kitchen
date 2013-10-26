package 'git'
package 'python'



class PythonApplication
  attr_reader :app_name, :app_url

  def initialize(app_name, app_url)
    @app_name = app_name
    @app_url = app_url
  end

end



directory '/home/deploy/applications' do
  owner 'deploy'
  group 'deploy'
  mode 00775
  action :create
end



applications = []
applications.push(PythonApplication.new 'django_instance', 'https://github.com/indika/django_instance.git')
applications.push(PythonApplication.new 'python_gumtree_scraper', 'https://github.com/indika/python-gumtree-scraper.git')
applications.push(PythonApplication.new 'ninja_circles', 'https://github.com/indika/blog.git')


virtual_env_home = '/home/deploy/.virtualenvs'
application_home = '/home/deploy/applications'



applications.each do |app_item|
  puts app_item.app_name

  git "#{application_home}/#{app_item.app_name}" do
    repository app_item.app_url
    reference "master"
    action :sync
    user "deploy"
    group "deploy"
  end

  puts "git remote at: #{application_home}/#{app_item.app_name}"

  if app_item.app_name == 'ninja_circles'
    template_source = "post-update-ninja_circles.erb"
  else
    template_source = "post-update.erb"
  end

  template_name = "#{application_home}/#{app_item.app_name}/.git/hooks/post-update"

  template template_name do
    source template_source
    owner  "deploy"
    group  "deploy"
    mode   0755
    variables(
      :virtual_env_home => virtual_env_home,
      :application_home => application_home,
      :app_item => app_item
    )
  end

  python_virtualenv "#{virtual_env_home}/#{app_item.app_name}" do
    owner "deploy"
    group "deploy"
    action :create
  end

  pip_file = "#{virtual_env_home}/#{app_item.app_name}/bin/pip"
  requirements_file = "#{application_home}/#{app_item.app_name}/requirements.txt"


  bash 'install-requirements' do
    user 'deploy'
    cwd "#{application_home}/#{app_item.app_name}"
    code <<-EOH
    git config receive.denyCurrentBranch warn
    git checkout master
    #{pip_file} install -r #{requirements_file}
    EOH
    action :run
  end

end


template "#{application_home}/upgrade_requirements.sh" do
  source "upgrade_requirements.sh.erb"
  owner  "deploy"
  group  "deploy"
  mode   "0644"
  variables(
    :virtual_env_home => virtual_env_home,
    :application_home => application_home,
    :application_list => applications
  )
end



directory "/root/scripts" do
  owner "root"
  group "root"
  mode 00644
  action :create
end


# Feeder specific
cookbook_file "#{application_home}/scrape.sh" do
  source "scrape.sh"
  mode 0755
  owner "deploy"
  group "deploy"
end







# Static files directory

#TODO: Make this directory read only
directory '/home/deploy/static' do
  owner 'deploy'
  group 'deploy'
  mode 00755
  action :create
end

