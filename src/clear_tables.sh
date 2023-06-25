cp clear_tables.sql /dev/shm/
 sudo -u postgres -H -- psql -d latexinarxiv -f /dev/shm/clear_tables.sql
