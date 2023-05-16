sudo -u postgres -H -- psql -c "create user latexinarxiv with password '3e9f91486fa99d2fe94b2494baf5f2effe0791b6b040394cef4fbe1cefcada29'" 
sudo -u postgres -H -- psql -c 'create database latexinarxiv with owner latexinarxiv;' 
cp db_init.sql /dev/shm/
cp db_schema /dev/shm/
cp data/equation.csv /dev/shm/
cp data/title.csv /dev/shm/
cp data/author.csv /dev/shm/
cp data/cite.csv /dev/shm/
cp data/section.csv /dev/shm/
sudo -u postgres -H -- psql -d latexinarxiv -f /dev/shm/db_init.sql 
sudo -u postgres -H -- psql -d latexinarxiv -f /dev/shm/db_schema 
sudo -u postgres -H -- psql -d latexinarxiv -c "copy equation from '/dev/shm/equation.csv' CSV;" 
sudo -u postgres -H -- psql -d latexinarxiv -c "copy title from '/dev/shm/title.csv' CSV;" 
sudo -u postgres -H -- psql -d latexinarxiv -c "copy author from '/dev/shm/author.csv' CSV;" 
sudo -u postgres -H -- psql -d latexinarxiv -c "copy section from '/dev/shm/section.csv' CSV;" 
sudo -u postgres -H -- psql -d latexinarxiv -c "copy cite from '/dev/shm/cite.csv' CSV;" 

