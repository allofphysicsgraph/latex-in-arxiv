# Replace 'http://localhost:8080' with your HugeGraph server address
HUGEGRAPH_URL="http://localhost:8080"
GRAPH_NAME="hugegraph"

token_hash=$1
token_length=$2
echo $token_hash
echo $token_length
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices" \
  -H 'Content-Type: application/json' \
  -d '{
    "label": "token",
    "properties": {
    "token_hash": "'$token_hash'",
      "token_length": '$token_length',
      "token_latex_type": "math"
    }
  }' 
