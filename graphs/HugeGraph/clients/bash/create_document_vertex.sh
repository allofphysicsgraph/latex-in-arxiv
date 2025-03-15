# Replace 'http://localhost:8080' with your HugeGraph server address
HUGEGRAPH_URL="http://localhost:8080"
GRAPH_NAME="hugegraph"

# 1. Create Document Vertex
DOCUMENT_PATH="$1"
DOCUMENT_CONTENT=$(cat $1)
DOCUMENT_HASH=$(cat $1 | xxh64sum | awk '{print $1}')
DOCUMENT_SIZE=$(echo -n "$DOCUMENT_CONTENT" | wc -c)
DOCUMENT_NAME=$(echo $DOCUMENT_PATH|rev|cut -d '/' -f1|rev)
DOCUMENT_PATH_PREFIX=$(echo $DOCUMENT_PATH|rev|cut -d '/' -f2-|rev)
bash get_abstract.sh $DOCUMENT_PATH_PREFIX $DOCUMENT_NAME
mv tf_idf abstract_tf_idf
bash get_title.sh $DOCUMENT_PATH_PREFIX $DOCUMENT_NAME
DOCUMENT_ABSTRACT=$(cat abstract_tf_idf)
DOCUMENT_TITLE=$(cat tf_idf)
echo $DOCUMENT_TITLE
DOCUMENT_PAYLOAD='{
  "label": "document",
  "properties": {
    "document_hash": "'"$DOCUMENT_HASH"'",
    "document_path": "'"$DOCUMENT_PATH"'",
    "document_size": '"$DOCUMENT_SIZE"',
    "document_type": "article",
    "title": "'"$DOCUMENT_TITLE"'",
    "abstract": "'"$DOCUMENT_ABSTRACT"'"
  }
}'
echo $DOCUMENT_PAYLOAD > test.json
if [[ $(jsonlint-php test.json |grep '^Valid JSON'  -c) -eq 1 ]];  then echo ok; mv test.json valid.json;
cat valid.json |bash client.sh --host http://127.0.0.1:8080 create8 graph=hugegraph --content-type json -
fi
