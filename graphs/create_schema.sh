#!/bin/bash

# Replace 'http://localhost:8080' with your HugeGraph server address
HUGEGRAPH_URL="http://localhost:8080"
GRAPH_NAME="hugegraph"

# Create property keys
echo "Creating 'file_path' property key..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/propertykeys" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "file_path",
    "cardinality": "SINGLE",
    "data_type": "TEXT",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }'

echo "Creating 'file_hash' property key..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/propertykeys" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "file_hash",
    "cardinality": "SINGLE",
    "data_type": "TEXT",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }'

echo "Creating 'token_length' property key..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/propertykeys" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "token_length",
    "cardinality": "SINGLE",
    "data_type": "INT",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }'

echo "Creating 'token_hash' property key..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/propertykeys" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "token_hash",
    "cardinality": "SINGLE",
    "data_type": "TEXT",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }'

echo "Creating 'token_latex_type' property key..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/propertykeys" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "token_latex_type",
    "cardinality": "SINGLE",
    "data_type": "TEXT",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }'

echo "Creating 'similarity_score' property key..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/propertykeys" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "similarity_score",
    "cardinality": "SINGLE",
    "data_type": "DOUBLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }'

echo "Creating 'count' property key..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/propertykeys" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "count",
    "cardinality": "SINGLE",
    "data_type": "INT",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }'

# Create vertex labels
echo "Creating 'file' vertex label..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/vertexlabels" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "file",
    "id_strategy": "PRIMARY_KEY",
    "primary_keys": ["file_path"],
    "properties": ["file_path", "file_hash"],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }'

echo "Creating 'token' vertex label..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/vertexlabels" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "token",
    "id_strategy": "PRIMARY_KEY",
    "primary_keys": ["token_hash"],
    "properties": ["token_length", "token_hash", "token_latex_type"],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }'

# Create edge labels
echo "Creating 'contains' edge label..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/edgelabels" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "contains",
    "source_label": "file",
    "target_label": "token",
    "frequency": "SINGLE",
    "properties": ["similarity_score", "count"],
    "sort_keys": [],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }'

# Create index labels
echo "Creating 'file_path_index' index label..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/indexlabels" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "file_path_index",
    "base_type": "VERTEX_LABEL",
    "base_value": "file",
    "index_type": "SECONDARY",
    "fields": ["file_path"],
    "user_data": {}
  }'

echo "Creating 'file_hash_index' index label..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/indexlabels" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "file_hash_index",
    "base_type": "VERTEX_LABEL",
    "base_value": "file",
    "index_type": "SECONDARY",
    "fields": ["file_hash"],
    "user_data": {}
  }'

echo "Creating 'token_hash_index' index label..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/indexlabels" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "token_hash_index",
    "base_type": "VERTEX_LABEL",
    "base_value": "token",
    "index_type": "SECONDARY",
    "fields": ["token_hash"],
    "user_data": {}
  }'

echo "Creating 'token_latex_type_index' index label..."
curl -X POST \
  "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/indexlabels" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "token_latex_type_index",
    "base_type": "VERTEX_LABEL",
    "base_value": "token",
    "index_type": "SECONDARY",
    "fields": ["token_latex_type"],
    "user_data": {}
  }'

echo "Schema creation complete!"
