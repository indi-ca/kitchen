#!/bin/bash

printf "Bootstrapping Node"


# Should recreate the directory if it does not exist
mkdir ~/.chef
ssh root@motion -p 49690 "mkdir /root/.chef"


# Now SCP this file to destination machine

scp -P 49690 bootstrap_motion.sh root@motion:/root/bootstrap_motion.sh
scp -P 49690 /Users/indika/.ssh/id_rsa_motion_bucket root@motion:/root/.ssh



# Regenerate data bags
printf "Regenerating data bags"
rm ~/.chef/motion_secret
openssl rand -base64 512 > ~/.chef/motion_secret

sh prepare_data_bags.sh
scp -P 49690 ~/.chef/motion_secret root@motion:/root/.chef/motion_secret
