sudo -u postgres -H -- psql -c "create user latexinarxiv with password '3e9f91486fa99d2fe94b2494baf5f2effe0791b6b040394cef4fbe1cefcada29'" 
sudo -u postgres -H -- psql -c 'create database latexinarxiv with owner latexinarxiv;' 
sudo -u postgres -H -- psql -c 'create schema api;'
sudo -u postgres -H -- psql -c 'alter schema api owner to latexinarxiv;'
sudo -u postgres -H -- psql -c 'create role web_anon nologin;'
sudo -u postgres -H -- psql -c 'grant usage on schema api to web_anon;'
sudo -u postgres -H -- psql -c "create role authenticator noinherit login password 'mysecretpassword';"
sudo -u postgres -H -- psql -c 'grant web_anon to authenticator;'

sudo -u postgres -H -- psql latexinarxiv <db_schema
