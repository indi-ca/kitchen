virtual_env_home = '/home/deploy/.virtualenvs'
application_home = '/home/deploy/applications'


target_dir = 'dropbox_daemon'

directory "#{application_home}/#{target_dir}" do
  owner "deploy"
  group "deploy"
  mode 0755

  recursive true
end


bash 'download-daemon' do
  user 'deploy'
  cwd "#{application_home}/#{target_dir}"
  code <<-EOH
    wget -O dropbox.py "https://www.dropbox.com/download?dl=packages/dropbox.py"
    chown deploy:deploy dropbox.py
    chmod +x dropbox.py
  EOH
  action :run
end