# Postgres

recreate_databases = true

include_recipe "database::postgresql"


secret = Chef::EncryptedDataBagItem.load_secret("/root/.chef/motion_secret")
databases_repos_bag = Chef::EncryptedDataBagItem.load("entity", "databases", secret)


postgresql_connection_info = {:host => "localhost",
                              :port => node['postgresql']['config']['port'],
                              :username => 'postgres',
                              :password => node['postgresql']['password']['postgres']}




databases_repos_bag['databases'].each do |db_item|

  # Conditionally drop the databases
  if recreate_databases
    postgresql_database db_item['db_name']  do
      connection postgresql_connection_info
      action :drop
    end
  end

  database_user db_item['username'] do
    connection postgresql_connection_info
    password db_item['password']
    provider Chef::Provider::Database::PostgresqlUser
    action :create
  end

  postgresql_database db_item['db_name'] do
    connection postgresql_connection_info
    template 'DEFAULT'
    encoding 'DEFAULT'
    tablespace 'DEFAULT'
    connection_limit '-1'
    owner db_item['username']
    action :create
  end

end


