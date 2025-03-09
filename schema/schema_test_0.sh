#!/bin/bash

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
  RESPONSE=$(curl -s -X GET "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/graph/vertices?label=$label&$property=$value"|gunzip)
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
DOCUMENT_PATH="test_paper.tex"
DOCUMENT_CONTENT="\\documentclass{article}\n\\title{Test Paper}\n\\author{John Doe}\n\\begin{document}\n\\maketitle\n\\begin{abstract}\nThis is an abstract.\n\\end{abstract}\n\\section{Introduction}\nThis is an introduction. We cite \\cite{ref1}.\n\\section{Math}\nThe equation is:\n\\[\n  \\frac{1 + \\sqrt{x}}{y}\n\\]\n\\bibliographystyle{plain}\n\\bibliography{references}\n\\end{document}"
DOCUMENT_HASH=$(echo -n "$DOCUMENT_CONTENT" | xxh64sum | awk '{print $1}')
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


# 2. Create Author Vertex
AUTHOR_NAME="John Doe"
AUTHOR_HASH=$(echo -n "$AUTHOR_NAME" | xxh64sum | awk '{print $1}')
AUTHOR_PAYLOAD='{
  "label": "author",
  "properties": {
    "author_hash": "'"$AUTHOR_HASH"'",
    "author_name": "'"$AUTHOR_NAME"'",
    "author_affiliation": "Some University",
    "author_email": "test@gmail.com"
  }
}'
create_vertex "$AUTHOR_PAYLOAD" "author vertex"
verify_vertex "author" "author_hash" "$AUTHOR_HASH"

# 3. Create Reference Vertex
REFERENCE_ID="ref1"
REFERENCE_HASH=$(echo -n "$REFERENCE_ID" | xxh64sum | awk '{print $1}')
REFERENCE_PAYLOAD='{
  "label": "reference",
  "properties": {
    "reference_hash": "'"$REFERENCE_HASH"'",
    "reference_id": "'"$REFERENCE_ID"'",
    "reference_type": "article",
    "reference_title": "A Great Paper",
    "reference_authors": "Jane Smith",
    "reference_journal": "Journal of Awesome",
    "reference_year": 2023,
    "reference_volume": "vol",
    "reference_pages": "pg",
    "reference_doi": "doi"
  }
}'

create_vertex "$REFERENCE_PAYLOAD" "reference vertex"
verify_vertex "reference" "reference_hash" "$REFERENCE_HASH"

echo "All tests completed successfully!"
