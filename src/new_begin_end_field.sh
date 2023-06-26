echo "$1" >> fields
cat fields |sort|uniq > fields_v1
cp fields_v1  fields
rm fields_v1

cp equation.rl "$1".rl
sed -i "s/equation/$1/g" "$1".rl
echo ragel "$1".rl >> call_ragel_from_python.sh
echo gcc -fPIC -shared -o "$1".so "$1".c >> call_ragel_from_python.sh
ragel "$1".rl >> call_ragel_from_python.sh
gcc -fPIC -shared -o "$1".so "$1".c >> call_ragel_from_python.sh

sudo -u postgres -H -- psql -d latexinarxiv -c "create table "$1" (filename text,"$1" text,len int);"
sudo -u postgres -H -- psql -d latexinarxiv -c "alter table "$1" owner to latexinarxiv;"

make templates
