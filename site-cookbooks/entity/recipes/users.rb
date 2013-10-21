

secret = Chef::EncryptedDataBagItem.load_secret("/root/.chef/motion_secret")
admin_repos_bag = Chef::EncryptedDataBagItem.load("admin", "repositories", secret)
entity_users_bag = Chef::EncryptedDataBagItem.load("entity", "users", secret)



bucket_url = "https://#{admin_repos_bag['bitbucket']['user_name']}:#{admin_repos_bag['bitbucket']['password']}@bitbucket.org/indika/oh-my-zsh.git"
puts bucket_url




entity_users_bag['users'].each do |user_item|

  user_account user_item['user_name'] do
    comment user_item['comment']
    ssh_keys user_item['ssh_key']
    ssh_keygen false
    home "/home/#{user_item['user_name']}"
    shell '/bin/zsh'
  end

  cookbook_file "/home/#{user_item['user_name']}/.zshrc" do
    source "zshrc.deploy"
    mode 0755
    owner user_item['user_name']
    group user_item['user_name']
  end

  git "/home/#{user_item['user_name']}/.oh-my-zsh" do
    repository bucket_url
    reference "master"
    action :sync
    user user_item['user_name']
    #group "deploy"
  end

end

