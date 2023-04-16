
create schema api;
alter schema api owner to latexinarxiv;
create role web_anon nologin;
grant usage on schema api to web_anon;
create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;

