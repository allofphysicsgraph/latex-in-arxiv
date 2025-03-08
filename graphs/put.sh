#!/bin/bash

# Replace 'http://localhost:8080' with your HugeGraph server address
HUGEGRAPH_URL="http://localhost:8080"
GRAPH_NAME="hugegraph"

# Create file vertices
echo "Creating file vertices..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices" \
  -H 'Content-Type: application/json' \
  -d '{
    "label": "file",
    "properties": {
      "file_path": "file1.txt",
      "file_hash": "hash123"
    }
  }' | jq .

curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices" \
  -H 'Content-Type: application/json' \
  -d '{
    "label": "file",
    "properties": {
      "file_path": "file2.txt",
      "file_hash": "hash456"
    }
  }' | jq .

# Create token vertices
echo "Creating token vertices..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices" \
  -H 'Content-Type: application/json' \
  -d '{
    "label": "token",
    "properties": {
      "token_hash": "token789",
      "token_length": 5,
      "token_latex_type": "environment"
    }
  }' | jq .

curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices" \
  -H 'Content-Type: application/json' \
  -d '{
    "label": "token",
    "properties": {
      "token_hash": "tokenABC",
      "token_length": 10,
      "token_latex_type": "math"
    }
  }' | jq .

# Create contains edges
echo "Creating contains edges..."

#Set vertex IDs, but remove the lines that try to get them
FILE1_ID="3:file1.txt"
FILE2_ID="3:file2.txt"
TOKEN1_ID="4:token789"
TOKEN2_ID="4:tokenABC"

# check if any of these variables are empty
if [ -z "$FILE1_ID" ] || [ -z "$FILE2_ID" ] || [ -z "$TOKEN1_ID" ] || [ -z "$TOKEN2_ID" ]; then
  echo "ERROR: Could not retrieve vertex IDs.  Make sure the vertices were created successfully."
  exit 1
fi

# Create edges
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/edges" \
  -H 'Content-Type: application/json' \
  -d '{
    "label": "contains",
    "outV": "'"$FILE1_ID"'",
    "inV": "'"$TOKEN1_ID"'",
    "properties": {
      "similarity_score": 0.8,
      "count": 3
    }
  }' | jq .

curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/edges" \
  -H 'Content-Type: application/json' \
  -d '{
    "label": "contains",
    "outV": "'"$FILE2_ID"'",
    "inV": "'"$TOKEN2_ID"'",
    "properties": {
      "similarity_score": 0.9,
      "count": 5
    }
  }' | jq .

echo "Data creation complete!"
