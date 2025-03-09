#!/bin/bash

# Replace 'http://localhost:8080' with your HugeGraph server address
HUGEGRAPH_URL="http://localhost:8080"
GRAPH_NAME="hugegraph"

# Function to create schema elements
create_schema_element() {
  local endpoint="$1"
  local payload="$2"
  local description="$3"
  echo "Creating $description..."
  curl -X POST \
    "$HUGEGRAPH_URL/graphs/$GRAPH_NAME/schema/$endpoint" \
    -H 'Content-Type: application/json' \
    -d "$payload" #Removed | jq .
}

# Create property keys
create_schema_element "propertykeys" '{
    "name": "document_path",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key document_path"
create_schema_element "propertykeys" '{
    "name": "document_hash",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key document_hash"
create_schema_element "propertykeys" '{
    "name": "document_size",
    "data_type": "LONG",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key document_size"
create_schema_element "propertykeys" '{
    "name": "document_type",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key document_type"
create_schema_element "propertykeys" '{
    "name": "title",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key title"
create_schema_element "propertykeys" '{
    "name": "abstract",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key abstract"
create_schema_element "propertykeys" '{
    "name": "element_id",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key element_id"
create_schema_element "propertykeys" '{
    "name": "element_hash",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key element_hash"
create_schema_element "propertykeys" '{
    "name": "element_type",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key element_type"
create_schema_element "propertykeys" '{
    "name": "element_name",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key element_name"
create_schema_element "propertykeys" '{
    "name": "element_content",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key element_content"
create_schema_element "propertykeys" '{
    "name": "math_type",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key math_type"
create_schema_element "propertykeys" '{
    "name": "equation_number",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key equation_number"
create_schema_element "propertykeys" '{
    "name": "symbol_type",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key symbol_type"
create_schema_element "propertykeys" '{
    "name": "operator_type",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key operator_type"
create_schema_element "propertykeys" '{
    "name": "package_hash",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key package_hash"
create_schema_element "propertykeys" '{
    "name": "package_name",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key package_name"
create_schema_element "propertykeys" '{
    "name": "package_version",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key package_version"
create_schema_element "propertykeys" '{
    "name": "package_description",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key package_description"
create_schema_element "propertykeys" '{
    "name": "macro_hash",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key macro_hash"
create_schema_element "propertykeys" '{
    "name": "macro_name",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key macro_name"
create_schema_element "propertykeys" '{
    "name": "macro_definition",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key macro_definition"
create_schema_element "propertykeys" '{
    "name": "macro_description",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key macro_description"
create_schema_element "propertykeys" '{
    "name": "element_order",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key element_order"
create_schema_element "propertykeys" '{
    "name": "nesting_level",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key nesting_level"
create_schema_element "propertykeys" '{
    "name": "child_order",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key child_order"
create_schema_element "propertykeys" '{
    "name": "author_hash",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key author_hash"
create_schema_element "propertykeys" '{
    "name": "author_name",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key author_name"
create_schema_element "propertykeys" '{
    "name": "author_affiliation",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key author_affiliation"
create_schema_element "propertykeys" '{
    "name": "author_email",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key author_email"
create_schema_element "propertykeys" '{
    "name": "reference_hash",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_hash"
create_schema_element "propertykeys" '{
    "name": "reference_id",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_id"
create_schema_element "propertykeys" '{
    "name": "reference_type",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_type"
create_schema_element "propertykeys" '{
    "name": "reference_title",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_title"
create_schema_element "propertykeys" '{
    "name": "reference_authors",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_authors"
create_schema_element "propertykeys" '{
    "name": "reference_journal",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_journal"
create_schema_element "propertykeys" '{
    "name": "reference_year",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_year"
create_schema_element "propertykeys" '{
    "name": "reference_volume",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_volume"
create_schema_element "propertykeys" '{
    "name": "reference_pages",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_pages"
create_schema_element "propertykeys" '{
    "name": "reference_doi",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key reference_doi"
  create_schema_element "propertykeys" '{
    "name": "citation_text",
    "data_type": "TEXT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key citation_text"
  create_schema_element "propertykeys" '{
    "name": "bib_entry_order",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key bib_entry_order"
   create_schema_element "propertykeys" '{
    "name": "element_line_number",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key element_line_number"
   create_schema_element "propertykeys" '{
    "name": "element_char_offset",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key element_char_offset"
    create_schema_element "propertykeys" '{
    "name": "child_line_number",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key child_line_number"
   create_schema_element "propertykeys" '{
    "name": "child_char_offset",
    "data_type": "INT",
    "cardinality": "SINGLE",
    "aggregate_type": "NONE",
    "write_type": "OLTP",
    "user_data": {}
  }' "property key child_char_offset"

# Create vertex labels
create_schema_element "vertexlabels" '{
    "name": "document",
    "id_strategy": "PRIMARY_KEY",
    "primary_keys": ["document_hash"],
    "properties": [
      "document_hash",
      "document_path",
      "document_size",
      "document_type",
      "title",
      "abstract"
    ],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "vertex label document"
create_schema_element "vertexlabels" '{
    "name": "element",
    "id_strategy": "PRIMARY_KEY",
    "primary_keys": ["element_hash"],
    "properties": [
      "element_hash",
      "element_id",
      "element_type",
      "element_name",
      "element_content",
      "math_type",
      "equation_number",
      "symbol_type",
      "operator_type"
    ],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "vertex label element"
create_schema_element "vertexlabels" '{
    "name": "package",
    "id_strategy": "PRIMARY_KEY",
    "primary_keys": ["package_hash"],
    "properties": [
      "package_hash",
      "package_name",
      "package_version",
      "package_description"
    ],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "vertex label package"
create_schema_element "vertexlabels" '{
    "name": "macro",
    "id_strategy": "PRIMARY_KEY",
    "primary_keys": ["macro_hash"],
    "properties": [
      "macro_hash",
      "macro_name",
      "macro_definition",
      "macro_description"
    ],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "vertex label macro"
create_schema_element "vertexlabels" '{
    "name": "author",
    "id_strategy": "PRIMARY_KEY",
    "primary_keys": ["author_hash"],
    "properties": [
      "author_hash",
      "author_name",
      "author_affiliation",
      "author_email"
    ],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "vertex label author"
create_schema_element "vertexlabels" '{
    "name": "reference",
    "id_strategy": "PRIMARY_KEY",
    "primary_keys": ["reference_hash"],
    "properties": [
      "reference_hash",
      "reference_id",
      "reference_type",
      "reference_title",
      "reference_authors",
      "reference_journal",
      "reference_year",
      "reference_volume",
      "reference_pages",
      "reference_doi"
    ],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "vertex label reference"

# Create edge labels
create_schema_element "edgelabels" '{
    "name": "contains",
    "source_label": "document",
    "target_label": "element",
    "frequency": "SINGLE",
    "properties": ["element_order", "element_line_number", "element_char_offset"],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "edge label contains"
create_schema_element "edgelabels" '{
    "name": "includes",
    "source_label": "element",
    "target_label": "element",
    "properties": ["nesting_level", "child_order", "child_line_number", "child_char_offset"],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "edge label includes"
create_schema_element "edgelabels" '{
    "name": "uses_package",
    "source_label": "document",
    "target_label": "package",
    "properties": [],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "edge label uses_package"
create_schema_element "edgelabels" '{
    "name": "defines_macro",
    "source_label": "document",
    "target_label": "macro",
    "properties": [],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "edge label defines_macro"
create_schema_element "edgelabels" '{
    "name": "calls_macro",
    "source_label": "element",
    "target_label": "macro",
    "properties": [],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "edge label calls_macro"
create_schema_element "edgelabels" '{
    "name": "authored_by",
    "source_label": "document",
    "target_label": "author",
    "properties": [],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "edge label authored_by"
create_schema_element "edgelabels" '{
    "name": "cites",
    "source_label": "element",
    "target_label": "reference",
    "properties": ["citation_text"],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "edge label cites"
create_schema_element "edgelabels" '{
    "name": "in_bibliography",
    "source_label": "document",
    "target_label": "reference",
    "properties": ["bib_entry_order"],
    "nullable_keys": [],
    "enable_label_index": true,
    "user_data": {}
  }' "edge label in_bibliography"

# Create index labels
#Remove index creation when primary key is already the property.
create_schema_element "indexlabels" '{
    "name": "element_type_index",
    "base_type": "VERTEX_LABEL",
    "base_value": "element",
    "index_type": "SECONDARY",
    "fields": ["element_type"],
    "user_data": {}
  }' "index label element_type_index"
create_schema_element "indexlabels" '{
    "name": "math_type_index",
    "base_type": "VERTEX_LABEL",
    "base_value": "element",
    "index_type": "SECONDARY",
    "fields": ["math_type"],
    "user_data": {}
  }' "index label math_type_index"
create_schema_element "indexlabels" '{
    "name": "operator_type_index",
    "base_type": "VERTEX_LABEL",
    "base_value": "element",
    "index_type": "SECONDARY",
    "fields": ["operator_type"],
    "user_data": {}
  }' "index label operator_type_index"
create_schema_element "indexlabels" '{
    "name": "symbol_type_index",
    "base_type": "VERTEX_LABEL",
    "base_value": "element",
    "index_type": "SECONDARY",
    "fields": ["symbol_type"],
    "user_data": {}
  }' "index label symbol_type_index"

echo "Schema creation complete!"
