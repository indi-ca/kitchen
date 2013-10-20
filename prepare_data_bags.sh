knife solo data bag create admin contact --secret-file /Users/indika/.chef/motion_secret --data-bag-path data_bags -e vim --json-file data_bags_source/admin/contact.json
knife solo data bag create admin repositories --secret-file /Users/indika/.chef/motion_secret --data-bag-path data_bags -e vim --json-file data_bags_source/admin/repositories.json

knife solo data bag create entity users --secret-file /Users/indika/.chef/motion_secret --data-bag-path data_bags -e vim --json-file data_bags_source/entity/users.json
knife solo data bag create entity databases --secret-file /Users/indika/.chef/motion_secret --data-bag-path data_bags -e vim --json-file data_bags_source/entity/databases.json
knife solo data bag create entity misc --secret-file /Users/indika/.chef/motion_secret --data-bag-path data_bags -e vim --json-file data_bags_source/entity/misc.json
