#!/bin/bash

# Perform the scape
cd /home/deploy/applications/python_gumtree_scraper

# Refresh the exclusion list
rm exclusion_list.txt
wget https://dl.dropboxusercontent.com/u/8261661/jBl3liuvOXDpvhYB/gt/exclusion_list.txt

/home/deploy/.virtualenvs/python_gumtree_scraper/bin/python /home/deploy/applications/python_gumtree_scraper/gumtree_scraper.py

rm /home/deploy/static/*.html
rm -rf /home/deploy/static/stylesheets

cp /home/deploy/applications/python_gumtree_scraper/output/*.html /home/deploy/static
cp -R /home/deploy/applications/python_gumtree_scraper/output/stylesheets /home/deploy/static

