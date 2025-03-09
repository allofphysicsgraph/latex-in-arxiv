HUGEGRAPH_URL="http://localhost:8080"
GRAPH_NAME="hugegraph"

# Create file vertices
echo "Creating file vertices..."
file_hash=$(sha256sum $1|cut -d ' ' -f1)
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices" \
  -H 'Content-Type: application/json' \
  -d '{
    "label": "file",
    "properties": {
      "file_path": "'$1'",
      "file_hash": "'$file_hash'"
    }
  }' 
