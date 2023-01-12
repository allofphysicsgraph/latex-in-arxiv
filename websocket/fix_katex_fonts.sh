cp /home/user/x/KaTeX/fonts/"$1" assets/css/fonts/"$(echo $1|tr '-' '_')"

sed -i  $(wc -l conf/websocket.conf|cut -d ' ' -f1)d conf/websocket.conf

echo "route /css/fonts/$(echo $1|tr '-' '_') {" >> conf/websocket.conf
echo "handler asset_serve_$(echo $1|tr '-' '_'|tr '.' '_')" >> conf/websocket.conf
echo '}' >> conf/websocket.conf

echo '}' >> conf/websocket.conf
 sed -i "s/$1/$(echo $1|tr '-' '_')/g" assets/css/katex.min.css
