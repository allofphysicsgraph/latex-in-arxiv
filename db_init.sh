sudo -u postgres -H -- psql -c "create user latexinarxiv with password '3e9f91486fa99d2fe94b2494baf5f2effe0791b6b040394cef4fbe1cefcada29'" 
sudo -u postgres -H -- psql -c 'create database latexinarxiv with owner latexinarxiv;' 
cp db_init.sql /dev/shm/
cp db_schema /dev/shm/
cp data/equation.csv

sudo -u postgres -H -- psql -d latexinarxiv -f /dev/shm/db_init.sql 
sudo -u postgres -H -- psql -d latexinarxiv -f /dev/shm/db_schema 
sudo -u postgres -H -- psql -c "copy equation from '/dev/shm/equation.csv' CSV;" 

