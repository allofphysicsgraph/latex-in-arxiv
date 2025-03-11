cat valid.json |bash client.sh --host http://127.0.0.1:8080 create8 graph=hugegraph --content-type json -
#if [[ $(jsonlint-php valid.json |grep '^Valid JSON'  -c) -eq 1 ]];  then echo ok;fi
