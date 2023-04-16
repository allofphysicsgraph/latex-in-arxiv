sudo -u postgres -H -- psql -c "create user latexinarxiv with password '3e9f91486fa99d2fe94b2494baf5f2effe0791b6b040394cef4fbe1cefcada29'" 
sudo -u postgres -H -- psql -c 'create database latexinarxiv with owner latexinarxiv;' 
sudo -u postgres -H -- psql -d latexinarxiv -f db_init.sql 
