current_dir=$(pwd)
echo wait until complete 
ls|grep arX|grep -i tar$|xargs -i tar -xf "{}" 
while read f;do cd $f;cp  $current_dir/2.sh . ;   bash 2.sh;cd ../;done < <(find . -maxdepth 1 -type d |grep '^\.\/\d{4}' -P)
rm *.tar
