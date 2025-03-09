
# Replace 'http://localhost:8080' with your HugeGraph server address
HUGEGRAPH_URL="http://localhost:8080"
GRAPH_NAME="hugegraph"

# Function to create vertices
create_vertex() {
  local payload="$1"
  local description="$2"
  echo "Creating $description..."
  curl -X POST \
    "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices" \
    -H 'Content-Type: application/json' \
    -d "$payload"
}


# Function to verify vertex creation
verify_vertex() {
  local label="$1"
  local property="$2"
  local value="$3"
  echo "Verifying $label with $property = $value..."
  RESPONSE=$(curl -s -X GET "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices?label=$label&property=$value"|gunzip)
  echo $RESPONSE

  if echo "$RESPONSE" | grep -q "\"vertices\": \[]"; then
    echo "ERROR: $label vertex not found!"
    echo "Response from HugeGraph:"
    echo "$RESPONSE"
    exit 1
  else
    echo "$label vertex created successfully."
  fi
}
# 1. Create Document Vertex
DOCUMENT_PATH="$1"
DOCUMENT_CONTENT=$(cat $1)
DOCUMENT_HASH=$(cat $1 | xxh64sum | awk '{print $1}')
DOCUMENT_SIZE=$(echo -n "$DOCUMENT_CONTENT" | wc -c)

DOCUMENT_PAYLOAD='{
  "label": "document",
  "properties": {
    "document_hash": "'"$DOCUMENT_HASH"'",
    "document_path": "'"$DOCUMENT_PATH"'",
    "document_size": '"$DOCUMENT_SIZE"',
    "document_type": "article",
    "title": "Test Paper",
    "abstract": "This is an abstract."
  }
}'
create_vertex "$DOCUMENT_PAYLOAD" "document vertex"
verify_vertex "document" "document_hash" "$DOCUMENT_HASH"
