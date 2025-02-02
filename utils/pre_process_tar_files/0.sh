cp ../run.sh . 
ls ../|head -n 10|grep tar|xargs -i cp ../"{}" .
ls|grep arX|grep -i tar$|xargs -i tar -xf "{}" 
while read f;do cd $f;cp ../run.sh . ;bash run.sh;cd ../;done < <(find . -maxdepth 1  |grep '^\.\/\d{4}' -P)
