#!/bin/bash

# Replace 'http://localhost:8080' with your HugeGraph server address
HUGEGRAPH_URL="http://localhost:8080"
GRAPH_NAME="hugegraph"

# List vertices
echo "Listing vertices..."
curl -X GET \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices" | gunzip | jq .

# List edges
echo "Listing edges..."
curl -X GET \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/edges" | gunzip |jq .

echo "Graph retrieval complete!"
