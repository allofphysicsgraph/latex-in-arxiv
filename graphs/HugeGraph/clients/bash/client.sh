#!/usr/bin/env bash

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !
# ! Note:
# !
# ! THIS SCRIPT HAS BEEN AUTOMATICALLY GENERATED USING
# ! openapi-generator (https://openapi-generator.tech)
# ! FROM OPENAPI SPECIFICATION IN JSON.
# !
# ! Generator version: 7.10.0
# !
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#
# This is a Bash client for HugeGraph RESTful API.
#
# LICENSE:
# 
#
# CONTACT:
# 
#
# MORE INFORMATION:
# 
#

# For improved pattern matching in case statements
shopt -s extglob

###############################################################################
#
# Make sure Bash is at least in version 4.3
#
###############################################################################
if ! ( (("${BASH_VERSION:0:1}" == "4")) && (("${BASH_VERSION:2:1}" >= "3")) ) \
  && ! (("${BASH_VERSION:0:1}" >= "5")); then
    echo ""
    echo "Sorry - your Bash version is ${BASH_VERSION}"
    echo ""
    echo "You need at least Bash 4.3 to run this script."
    echo ""
    exit 1
fi

###############################################################################
#
# Global variables
#
###############################################################################

##
# The filename of this script for help messages
script_name=$(basename "$0")

##
# Map for headers passed after operation as KEY:VALUE
declare -A header_arguments


##
# Map for operation parameters passed after operation as PARAMETER=VALUE
# These will be mapped to appropriate path or query parameters
# The values in operation_parameters are arrays, so that multiple values
# can be provided for the same parameter if allowed by API specification
declare -A operation_parameters

##
# Declare colors with autodetection if output is terminal
if [ -t 1 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    MAGENTA="$(tput setaf 5)"
    CYAN="$(tput setaf 6)"
    WHITE="$(tput setaf 7)"
    BOLD="$(tput bold)"
    OFF="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    MAGENTA=""
    CYAN=""
    WHITE=""
    BOLD=""
    OFF=""
fi

declare -a result_color_table=( "$WHITE" "$WHITE" "$GREEN" "$YELLOW" "$WHITE" "$MAGENTA" "$WHITE" )

##
# This array stores the minimum number of required occurrences for parameter
# 0 - optional
# 1 - required
declare -A operation_parameters_minimum_occurrences
operation_parameters_minimum_occurrences["create:::graph"]=1
operation_parameters_minimum_occurrences["create:::JsonAccess"]=0
operation_parameters_minimum_occurrences["delete:::graph"]=1
operation_parameters_minimum_occurrences["delete:::id"]=1
operation_parameters_minimum_occurrences["get:::graph"]=1
operation_parameters_minimum_occurrences["get:::id"]=1
operation_parameters_minimum_occurrences["list:::graph"]=1
operation_parameters_minimum_occurrences["list:::group"]=0
operation_parameters_minimum_occurrences["list:::target"]=0
operation_parameters_minimum_occurrences["list:::limit"]=0
operation_parameters_minimum_occurrences["update:::graph"]=1
operation_parameters_minimum_occurrences["update:::id"]=1
operation_parameters_minimum_occurrences["update:::JsonAccess"]=0
operation_parameters_minimum_occurrences["get16:::graph"]=1
operation_parameters_minimum_occurrences["get16:::vertex"]=0
operation_parameters_minimum_occurrences["get16:::other"]=0
operation_parameters_minimum_occurrences["get16:::direction"]=0
operation_parameters_minimum_occurrences["get16:::label"]=0
operation_parameters_minimum_occurrences["get16:::max_degree"]=0
operation_parameters_minimum_occurrences["get16:::limit"]=0
operation_parameters_minimum_occurrences["post2:::graph"]=1
operation_parameters_minimum_occurrences["post2:::name"]=1
operation_parameters_minimum_occurrences["post2:::request_body"]=0
operation_parameters_minimum_occurrences["get17:::graph"]=1
operation_parameters_minimum_occurrences["get17:::source"]=0
operation_parameters_minimum_occurrences["get17:::target"]=0
operation_parameters_minimum_occurrences["get17:::direction"]=0
operation_parameters_minimum_occurrences["get17:::label"]=0
operation_parameters_minimum_occurrences["get17:::max_depth"]=0
operation_parameters_minimum_occurrences["get17:::max_degree"]=0
operation_parameters_minimum_occurrences["get17:::skip_degree"]=0
operation_parameters_minimum_occurrences["get17:::with_vertex"]=0
operation_parameters_minimum_occurrences["get17:::with_edge"]=0
operation_parameters_minimum_occurrences["get17:::capacity"]=0
operation_parameters_minimum_occurrences["create1:::graph"]=1
operation_parameters_minimum_occurrences["create1:::JsonBelong"]=0
operation_parameters_minimum_occurrences["delete1:::graph"]=1
operation_parameters_minimum_occurrences["delete1:::id"]=1
operation_parameters_minimum_occurrences["get1:::graph"]=1
operation_parameters_minimum_occurrences["get1:::id"]=1
operation_parameters_minimum_occurrences["list1:::graph"]=1
operation_parameters_minimum_occurrences["list1:::user"]=0
operation_parameters_minimum_occurrences["list1:::group"]=0
operation_parameters_minimum_occurrences["list1:::limit"]=0
operation_parameters_minimum_occurrences["update1:::graph"]=1
operation_parameters_minimum_occurrences["update1:::id"]=1
operation_parameters_minimum_occurrences["update1:::JsonBelong"]=0
operation_parameters_minimum_occurrences["post3:::graph"]=1
operation_parameters_minimum_occurrences["post3:::name"]=1
operation_parameters_minimum_occurrences["post3:::request_body"]=0
operation_parameters_minimum_occurrences["post5:::graph"]=1
operation_parameters_minimum_occurrences["post5:::CountRequest"]=0
operation_parameters_minimum_occurrences["get18:::graph"]=1
operation_parameters_minimum_occurrences["get18:::source"]=0
operation_parameters_minimum_occurrences["get18:::target"]=0
operation_parameters_minimum_occurrences["get18:::direction"]=0
operation_parameters_minimum_occurrences["get18:::label"]=0
operation_parameters_minimum_occurrences["get18:::max_depth"]=0
operation_parameters_minimum_occurrences["get18:::max_degree"]=0
operation_parameters_minimum_occurrences["get18:::capacity"]=0
operation_parameters_minimum_occurrences["get18:::limit"]=0
operation_parameters_minimum_occurrences["post6:::graph"]=1
operation_parameters_minimum_occurrences["post6:::CrosspointsRequest"]=0
operation_parameters_minimum_occurrences["post7:::graph"]=1
operation_parameters_minimum_occurrences["post7:::PathRequest"]=0
operation_parameters_minimum_occurrences["post:::graph"]=1
operation_parameters_minimum_occurrences["post:::body"]=0
operation_parameters_minimum_occurrences["query:::graph"]=1
operation_parameters_minimum_occurrences["query:::cypher"]=0
operation_parameters_minimum_occurrences["getExternalGrammar:::path"]=1
operation_parameters_minimum_occurrences["create6:::graph"]=1
operation_parameters_minimum_occurrences["create6:::JsonEdge"]=0
operation_parameters_minimum_occurrences["create7:::graph"]=1
operation_parameters_minimum_occurrences["create7:::check_vertex"]=0
operation_parameters_minimum_occurrences["create7:::JsonEdge"]=0
operation_parameters_minimum_occurrences["delete6:::graph"]=1
operation_parameters_minimum_occurrences["delete6:::id"]=1
operation_parameters_minimum_occurrences["delete6:::label"]=0
operation_parameters_minimum_occurrences["get7:::graph"]=1
operation_parameters_minimum_occurrences["get7:::id"]=1
operation_parameters_minimum_occurrences["list6:::graph"]=1
operation_parameters_minimum_occurrences["list6:::vertex_id"]=0
operation_parameters_minimum_occurrences["list6:::direction"]=0
operation_parameters_minimum_occurrences["list6:::label"]=0
operation_parameters_minimum_occurrences["list6:::properties"]=0
operation_parameters_minimum_occurrences["list6:::keep_start_p"]=0
operation_parameters_minimum_occurrences["list6:::offset"]=0
operation_parameters_minimum_occurrences["list6:::page"]=0
operation_parameters_minimum_occurrences["list6:::limit"]=0
operation_parameters_minimum_occurrences["update6:::graph"]=1
operation_parameters_minimum_occurrences["update6:::BatchEdgeRequest"]=0
operation_parameters_minimum_occurrences["update7:::graph"]=1
operation_parameters_minimum_occurrences["update7:::id"]=1
operation_parameters_minimum_occurrences["update7:::action"]=0
operation_parameters_minimum_occurrences["update7:::JsonEdge"]=0
operation_parameters_minimum_occurrences["get19:::graph"]=1
operation_parameters_minimum_occurrences["get19:::source"]=0
operation_parameters_minimum_occurrences["get19:::target"]=0
operation_parameters_minimum_occurrences["get19:::label"]=0
operation_parameters_minimum_occurrences["get19:::sort_values"]=0
operation_parameters_minimum_occurrences["get19:::limit"]=0
operation_parameters_minimum_occurrences["create11:::graph"]=1
operation_parameters_minimum_occurrences["create11:::JsonEdgeLabel"]=0
operation_parameters_minimum_occurrences["delete9:::graph"]=1
operation_parameters_minimum_occurrences["delete9:::name"]=1
operation_parameters_minimum_occurrences["get12:::graph"]=1
operation_parameters_minimum_occurrences["get12:::name"]=1
operation_parameters_minimum_occurrences["list12:::graph"]=1
operation_parameters_minimum_occurrences["list12:::names"]=0
operation_parameters_minimum_occurrences["update11:::graph"]=1
operation_parameters_minimum_occurrences["update11:::name"]=1
operation_parameters_minimum_occurrences["update11:::action"]=0
operation_parameters_minimum_occurrences["update11:::JsonEdgeLabel"]=0
operation_parameters_minimum_occurrences["list17:::graph"]=1
operation_parameters_minimum_occurrences["list17:::ids"]=0
operation_parameters_minimum_occurrences["scan:::graph"]=1
operation_parameters_minimum_occurrences["scan:::start"]=0
operation_parameters_minimum_occurrences["scan:::end"]=0
operation_parameters_minimum_occurrences["scan:::page"]=0
operation_parameters_minimum_occurrences["scan:::page_limit"]=0
operation_parameters_minimum_occurrences["shards:::graph"]=1
operation_parameters_minimum_occurrences["shards:::split_size"]=0
operation_parameters_minimum_occurrences["post8:::graph"]=1
operation_parameters_minimum_occurrences["post8:::FusiformSimilarityRequest"]=0
operation_parameters_minimum_occurrences["clear:::name"]=1
operation_parameters_minimum_occurrences["clear:::confirm_message"]=0
operation_parameters_minimum_occurrences["compact:::name"]=1
operation_parameters_minimum_occurrences["create10:::name"]=1
operation_parameters_minimum_occurrences["create10:::clone_graph_name"]=0
operation_parameters_minimum_occurrences["create10:::body"]=0
operation_parameters_minimum_occurrences["createSnapshot:::name"]=1
operation_parameters_minimum_occurrences["drop:::name"]=1
operation_parameters_minimum_occurrences["drop:::confirm_message"]=0
operation_parameters_minimum_occurrences["get11:::name"]=1
operation_parameters_minimum_occurrences["getConf:::name"]=1
operation_parameters_minimum_occurrences["graphReadMode:::name"]=1
operation_parameters_minimum_occurrences["graphReadMode1:::name"]=1
operation_parameters_minimum_occurrences["graphReadMode1:::body"]=0
operation_parameters_minimum_occurrences["mode:::name"]=1
operation_parameters_minimum_occurrences["mode1:::name"]=1
operation_parameters_minimum_occurrences["mode1:::body"]=0
operation_parameters_minimum_occurrences["resumeSnapshot:::name"]=1
operation_parameters_minimum_occurrences["post1:::body"]=0
operation_parameters_minimum_occurrences["post4:::graph"]=1
operation_parameters_minimum_occurrences["post4:::GremlinRequest"]=0
operation_parameters_minimum_occurrences["create2:::graph"]=1
operation_parameters_minimum_occurrences["create2:::JsonGroup"]=0
operation_parameters_minimum_occurrences["delete2:::graph"]=1
operation_parameters_minimum_occurrences["delete2:::id"]=1
operation_parameters_minimum_occurrences["get2:::graph"]=1
operation_parameters_minimum_occurrences["get2:::id"]=1
operation_parameters_minimum_occurrences["list2:::graph"]=1
operation_parameters_minimum_occurrences["list2:::limit"]=0
operation_parameters_minimum_occurrences["update2:::graph"]=1
operation_parameters_minimum_occurrences["update2:::id"]=1
operation_parameters_minimum_occurrences["update2:::JsonGroup"]=0
operation_parameters_minimum_occurrences["create12:::graph"]=1
operation_parameters_minimum_occurrences["create12:::JsonIndexLabel"]=0
operation_parameters_minimum_occurrences["delete10:::graph"]=1
operation_parameters_minimum_occurrences["delete10:::name"]=1
operation_parameters_minimum_occurrences["get13:::graph"]=1
operation_parameters_minimum_occurrences["get13:::name"]=1
operation_parameters_minimum_occurrences["list13:::graph"]=1
operation_parameters_minimum_occurrences["list13:::names"]=0
operation_parameters_minimum_occurrences["update12:::graph"]=1
operation_parameters_minimum_occurrences["update12:::name"]=1
operation_parameters_minimum_occurrences["update12:::action"]=0
operation_parameters_minimum_occurrences["update12:::JsonIndexLabel"]=0
operation_parameters_minimum_occurrences["get20:::graph"]=1
operation_parameters_minimum_occurrences["get20:::vertex"]=0
operation_parameters_minimum_occurrences["get20:::other"]=0
operation_parameters_minimum_occurrences["get20:::direction"]=0
operation_parameters_minimum_occurrences["get20:::label"]=0
operation_parameters_minimum_occurrences["get20:::max_degree"]=0
operation_parameters_minimum_occurrences["post9:::graph"]=1
operation_parameters_minimum_occurrences["post9:::Request"]=0
operation_parameters_minimum_occurrences["get21:::graph"]=1
operation_parameters_minimum_occurrences["get21:::source"]=0
operation_parameters_minimum_occurrences["get21:::direction"]=0
operation_parameters_minimum_occurrences["get21:::label"]=0
operation_parameters_minimum_occurrences["get21:::max_depth"]=0
operation_parameters_minimum_occurrences["get21:::count_only"]=0
operation_parameters_minimum_occurrences["get21:::max_degree"]=0
operation_parameters_minimum_occurrences["get21:::limit"]=0
operation_parameters_minimum_occurrences["post10:::graph"]=1
operation_parameters_minimum_occurrences["post10:::Request"]=0
operation_parameters_minimum_occurrences["get22:::graph"]=1
operation_parameters_minimum_occurrences["get22:::source"]=0
operation_parameters_minimum_occurrences["get22:::direction"]=0
operation_parameters_minimum_occurrences["get22:::label"]=0
operation_parameters_minimum_occurrences["get22:::max_depth"]=0
operation_parameters_minimum_occurrences["get22:::nearest"]=0
operation_parameters_minimum_occurrences["get22:::count_only"]=0
operation_parameters_minimum_occurrences["get22:::max_degree"]=0
operation_parameters_minimum_occurrences["get22:::capacity"]=0
operation_parameters_minimum_occurrences["get22:::limit"]=0
operation_parameters_minimum_occurrences["post11:::graph"]=1
operation_parameters_minimum_occurrences["post11:::Request"]=0
operation_parameters_minimum_occurrences["login:::graph"]=1
operation_parameters_minimum_occurrences["login:::JsonLogin"]=0
operation_parameters_minimum_occurrences["logout:::graph"]=1
operation_parameters_minimum_occurrences["logout:::Authorization"]=0
operation_parameters_minimum_occurrences["verifyToken:::graph"]=1
operation_parameters_minimum_occurrences["verifyToken:::Authorization"]=0
operation_parameters_minimum_occurrences["all:::type"]=0
operation_parameters_minimum_occurrences["statistics:::type"]=0
operation_parameters_minimum_occurrences["post12:::graph"]=1
operation_parameters_minimum_occurrences["post12:::Request"]=0
operation_parameters_minimum_occurrences["neighborRank:::graph"]=1
operation_parameters_minimum_occurrences["neighborRank:::RankRequest"]=0
operation_parameters_minimum_occurrences["get23:::graph"]=1
operation_parameters_minimum_occurrences["get23:::source"]=0
operation_parameters_minimum_occurrences["get23:::target"]=0
operation_parameters_minimum_occurrences["get23:::direction"]=0
operation_parameters_minimum_occurrences["get23:::label"]=0
operation_parameters_minimum_occurrences["get23:::max_depth"]=0
operation_parameters_minimum_occurrences["get23:::max_degree"]=0
operation_parameters_minimum_occurrences["get23:::capacity"]=0
operation_parameters_minimum_occurrences["get23:::limit"]=0
operation_parameters_minimum_occurrences["post13:::graph"]=1
operation_parameters_minimum_occurrences["post13:::Request"]=0
operation_parameters_minimum_occurrences["personalRank:::graph"]=1
operation_parameters_minimum_occurrences["personalRank:::RankRequest"]=0
operation_parameters_minimum_occurrences["create3:::graph"]=1
operation_parameters_minimum_occurrences["create3:::JsonProject"]=0
operation_parameters_minimum_occurrences["delete3:::graph"]=1
operation_parameters_minimum_occurrences["delete3:::id"]=1
operation_parameters_minimum_occurrences["get3:::graph"]=1
operation_parameters_minimum_occurrences["get3:::id"]=1
operation_parameters_minimum_occurrences["list3:::graph"]=1
operation_parameters_minimum_occurrences["list3:::limit"]=0
operation_parameters_minimum_occurrences["update3:::graph"]=1
operation_parameters_minimum_occurrences["update3:::id"]=1
operation_parameters_minimum_occurrences["update3:::action"]=0
operation_parameters_minimum_occurrences["update3:::JsonProject"]=0
operation_parameters_minimum_occurrences["create13:::graph"]=1
operation_parameters_minimum_occurrences["create13:::JsonPropertyKey"]=0
operation_parameters_minimum_occurrences["delete11:::graph"]=1
operation_parameters_minimum_occurrences["delete11:::name"]=1
operation_parameters_minimum_occurrences["get14:::graph"]=1
operation_parameters_minimum_occurrences["get14:::name"]=1
operation_parameters_minimum_occurrences["list14:::graph"]=1
operation_parameters_minimum_occurrences["list14:::names"]=0
operation_parameters_minimum_occurrences["update13:::graph"]=1
operation_parameters_minimum_occurrences["update13:::name"]=1
operation_parameters_minimum_occurrences["update13:::action"]=0
operation_parameters_minimum_occurrences["update13:::JsonPropertyKey"]=0
operation_parameters_minimum_occurrences["addPeer:::graph"]=1
operation_parameters_minimum_occurrences["addPeer:::group"]=0
operation_parameters_minimum_occurrences["addPeer:::endpoint"]=0
operation_parameters_minimum_occurrences["getLeader:::graph"]=1
operation_parameters_minimum_occurrences["getLeader:::group"]=0
operation_parameters_minimum_occurrences["listPeers:::graph"]=1
operation_parameters_minimum_occurrences["listPeers:::group"]=0
operation_parameters_minimum_occurrences["removePeer:::graph"]=1
operation_parameters_minimum_occurrences["removePeer:::group"]=0
operation_parameters_minimum_occurrences["removePeer:::endpoint"]=0
operation_parameters_minimum_occurrences["setLeader:::graph"]=1
operation_parameters_minimum_occurrences["setLeader:::group"]=0
operation_parameters_minimum_occurrences["setLeader:::endpoint"]=0
operation_parameters_minimum_occurrences["transferLeader:::graph"]=1
operation_parameters_minimum_occurrences["transferLeader:::group"]=0
operation_parameters_minimum_occurrences["transferLeader:::endpoint"]=0
operation_parameters_minimum_occurrences["get24:::graph"]=1
operation_parameters_minimum_occurrences["get24:::source"]=0
operation_parameters_minimum_occurrences["get24:::direction"]=0
operation_parameters_minimum_occurrences["get24:::label"]=0
operation_parameters_minimum_occurrences["get24:::max_depth"]=0
operation_parameters_minimum_occurrences["get24:::max_degree"]=0
operation_parameters_minimum_occurrences["get24:::capacity"]=0
operation_parameters_minimum_occurrences["get24:::limit"]=0
operation_parameters_minimum_occurrences["get24:::with_vertex"]=0
operation_parameters_minimum_occurrences["get24:::with_edge"]=0
operation_parameters_minimum_occurrences["edgeLabelRebuild:::graph"]=1
operation_parameters_minimum_occurrences["edgeLabelRebuild:::name"]=1
operation_parameters_minimum_occurrences["indexLabelRebuild:::graph"]=1
operation_parameters_minimum_occurrences["indexLabelRebuild:::name"]=1
operation_parameters_minimum_occurrences["vertexLabelRebuild:::graph"]=1
operation_parameters_minimum_occurrences["vertexLabelRebuild:::name"]=1
operation_parameters_minimum_occurrences["create15:::graph"]=1
operation_parameters_minimum_occurrences["create15:::vertex"]=0
operation_parameters_minimum_occurrences["create15:::other"]=0
operation_parameters_minimum_occurrences["create15:::direction"]=0
operation_parameters_minimum_occurrences["create15:::label"]=0
operation_parameters_minimum_occurrences["create15:::max_degree"]=0
operation_parameters_minimum_occurrences["create15:::limit"]=0
operation_parameters_minimum_occurrences["get25:::graph"]=1
operation_parameters_minimum_occurrences["get25:::source"]=0
operation_parameters_minimum_occurrences["get25:::direction"]=0
operation_parameters_minimum_occurrences["get25:::label"]=0
operation_parameters_minimum_occurrences["get25:::max_depth"]=0
operation_parameters_minimum_occurrences["get25:::source_in_ring"]=0
operation_parameters_minimum_occurrences["get25:::max_degree"]=0
operation_parameters_minimum_occurrences["get25:::capacity"]=0
operation_parameters_minimum_occurrences["get25:::limit"]=0
operation_parameters_minimum_occurrences["get25:::with_vertex"]=0
operation_parameters_minimum_occurrences["get25:::with_edge"]=0
operation_parameters_minimum_occurrences["get26:::graph"]=1
operation_parameters_minimum_occurrences["get26:::vertex"]=0
operation_parameters_minimum_occurrences["get26:::other"]=0
operation_parameters_minimum_occurrences["get26:::direction"]=0
operation_parameters_minimum_occurrences["get26:::label"]=0
operation_parameters_minimum_occurrences["get26:::max_degree"]=0
operation_parameters_minimum_occurrences["get26:::limit"]=0
operation_parameters_minimum_occurrences["sameNeighbors:::graph"]=1
operation_parameters_minimum_occurrences["sameNeighbors:::Request"]=0
operation_parameters_minimum_occurrences["list15:::graph"]=1
operation_parameters_minimum_occurrences["get27:::graph"]=1
operation_parameters_minimum_occurrences["get27:::source"]=0
operation_parameters_minimum_occurrences["get27:::target"]=0
operation_parameters_minimum_occurrences["get27:::direction"]=0
operation_parameters_minimum_occurrences["get27:::label"]=0
operation_parameters_minimum_occurrences["get27:::max_depth"]=0
operation_parameters_minimum_occurrences["get27:::max_degree"]=0
operation_parameters_minimum_occurrences["get27:::skip_degree"]=0
operation_parameters_minimum_occurrences["get27:::with_vertex"]=0
operation_parameters_minimum_occurrences["get27:::with_edge"]=0
operation_parameters_minimum_occurrences["get27:::capacity"]=0
operation_parameters_minimum_occurrences["get28:::graph"]=1
operation_parameters_minimum_occurrences["get28:::source"]=0
operation_parameters_minimum_occurrences["get28:::direction"]=0
operation_parameters_minimum_occurrences["get28:::label"]=0
operation_parameters_minimum_occurrences["get28:::weight"]=0
operation_parameters_minimum_occurrences["get28:::max_degree"]=0
operation_parameters_minimum_occurrences["get28:::skip_degree"]=0
operation_parameters_minimum_occurrences["get28:::with_vertex"]=0
operation_parameters_minimum_occurrences["get28:::with_edge"]=0
operation_parameters_minimum_occurrences["get28:::capacity"]=0
operation_parameters_minimum_occurrences["get28:::limit"]=0
operation_parameters_minimum_occurrences["create4:::graph"]=1
operation_parameters_minimum_occurrences["create4:::JsonTarget"]=0
operation_parameters_minimum_occurrences["delete4:::graph"]=1
operation_parameters_minimum_occurrences["delete4:::id"]=1
operation_parameters_minimum_occurrences["get4:::graph"]=1
operation_parameters_minimum_occurrences["get4:::id"]=1
operation_parameters_minimum_occurrences["list4:::graph"]=1
operation_parameters_minimum_occurrences["list4:::limit"]=0
operation_parameters_minimum_occurrences["update4:::graph"]=1
operation_parameters_minimum_occurrences["update4:::id"]=1
operation_parameters_minimum_occurrences["update4:::JsonTarget"]=0
operation_parameters_minimum_occurrences["delete8:::graph"]=1
operation_parameters_minimum_occurrences["delete8:::id"]=1
operation_parameters_minimum_occurrences["delete8:::force"]=0
operation_parameters_minimum_occurrences["get10:::graph"]=1
operation_parameters_minimum_occurrences["get10:::id"]=1
operation_parameters_minimum_occurrences["list8:::graph"]=1
operation_parameters_minimum_occurrences["list8:::status"]=0
operation_parameters_minimum_occurrences["list8:::ids"]=0
operation_parameters_minimum_occurrences["list8:::limit"]=0
operation_parameters_minimum_occurrences["list8:::page"]=0
operation_parameters_minimum_occurrences["update10:::graph"]=1
operation_parameters_minimum_occurrences["update10:::id"]=1
operation_parameters_minimum_occurrences["update10:::action"]=0
operation_parameters_minimum_occurrences["post14:::graph"]=1
operation_parameters_minimum_occurrences["post14:::Request"]=0
operation_parameters_minimum_occurrences["trace:::body"]=0
operation_parameters_minimum_occurrences["create5:::graph"]=1
operation_parameters_minimum_occurrences["create5:::JsonUser"]=0
operation_parameters_minimum_occurrences["delete5:::graph"]=1
operation_parameters_minimum_occurrences["delete5:::id"]=1
operation_parameters_minimum_occurrences["get5:::graph"]=1
operation_parameters_minimum_occurrences["get5:::id"]=1
operation_parameters_minimum_occurrences["list5:::graph"]=1
operation_parameters_minimum_occurrences["list5:::limit"]=0
operation_parameters_minimum_occurrences["role:::graph"]=1
operation_parameters_minimum_occurrences["role:::id"]=1
operation_parameters_minimum_occurrences["update5:::graph"]=1
operation_parameters_minimum_occurrences["update5:::id"]=1
operation_parameters_minimum_occurrences["update5:::JsonUser"]=0
operation_parameters_minimum_occurrences["delete13:::graph"]=1
operation_parameters_minimum_occurrences["delete13:::key"]=1
operation_parameters_minimum_occurrences["get30:::graph"]=1
operation_parameters_minimum_occurrences["get30:::key"]=1
operation_parameters_minimum_occurrences["list19:::graph"]=1
operation_parameters_minimum_occurrences["update15:::graph"]=1
operation_parameters_minimum_occurrences["update15:::key"]=1
operation_parameters_minimum_occurrences["update15:::JsonVariableValue"]=0
operation_parameters_minimum_occurrences["create8:::graph"]=1
operation_parameters_minimum_occurrences["create8:::JsonVertex"]=0
operation_parameters_minimum_occurrences["create9:::graph"]=1
operation_parameters_minimum_occurrences["create9:::JsonVertex"]=0
operation_parameters_minimum_occurrences["delete7:::graph"]=1
operation_parameters_minimum_occurrences["delete7:::id"]=1
operation_parameters_minimum_occurrences["delete7:::label"]=0
operation_parameters_minimum_occurrences["get8:::graph"]=1
operation_parameters_minimum_occurrences["get8:::id"]=1
operation_parameters_minimum_occurrences["list7:::graph"]=1
operation_parameters_minimum_occurrences["list7:::label"]=0
operation_parameters_minimum_occurrences["list7:::properties"]=0
operation_parameters_minimum_occurrences["list7:::keep_start_p"]=0
operation_parameters_minimum_occurrences["list7:::offset"]=0
operation_parameters_minimum_occurrences["list7:::page"]=0
operation_parameters_minimum_occurrences["list7:::limit"]=0
operation_parameters_minimum_occurrences["update8:::graph"]=1
operation_parameters_minimum_occurrences["update8:::BatchVertexRequest"]=0
operation_parameters_minimum_occurrences["update9:::graph"]=1
operation_parameters_minimum_occurrences["update9:::id"]=1
operation_parameters_minimum_occurrences["update9:::action"]=0
operation_parameters_minimum_occurrences["update9:::JsonVertex"]=0
operation_parameters_minimum_occurrences["create14:::graph"]=1
operation_parameters_minimum_occurrences["create14:::JsonVertexLabel"]=0
operation_parameters_minimum_occurrences["delete12:::graph"]=1
operation_parameters_minimum_occurrences["delete12:::name"]=1
operation_parameters_minimum_occurrences["get15:::graph"]=1
operation_parameters_minimum_occurrences["get15:::name"]=1
operation_parameters_minimum_occurrences["list16:::graph"]=1
operation_parameters_minimum_occurrences["list16:::names"]=0
operation_parameters_minimum_occurrences["update14:::graph"]=1
operation_parameters_minimum_occurrences["update14:::name"]=1
operation_parameters_minimum_occurrences["update14:::action"]=0
operation_parameters_minimum_occurrences["update14:::JsonVertexLabel"]=0
operation_parameters_minimum_occurrences["list18:::graph"]=1
operation_parameters_minimum_occurrences["list18:::ids"]=0
operation_parameters_minimum_occurrences["scan1:::graph"]=1
operation_parameters_minimum_occurrences["scan1:::start"]=0
operation_parameters_minimum_occurrences["scan1:::end"]=0
operation_parameters_minimum_occurrences["scan1:::page"]=0
operation_parameters_minimum_occurrences["scan1:::page_limit"]=0
operation_parameters_minimum_occurrences["shards1:::graph"]=1
operation_parameters_minimum_occurrences["shards1:::split_size"]=0
operation_parameters_minimum_occurrences["get29:::graph"]=1
operation_parameters_minimum_occurrences["get29:::source"]=0
operation_parameters_minimum_occurrences["get29:::target"]=0
operation_parameters_minimum_occurrences["get29:::direction"]=0
operation_parameters_minimum_occurrences["get29:::label"]=0
operation_parameters_minimum_occurrences["get29:::weight"]=0
operation_parameters_minimum_occurrences["get29:::max_degree"]=0
operation_parameters_minimum_occurrences["get29:::skip_degree"]=0
operation_parameters_minimum_occurrences["get29:::with_vertex"]=0
operation_parameters_minimum_occurrences["get29:::with_edge"]=0
operation_parameters_minimum_occurrences["get29:::capacity"]=0
operation_parameters_minimum_occurrences["updateStatus:::status"]=0
operation_parameters_minimum_occurrences["updateWhiteIPs:::request_body"]=0

##
# This array stores the maximum number of allowed occurrences for parameter
# 1 - single value
# 2 - 2 values
# N - N values
# 0 - unlimited
declare -A operation_parameters_maximum_occurrences
operation_parameters_maximum_occurrences["create:::graph"]=0
operation_parameters_maximum_occurrences["create:::JsonAccess"]=0
operation_parameters_maximum_occurrences["delete:::graph"]=0
operation_parameters_maximum_occurrences["delete:::id"]=0
operation_parameters_maximum_occurrences["get:::graph"]=0
operation_parameters_maximum_occurrences["get:::id"]=0
operation_parameters_maximum_occurrences["list:::graph"]=0
operation_parameters_maximum_occurrences["list:::group"]=0
operation_parameters_maximum_occurrences["list:::target"]=0
operation_parameters_maximum_occurrences["list:::limit"]=0
operation_parameters_maximum_occurrences["update:::graph"]=0
operation_parameters_maximum_occurrences["update:::id"]=0
operation_parameters_maximum_occurrences["update:::JsonAccess"]=0
operation_parameters_maximum_occurrences["get16:::graph"]=0
operation_parameters_maximum_occurrences["get16:::vertex"]=0
operation_parameters_maximum_occurrences["get16:::other"]=0
operation_parameters_maximum_occurrences["get16:::direction"]=0
operation_parameters_maximum_occurrences["get16:::label"]=0
operation_parameters_maximum_occurrences["get16:::max_degree"]=0
operation_parameters_maximum_occurrences["get16:::limit"]=0
operation_parameters_maximum_occurrences["post2:::graph"]=0
operation_parameters_maximum_occurrences["post2:::name"]=0
operation_parameters_maximum_occurrences["post2:::request_body"]=0
operation_parameters_maximum_occurrences["get17:::graph"]=0
operation_parameters_maximum_occurrences["get17:::source"]=0
operation_parameters_maximum_occurrences["get17:::target"]=0
operation_parameters_maximum_occurrences["get17:::direction"]=0
operation_parameters_maximum_occurrences["get17:::label"]=0
operation_parameters_maximum_occurrences["get17:::max_depth"]=0
operation_parameters_maximum_occurrences["get17:::max_degree"]=0
operation_parameters_maximum_occurrences["get17:::skip_degree"]=0
operation_parameters_maximum_occurrences["get17:::with_vertex"]=0
operation_parameters_maximum_occurrences["get17:::with_edge"]=0
operation_parameters_maximum_occurrences["get17:::capacity"]=0
operation_parameters_maximum_occurrences["create1:::graph"]=0
operation_parameters_maximum_occurrences["create1:::JsonBelong"]=0
operation_parameters_maximum_occurrences["delete1:::graph"]=0
operation_parameters_maximum_occurrences["delete1:::id"]=0
operation_parameters_maximum_occurrences["get1:::graph"]=0
operation_parameters_maximum_occurrences["get1:::id"]=0
operation_parameters_maximum_occurrences["list1:::graph"]=0
operation_parameters_maximum_occurrences["list1:::user"]=0
operation_parameters_maximum_occurrences["list1:::group"]=0
operation_parameters_maximum_occurrences["list1:::limit"]=0
operation_parameters_maximum_occurrences["update1:::graph"]=0
operation_parameters_maximum_occurrences["update1:::id"]=0
operation_parameters_maximum_occurrences["update1:::JsonBelong"]=0
operation_parameters_maximum_occurrences["post3:::graph"]=0
operation_parameters_maximum_occurrences["post3:::name"]=0
operation_parameters_maximum_occurrences["post3:::request_body"]=0
operation_parameters_maximum_occurrences["post5:::graph"]=0
operation_parameters_maximum_occurrences["post5:::CountRequest"]=0
operation_parameters_maximum_occurrences["get18:::graph"]=0
operation_parameters_maximum_occurrences["get18:::source"]=0
operation_parameters_maximum_occurrences["get18:::target"]=0
operation_parameters_maximum_occurrences["get18:::direction"]=0
operation_parameters_maximum_occurrences["get18:::label"]=0
operation_parameters_maximum_occurrences["get18:::max_depth"]=0
operation_parameters_maximum_occurrences["get18:::max_degree"]=0
operation_parameters_maximum_occurrences["get18:::capacity"]=0
operation_parameters_maximum_occurrences["get18:::limit"]=0
operation_parameters_maximum_occurrences["post6:::graph"]=0
operation_parameters_maximum_occurrences["post6:::CrosspointsRequest"]=0
operation_parameters_maximum_occurrences["post7:::graph"]=0
operation_parameters_maximum_occurrences["post7:::PathRequest"]=0
operation_parameters_maximum_occurrences["post:::graph"]=0
operation_parameters_maximum_occurrences["post:::body"]=0
operation_parameters_maximum_occurrences["query:::graph"]=0
operation_parameters_maximum_occurrences["query:::cypher"]=0
operation_parameters_maximum_occurrences["getExternalGrammar:::path"]=0
operation_parameters_maximum_occurrences["create6:::graph"]=0
operation_parameters_maximum_occurrences["create6:::JsonEdge"]=0
operation_parameters_maximum_occurrences["create7:::graph"]=0
operation_parameters_maximum_occurrences["create7:::check_vertex"]=0
operation_parameters_maximum_occurrences["create7:::JsonEdge"]=0
operation_parameters_maximum_occurrences["delete6:::graph"]=0
operation_parameters_maximum_occurrences["delete6:::id"]=0
operation_parameters_maximum_occurrences["delete6:::label"]=0
operation_parameters_maximum_occurrences["get7:::graph"]=0
operation_parameters_maximum_occurrences["get7:::id"]=0
operation_parameters_maximum_occurrences["list6:::graph"]=0
operation_parameters_maximum_occurrences["list6:::vertex_id"]=0
operation_parameters_maximum_occurrences["list6:::direction"]=0
operation_parameters_maximum_occurrences["list6:::label"]=0
operation_parameters_maximum_occurrences["list6:::properties"]=0
operation_parameters_maximum_occurrences["list6:::keep_start_p"]=0
operation_parameters_maximum_occurrences["list6:::offset"]=0
operation_parameters_maximum_occurrences["list6:::page"]=0
operation_parameters_maximum_occurrences["list6:::limit"]=0
operation_parameters_maximum_occurrences["update6:::graph"]=0
operation_parameters_maximum_occurrences["update6:::BatchEdgeRequest"]=0
operation_parameters_maximum_occurrences["update7:::graph"]=0
operation_parameters_maximum_occurrences["update7:::id"]=0
operation_parameters_maximum_occurrences["update7:::action"]=0
operation_parameters_maximum_occurrences["update7:::JsonEdge"]=0
operation_parameters_maximum_occurrences["get19:::graph"]=0
operation_parameters_maximum_occurrences["get19:::source"]=0
operation_parameters_maximum_occurrences["get19:::target"]=0
operation_parameters_maximum_occurrences["get19:::label"]=0
operation_parameters_maximum_occurrences["get19:::sort_values"]=0
operation_parameters_maximum_occurrences["get19:::limit"]=0
operation_parameters_maximum_occurrences["create11:::graph"]=0
operation_parameters_maximum_occurrences["create11:::JsonEdgeLabel"]=0
operation_parameters_maximum_occurrences["delete9:::graph"]=0
operation_parameters_maximum_occurrences["delete9:::name"]=0
operation_parameters_maximum_occurrences["get12:::graph"]=0
operation_parameters_maximum_occurrences["get12:::name"]=0
operation_parameters_maximum_occurrences["list12:::graph"]=0
operation_parameters_maximum_occurrences["list12:::names"]=0
operation_parameters_maximum_occurrences["update11:::graph"]=0
operation_parameters_maximum_occurrences["update11:::name"]=0
operation_parameters_maximum_occurrences["update11:::action"]=0
operation_parameters_maximum_occurrences["update11:::JsonEdgeLabel"]=0
operation_parameters_maximum_occurrences["list17:::graph"]=0
operation_parameters_maximum_occurrences["list17:::ids"]=0
operation_parameters_maximum_occurrences["scan:::graph"]=0
operation_parameters_maximum_occurrences["scan:::start"]=0
operation_parameters_maximum_occurrences["scan:::end"]=0
operation_parameters_maximum_occurrences["scan:::page"]=0
operation_parameters_maximum_occurrences["scan:::page_limit"]=0
operation_parameters_maximum_occurrences["shards:::graph"]=0
operation_parameters_maximum_occurrences["shards:::split_size"]=0
operation_parameters_maximum_occurrences["post8:::graph"]=0
operation_parameters_maximum_occurrences["post8:::FusiformSimilarityRequest"]=0
operation_parameters_maximum_occurrences["clear:::name"]=0
operation_parameters_maximum_occurrences["clear:::confirm_message"]=0
operation_parameters_maximum_occurrences["compact:::name"]=0
operation_parameters_maximum_occurrences["create10:::name"]=0
operation_parameters_maximum_occurrences["create10:::clone_graph_name"]=0
operation_parameters_maximum_occurrences["create10:::body"]=0
operation_parameters_maximum_occurrences["createSnapshot:::name"]=0
operation_parameters_maximum_occurrences["drop:::name"]=0
operation_parameters_maximum_occurrences["drop:::confirm_message"]=0
operation_parameters_maximum_occurrences["get11:::name"]=0
operation_parameters_maximum_occurrences["getConf:::name"]=0
operation_parameters_maximum_occurrences["graphReadMode:::name"]=0
operation_parameters_maximum_occurrences["graphReadMode1:::name"]=0
operation_parameters_maximum_occurrences["graphReadMode1:::body"]=0
operation_parameters_maximum_occurrences["mode:::name"]=0
operation_parameters_maximum_occurrences["mode1:::name"]=0
operation_parameters_maximum_occurrences["mode1:::body"]=0
operation_parameters_maximum_occurrences["resumeSnapshot:::name"]=0
operation_parameters_maximum_occurrences["post1:::body"]=0
operation_parameters_maximum_occurrences["post4:::graph"]=0
operation_parameters_maximum_occurrences["post4:::GremlinRequest"]=0
operation_parameters_maximum_occurrences["create2:::graph"]=0
operation_parameters_maximum_occurrences["create2:::JsonGroup"]=0
operation_parameters_maximum_occurrences["delete2:::graph"]=0
operation_parameters_maximum_occurrences["delete2:::id"]=0
operation_parameters_maximum_occurrences["get2:::graph"]=0
operation_parameters_maximum_occurrences["get2:::id"]=0
operation_parameters_maximum_occurrences["list2:::graph"]=0
operation_parameters_maximum_occurrences["list2:::limit"]=0
operation_parameters_maximum_occurrences["update2:::graph"]=0
operation_parameters_maximum_occurrences["update2:::id"]=0
operation_parameters_maximum_occurrences["update2:::JsonGroup"]=0
operation_parameters_maximum_occurrences["create12:::graph"]=0
operation_parameters_maximum_occurrences["create12:::JsonIndexLabel"]=0
operation_parameters_maximum_occurrences["delete10:::graph"]=0
operation_parameters_maximum_occurrences["delete10:::name"]=0
operation_parameters_maximum_occurrences["get13:::graph"]=0
operation_parameters_maximum_occurrences["get13:::name"]=0
operation_parameters_maximum_occurrences["list13:::graph"]=0
operation_parameters_maximum_occurrences["list13:::names"]=0
operation_parameters_maximum_occurrences["update12:::graph"]=0
operation_parameters_maximum_occurrences["update12:::name"]=0
operation_parameters_maximum_occurrences["update12:::action"]=0
operation_parameters_maximum_occurrences["update12:::JsonIndexLabel"]=0
operation_parameters_maximum_occurrences["get20:::graph"]=0
operation_parameters_maximum_occurrences["get20:::vertex"]=0
operation_parameters_maximum_occurrences["get20:::other"]=0
operation_parameters_maximum_occurrences["get20:::direction"]=0
operation_parameters_maximum_occurrences["get20:::label"]=0
operation_parameters_maximum_occurrences["get20:::max_degree"]=0
operation_parameters_maximum_occurrences["post9:::graph"]=0
operation_parameters_maximum_occurrences["post9:::Request"]=0
operation_parameters_maximum_occurrences["get21:::graph"]=0
operation_parameters_maximum_occurrences["get21:::source"]=0
operation_parameters_maximum_occurrences["get21:::direction"]=0
operation_parameters_maximum_occurrences["get21:::label"]=0
operation_parameters_maximum_occurrences["get21:::max_depth"]=0
operation_parameters_maximum_occurrences["get21:::count_only"]=0
operation_parameters_maximum_occurrences["get21:::max_degree"]=0
operation_parameters_maximum_occurrences["get21:::limit"]=0
operation_parameters_maximum_occurrences["post10:::graph"]=0
operation_parameters_maximum_occurrences["post10:::Request"]=0
operation_parameters_maximum_occurrences["get22:::graph"]=0
operation_parameters_maximum_occurrences["get22:::source"]=0
operation_parameters_maximum_occurrences["get22:::direction"]=0
operation_parameters_maximum_occurrences["get22:::label"]=0
operation_parameters_maximum_occurrences["get22:::max_depth"]=0
operation_parameters_maximum_occurrences["get22:::nearest"]=0
operation_parameters_maximum_occurrences["get22:::count_only"]=0
operation_parameters_maximum_occurrences["get22:::max_degree"]=0
operation_parameters_maximum_occurrences["get22:::capacity"]=0
operation_parameters_maximum_occurrences["get22:::limit"]=0
operation_parameters_maximum_occurrences["post11:::graph"]=0
operation_parameters_maximum_occurrences["post11:::Request"]=0
operation_parameters_maximum_occurrences["login:::graph"]=0
operation_parameters_maximum_occurrences["login:::JsonLogin"]=0
operation_parameters_maximum_occurrences["logout:::graph"]=0
operation_parameters_maximum_occurrences["logout:::Authorization"]=0
operation_parameters_maximum_occurrences["verifyToken:::graph"]=0
operation_parameters_maximum_occurrences["verifyToken:::Authorization"]=0
operation_parameters_maximum_occurrences["all:::type"]=0
operation_parameters_maximum_occurrences["statistics:::type"]=0
operation_parameters_maximum_occurrences["post12:::graph"]=0
operation_parameters_maximum_occurrences["post12:::Request"]=0
operation_parameters_maximum_occurrences["neighborRank:::graph"]=0
operation_parameters_maximum_occurrences["neighborRank:::RankRequest"]=0
operation_parameters_maximum_occurrences["get23:::graph"]=0
operation_parameters_maximum_occurrences["get23:::source"]=0
operation_parameters_maximum_occurrences["get23:::target"]=0
operation_parameters_maximum_occurrences["get23:::direction"]=0
operation_parameters_maximum_occurrences["get23:::label"]=0
operation_parameters_maximum_occurrences["get23:::max_depth"]=0
operation_parameters_maximum_occurrences["get23:::max_degree"]=0
operation_parameters_maximum_occurrences["get23:::capacity"]=0
operation_parameters_maximum_occurrences["get23:::limit"]=0
operation_parameters_maximum_occurrences["post13:::graph"]=0
operation_parameters_maximum_occurrences["post13:::Request"]=0
operation_parameters_maximum_occurrences["personalRank:::graph"]=0
operation_parameters_maximum_occurrences["personalRank:::RankRequest"]=0
operation_parameters_maximum_occurrences["create3:::graph"]=0
operation_parameters_maximum_occurrences["create3:::JsonProject"]=0
operation_parameters_maximum_occurrences["delete3:::graph"]=0
operation_parameters_maximum_occurrences["delete3:::id"]=0
operation_parameters_maximum_occurrences["get3:::graph"]=0
operation_parameters_maximum_occurrences["get3:::id"]=0
operation_parameters_maximum_occurrences["list3:::graph"]=0
operation_parameters_maximum_occurrences["list3:::limit"]=0
operation_parameters_maximum_occurrences["update3:::graph"]=0
operation_parameters_maximum_occurrences["update3:::id"]=0
operation_parameters_maximum_occurrences["update3:::action"]=0
operation_parameters_maximum_occurrences["update3:::JsonProject"]=0
operation_parameters_maximum_occurrences["create13:::graph"]=0
operation_parameters_maximum_occurrences["create13:::JsonPropertyKey"]=0
operation_parameters_maximum_occurrences["delete11:::graph"]=0
operation_parameters_maximum_occurrences["delete11:::name"]=0
operation_parameters_maximum_occurrences["get14:::graph"]=0
operation_parameters_maximum_occurrences["get14:::name"]=0
operation_parameters_maximum_occurrences["list14:::graph"]=0
operation_parameters_maximum_occurrences["list14:::names"]=0
operation_parameters_maximum_occurrences["update13:::graph"]=0
operation_parameters_maximum_occurrences["update13:::name"]=0
operation_parameters_maximum_occurrences["update13:::action"]=0
operation_parameters_maximum_occurrences["update13:::JsonPropertyKey"]=0
operation_parameters_maximum_occurrences["addPeer:::graph"]=0
operation_parameters_maximum_occurrences["addPeer:::group"]=0
operation_parameters_maximum_occurrences["addPeer:::endpoint"]=0
operation_parameters_maximum_occurrences["getLeader:::graph"]=0
operation_parameters_maximum_occurrences["getLeader:::group"]=0
operation_parameters_maximum_occurrences["listPeers:::graph"]=0
operation_parameters_maximum_occurrences["listPeers:::group"]=0
operation_parameters_maximum_occurrences["removePeer:::graph"]=0
operation_parameters_maximum_occurrences["removePeer:::group"]=0
operation_parameters_maximum_occurrences["removePeer:::endpoint"]=0
operation_parameters_maximum_occurrences["setLeader:::graph"]=0
operation_parameters_maximum_occurrences["setLeader:::group"]=0
operation_parameters_maximum_occurrences["setLeader:::endpoint"]=0
operation_parameters_maximum_occurrences["transferLeader:::graph"]=0
operation_parameters_maximum_occurrences["transferLeader:::group"]=0
operation_parameters_maximum_occurrences["transferLeader:::endpoint"]=0
operation_parameters_maximum_occurrences["get24:::graph"]=0
operation_parameters_maximum_occurrences["get24:::source"]=0
operation_parameters_maximum_occurrences["get24:::direction"]=0
operation_parameters_maximum_occurrences["get24:::label"]=0
operation_parameters_maximum_occurrences["get24:::max_depth"]=0
operation_parameters_maximum_occurrences["get24:::max_degree"]=0
operation_parameters_maximum_occurrences["get24:::capacity"]=0
operation_parameters_maximum_occurrences["get24:::limit"]=0
operation_parameters_maximum_occurrences["get24:::with_vertex"]=0
operation_parameters_maximum_occurrences["get24:::with_edge"]=0
operation_parameters_maximum_occurrences["edgeLabelRebuild:::graph"]=0
operation_parameters_maximum_occurrences["edgeLabelRebuild:::name"]=0
operation_parameters_maximum_occurrences["indexLabelRebuild:::graph"]=0
operation_parameters_maximum_occurrences["indexLabelRebuild:::name"]=0
operation_parameters_maximum_occurrences["vertexLabelRebuild:::graph"]=0
operation_parameters_maximum_occurrences["vertexLabelRebuild:::name"]=0
operation_parameters_maximum_occurrences["create15:::graph"]=0
operation_parameters_maximum_occurrences["create15:::vertex"]=0
operation_parameters_maximum_occurrences["create15:::other"]=0
operation_parameters_maximum_occurrences["create15:::direction"]=0
operation_parameters_maximum_occurrences["create15:::label"]=0
operation_parameters_maximum_occurrences["create15:::max_degree"]=0
operation_parameters_maximum_occurrences["create15:::limit"]=0
operation_parameters_maximum_occurrences["get25:::graph"]=0
operation_parameters_maximum_occurrences["get25:::source"]=0
operation_parameters_maximum_occurrences["get25:::direction"]=0
operation_parameters_maximum_occurrences["get25:::label"]=0
operation_parameters_maximum_occurrences["get25:::max_depth"]=0
operation_parameters_maximum_occurrences["get25:::source_in_ring"]=0
operation_parameters_maximum_occurrences["get25:::max_degree"]=0
operation_parameters_maximum_occurrences["get25:::capacity"]=0
operation_parameters_maximum_occurrences["get25:::limit"]=0
operation_parameters_maximum_occurrences["get25:::with_vertex"]=0
operation_parameters_maximum_occurrences["get25:::with_edge"]=0
operation_parameters_maximum_occurrences["get26:::graph"]=0
operation_parameters_maximum_occurrences["get26:::vertex"]=0
operation_parameters_maximum_occurrences["get26:::other"]=0
operation_parameters_maximum_occurrences["get26:::direction"]=0
operation_parameters_maximum_occurrences["get26:::label"]=0
operation_parameters_maximum_occurrences["get26:::max_degree"]=0
operation_parameters_maximum_occurrences["get26:::limit"]=0
operation_parameters_maximum_occurrences["sameNeighbors:::graph"]=0
operation_parameters_maximum_occurrences["sameNeighbors:::Request"]=0
operation_parameters_maximum_occurrences["list15:::graph"]=0
operation_parameters_maximum_occurrences["get27:::graph"]=0
operation_parameters_maximum_occurrences["get27:::source"]=0
operation_parameters_maximum_occurrences["get27:::target"]=0
operation_parameters_maximum_occurrences["get27:::direction"]=0
operation_parameters_maximum_occurrences["get27:::label"]=0
operation_parameters_maximum_occurrences["get27:::max_depth"]=0
operation_parameters_maximum_occurrences["get27:::max_degree"]=0
operation_parameters_maximum_occurrences["get27:::skip_degree"]=0
operation_parameters_maximum_occurrences["get27:::with_vertex"]=0
operation_parameters_maximum_occurrences["get27:::with_edge"]=0
operation_parameters_maximum_occurrences["get27:::capacity"]=0
operation_parameters_maximum_occurrences["get28:::graph"]=0
operation_parameters_maximum_occurrences["get28:::source"]=0
operation_parameters_maximum_occurrences["get28:::direction"]=0
operation_parameters_maximum_occurrences["get28:::label"]=0
operation_parameters_maximum_occurrences["get28:::weight"]=0
operation_parameters_maximum_occurrences["get28:::max_degree"]=0
operation_parameters_maximum_occurrences["get28:::skip_degree"]=0
operation_parameters_maximum_occurrences["get28:::with_vertex"]=0
operation_parameters_maximum_occurrences["get28:::with_edge"]=0
operation_parameters_maximum_occurrences["get28:::capacity"]=0
operation_parameters_maximum_occurrences["get28:::limit"]=0
operation_parameters_maximum_occurrences["create4:::graph"]=0
operation_parameters_maximum_occurrences["create4:::JsonTarget"]=0
operation_parameters_maximum_occurrences["delete4:::graph"]=0
operation_parameters_maximum_occurrences["delete4:::id"]=0
operation_parameters_maximum_occurrences["get4:::graph"]=0
operation_parameters_maximum_occurrences["get4:::id"]=0
operation_parameters_maximum_occurrences["list4:::graph"]=0
operation_parameters_maximum_occurrences["list4:::limit"]=0
operation_parameters_maximum_occurrences["update4:::graph"]=0
operation_parameters_maximum_occurrences["update4:::id"]=0
operation_parameters_maximum_occurrences["update4:::JsonTarget"]=0
operation_parameters_maximum_occurrences["delete8:::graph"]=0
operation_parameters_maximum_occurrences["delete8:::id"]=0
operation_parameters_maximum_occurrences["delete8:::force"]=0
operation_parameters_maximum_occurrences["get10:::graph"]=0
operation_parameters_maximum_occurrences["get10:::id"]=0
operation_parameters_maximum_occurrences["list8:::graph"]=0
operation_parameters_maximum_occurrences["list8:::status"]=0
operation_parameters_maximum_occurrences["list8:::ids"]=0
operation_parameters_maximum_occurrences["list8:::limit"]=0
operation_parameters_maximum_occurrences["list8:::page"]=0
operation_parameters_maximum_occurrences["update10:::graph"]=0
operation_parameters_maximum_occurrences["update10:::id"]=0
operation_parameters_maximum_occurrences["update10:::action"]=0
operation_parameters_maximum_occurrences["post14:::graph"]=0
operation_parameters_maximum_occurrences["post14:::Request"]=0
operation_parameters_maximum_occurrences["trace:::body"]=0
operation_parameters_maximum_occurrences["create5:::graph"]=0
operation_parameters_maximum_occurrences["create5:::JsonUser"]=0
operation_parameters_maximum_occurrences["delete5:::graph"]=0
operation_parameters_maximum_occurrences["delete5:::id"]=0
operation_parameters_maximum_occurrences["get5:::graph"]=0
operation_parameters_maximum_occurrences["get5:::id"]=0
operation_parameters_maximum_occurrences["list5:::graph"]=0
operation_parameters_maximum_occurrences["list5:::limit"]=0
operation_parameters_maximum_occurrences["role:::graph"]=0
operation_parameters_maximum_occurrences["role:::id"]=0
operation_parameters_maximum_occurrences["update5:::graph"]=0
operation_parameters_maximum_occurrences["update5:::id"]=0
operation_parameters_maximum_occurrences["update5:::JsonUser"]=0
operation_parameters_maximum_occurrences["delete13:::graph"]=0
operation_parameters_maximum_occurrences["delete13:::key"]=0
operation_parameters_maximum_occurrences["get30:::graph"]=0
operation_parameters_maximum_occurrences["get30:::key"]=0
operation_parameters_maximum_occurrences["list19:::graph"]=0
operation_parameters_maximum_occurrences["update15:::graph"]=0
operation_parameters_maximum_occurrences["update15:::key"]=0
operation_parameters_maximum_occurrences["update15:::JsonVariableValue"]=0
operation_parameters_maximum_occurrences["create8:::graph"]=0
operation_parameters_maximum_occurrences["create8:::JsonVertex"]=0
operation_parameters_maximum_occurrences["create9:::graph"]=0
operation_parameters_maximum_occurrences["create9:::JsonVertex"]=0
operation_parameters_maximum_occurrences["delete7:::graph"]=0
operation_parameters_maximum_occurrences["delete7:::id"]=0
operation_parameters_maximum_occurrences["delete7:::label"]=0
operation_parameters_maximum_occurrences["get8:::graph"]=0
operation_parameters_maximum_occurrences["get8:::id"]=0
operation_parameters_maximum_occurrences["list7:::graph"]=0
operation_parameters_maximum_occurrences["list7:::label"]=0
operation_parameters_maximum_occurrences["list7:::properties"]=0
operation_parameters_maximum_occurrences["list7:::keep_start_p"]=0
operation_parameters_maximum_occurrences["list7:::offset"]=0
operation_parameters_maximum_occurrences["list7:::page"]=0
operation_parameters_maximum_occurrences["list7:::limit"]=0
operation_parameters_maximum_occurrences["update8:::graph"]=0
operation_parameters_maximum_occurrences["update8:::BatchVertexRequest"]=0
operation_parameters_maximum_occurrences["update9:::graph"]=0
operation_parameters_maximum_occurrences["update9:::id"]=0
operation_parameters_maximum_occurrences["update9:::action"]=0
operation_parameters_maximum_occurrences["update9:::JsonVertex"]=0
operation_parameters_maximum_occurrences["create14:::graph"]=0
operation_parameters_maximum_occurrences["create14:::JsonVertexLabel"]=0
operation_parameters_maximum_occurrences["delete12:::graph"]=0
operation_parameters_maximum_occurrences["delete12:::name"]=0
operation_parameters_maximum_occurrences["get15:::graph"]=0
operation_parameters_maximum_occurrences["get15:::name"]=0
operation_parameters_maximum_occurrences["list16:::graph"]=0
operation_parameters_maximum_occurrences["list16:::names"]=0
operation_parameters_maximum_occurrences["update14:::graph"]=0
operation_parameters_maximum_occurrences["update14:::name"]=0
operation_parameters_maximum_occurrences["update14:::action"]=0
operation_parameters_maximum_occurrences["update14:::JsonVertexLabel"]=0
operation_parameters_maximum_occurrences["list18:::graph"]=0
operation_parameters_maximum_occurrences["list18:::ids"]=0
operation_parameters_maximum_occurrences["scan1:::graph"]=0
operation_parameters_maximum_occurrences["scan1:::start"]=0
operation_parameters_maximum_occurrences["scan1:::end"]=0
operation_parameters_maximum_occurrences["scan1:::page"]=0
operation_parameters_maximum_occurrences["scan1:::page_limit"]=0
operation_parameters_maximum_occurrences["shards1:::graph"]=0
operation_parameters_maximum_occurrences["shards1:::split_size"]=0
operation_parameters_maximum_occurrences["get29:::graph"]=0
operation_parameters_maximum_occurrences["get29:::source"]=0
operation_parameters_maximum_occurrences["get29:::target"]=0
operation_parameters_maximum_occurrences["get29:::direction"]=0
operation_parameters_maximum_occurrences["get29:::label"]=0
operation_parameters_maximum_occurrences["get29:::weight"]=0
operation_parameters_maximum_occurrences["get29:::max_degree"]=0
operation_parameters_maximum_occurrences["get29:::skip_degree"]=0
operation_parameters_maximum_occurrences["get29:::with_vertex"]=0
operation_parameters_maximum_occurrences["get29:::with_edge"]=0
operation_parameters_maximum_occurrences["get29:::capacity"]=0
operation_parameters_maximum_occurrences["updateStatus:::status"]=0
operation_parameters_maximum_occurrences["updateWhiteIPs:::request_body"]=0

##
# The type of collection for specifying multiple values for parameter:
# - multi, csv, ssv, tsv
declare -A operation_parameters_collection_type
operation_parameters_collection_type["create:::graph"]=""
operation_parameters_collection_type["create:::JsonAccess"]=""
operation_parameters_collection_type["delete:::graph"]=""
operation_parameters_collection_type["delete:::id"]=""
operation_parameters_collection_type["get:::graph"]=""
operation_parameters_collection_type["get:::id"]=""
operation_parameters_collection_type["list:::graph"]=""
operation_parameters_collection_type["list:::group"]=""
operation_parameters_collection_type["list:::target"]=""
operation_parameters_collection_type["list:::limit"]=""
operation_parameters_collection_type["update:::graph"]=""
operation_parameters_collection_type["update:::id"]=""
operation_parameters_collection_type["update:::JsonAccess"]=""
operation_parameters_collection_type["get16:::graph"]=""
operation_parameters_collection_type["get16:::vertex"]=""
operation_parameters_collection_type["get16:::other"]=""
operation_parameters_collection_type["get16:::direction"]=""
operation_parameters_collection_type["get16:::label"]=""
operation_parameters_collection_type["get16:::max_degree"]=""
operation_parameters_collection_type["get16:::limit"]=""
operation_parameters_collection_type["post2:::graph"]=""
operation_parameters_collection_type["post2:::name"]=""
operation_parameters_collection_type["post2:::request_body"]=
operation_parameters_collection_type["get17:::graph"]=""
operation_parameters_collection_type["get17:::source"]=""
operation_parameters_collection_type["get17:::target"]=""
operation_parameters_collection_type["get17:::direction"]=""
operation_parameters_collection_type["get17:::label"]=""
operation_parameters_collection_type["get17:::max_depth"]=""
operation_parameters_collection_type["get17:::max_degree"]=""
operation_parameters_collection_type["get17:::skip_degree"]=""
operation_parameters_collection_type["get17:::with_vertex"]=""
operation_parameters_collection_type["get17:::with_edge"]=""
operation_parameters_collection_type["get17:::capacity"]=""
operation_parameters_collection_type["create1:::graph"]=""
operation_parameters_collection_type["create1:::JsonBelong"]=""
operation_parameters_collection_type["delete1:::graph"]=""
operation_parameters_collection_type["delete1:::id"]=""
operation_parameters_collection_type["get1:::graph"]=""
operation_parameters_collection_type["get1:::id"]=""
operation_parameters_collection_type["list1:::graph"]=""
operation_parameters_collection_type["list1:::user"]=""
operation_parameters_collection_type["list1:::group"]=""
operation_parameters_collection_type["list1:::limit"]=""
operation_parameters_collection_type["update1:::graph"]=""
operation_parameters_collection_type["update1:::id"]=""
operation_parameters_collection_type["update1:::JsonBelong"]=""
operation_parameters_collection_type["post3:::graph"]=""
operation_parameters_collection_type["post3:::name"]=""
operation_parameters_collection_type["post3:::request_body"]=
operation_parameters_collection_type["post5:::graph"]=""
operation_parameters_collection_type["post5:::CountRequest"]=""
operation_parameters_collection_type["get18:::graph"]=""
operation_parameters_collection_type["get18:::source"]=""
operation_parameters_collection_type["get18:::target"]=""
operation_parameters_collection_type["get18:::direction"]=""
operation_parameters_collection_type["get18:::label"]=""
operation_parameters_collection_type["get18:::max_depth"]=""
operation_parameters_collection_type["get18:::max_degree"]=""
operation_parameters_collection_type["get18:::capacity"]=""
operation_parameters_collection_type["get18:::limit"]=""
operation_parameters_collection_type["post6:::graph"]=""
operation_parameters_collection_type["post6:::CrosspointsRequest"]=""
operation_parameters_collection_type["post7:::graph"]=""
operation_parameters_collection_type["post7:::PathRequest"]=""
operation_parameters_collection_type["post:::graph"]=""
operation_parameters_collection_type["post:::body"]=""
operation_parameters_collection_type["query:::graph"]=""
operation_parameters_collection_type["query:::cypher"]=""
operation_parameters_collection_type["getExternalGrammar:::path"]=""
operation_parameters_collection_type["create6:::graph"]=""
operation_parameters_collection_type["create6:::JsonEdge"]=""
operation_parameters_collection_type["create7:::graph"]=""
operation_parameters_collection_type["create7:::check_vertex"]=""
operation_parameters_collection_type["create7:::JsonEdge"]=
operation_parameters_collection_type["delete6:::graph"]=""
operation_parameters_collection_type["delete6:::id"]=""
operation_parameters_collection_type["delete6:::label"]=""
operation_parameters_collection_type["get7:::graph"]=""
operation_parameters_collection_type["get7:::id"]=""
operation_parameters_collection_type["list6:::graph"]=""
operation_parameters_collection_type["list6:::vertex_id"]=""
operation_parameters_collection_type["list6:::direction"]=""
operation_parameters_collection_type["list6:::label"]=""
operation_parameters_collection_type["list6:::properties"]=""
operation_parameters_collection_type["list6:::keep_start_p"]=""
operation_parameters_collection_type["list6:::offset"]=""
operation_parameters_collection_type["list6:::page"]=""
operation_parameters_collection_type["list6:::limit"]=""
operation_parameters_collection_type["update6:::graph"]=""
operation_parameters_collection_type["update6:::BatchEdgeRequest"]=""
operation_parameters_collection_type["update7:::graph"]=""
operation_parameters_collection_type["update7:::id"]=""
operation_parameters_collection_type["update7:::action"]=""
operation_parameters_collection_type["update7:::JsonEdge"]=""
operation_parameters_collection_type["get19:::graph"]=""
operation_parameters_collection_type["get19:::source"]=""
operation_parameters_collection_type["get19:::target"]=""
operation_parameters_collection_type["get19:::label"]=""
operation_parameters_collection_type["get19:::sort_values"]=""
operation_parameters_collection_type["get19:::limit"]=""
operation_parameters_collection_type["create11:::graph"]=""
operation_parameters_collection_type["create11:::JsonEdgeLabel"]=""
operation_parameters_collection_type["delete9:::graph"]=""
operation_parameters_collection_type["delete9:::name"]=""
operation_parameters_collection_type["get12:::graph"]=""
operation_parameters_collection_type["get12:::name"]=""
operation_parameters_collection_type["list12:::graph"]=""
operation_parameters_collection_type["list12:::names"]="multi"
operation_parameters_collection_type["update11:::graph"]=""
operation_parameters_collection_type["update11:::name"]=""
operation_parameters_collection_type["update11:::action"]=""
operation_parameters_collection_type["update11:::JsonEdgeLabel"]=""
operation_parameters_collection_type["list17:::graph"]=""
operation_parameters_collection_type["list17:::ids"]="multi"
operation_parameters_collection_type["scan:::graph"]=""
operation_parameters_collection_type["scan:::start"]=""
operation_parameters_collection_type["scan:::end"]=""
operation_parameters_collection_type["scan:::page"]=""
operation_parameters_collection_type["scan:::page_limit"]=""
operation_parameters_collection_type["shards:::graph"]=""
operation_parameters_collection_type["shards:::split_size"]=""
operation_parameters_collection_type["post8:::graph"]=""
operation_parameters_collection_type["post8:::FusiformSimilarityRequest"]=""
operation_parameters_collection_type["clear:::name"]=""
operation_parameters_collection_type["clear:::confirm_message"]=""
operation_parameters_collection_type["compact:::name"]=""
operation_parameters_collection_type["create10:::name"]=""
operation_parameters_collection_type["create10:::clone_graph_name"]=""
operation_parameters_collection_type["create10:::body"]=""
operation_parameters_collection_type["createSnapshot:::name"]=""
operation_parameters_collection_type["drop:::name"]=""
operation_parameters_collection_type["drop:::confirm_message"]=""
operation_parameters_collection_type["get11:::name"]=""
operation_parameters_collection_type["getConf:::name"]=""
operation_parameters_collection_type["graphReadMode:::name"]=""
operation_parameters_collection_type["graphReadMode1:::name"]=""
operation_parameters_collection_type["graphReadMode1:::body"]=""
operation_parameters_collection_type["mode:::name"]=""
operation_parameters_collection_type["mode1:::name"]=""
operation_parameters_collection_type["mode1:::body"]=""
operation_parameters_collection_type["resumeSnapshot:::name"]=""
operation_parameters_collection_type["post1:::body"]=""
operation_parameters_collection_type["post4:::graph"]=""
operation_parameters_collection_type["post4:::GremlinRequest"]=""
operation_parameters_collection_type["create2:::graph"]=""
operation_parameters_collection_type["create2:::JsonGroup"]=""
operation_parameters_collection_type["delete2:::graph"]=""
operation_parameters_collection_type["delete2:::id"]=""
operation_parameters_collection_type["get2:::graph"]=""
operation_parameters_collection_type["get2:::id"]=""
operation_parameters_collection_type["list2:::graph"]=""
operation_parameters_collection_type["list2:::limit"]=""
operation_parameters_collection_type["update2:::graph"]=""
operation_parameters_collection_type["update2:::id"]=""
operation_parameters_collection_type["update2:::JsonGroup"]=""
operation_parameters_collection_type["create12:::graph"]=""
operation_parameters_collection_type["create12:::JsonIndexLabel"]=""
operation_parameters_collection_type["delete10:::graph"]=""
operation_parameters_collection_type["delete10:::name"]=""
operation_parameters_collection_type["get13:::graph"]=""
operation_parameters_collection_type["get13:::name"]=""
operation_parameters_collection_type["list13:::graph"]=""
operation_parameters_collection_type["list13:::names"]="multi"
operation_parameters_collection_type["update12:::graph"]=""
operation_parameters_collection_type["update12:::name"]=""
operation_parameters_collection_type["update12:::action"]=""
operation_parameters_collection_type["update12:::JsonIndexLabel"]=""
operation_parameters_collection_type["get20:::graph"]=""
operation_parameters_collection_type["get20:::vertex"]=""
operation_parameters_collection_type["get20:::other"]=""
operation_parameters_collection_type["get20:::direction"]=""
operation_parameters_collection_type["get20:::label"]=""
operation_parameters_collection_type["get20:::max_degree"]=""
operation_parameters_collection_type["post9:::graph"]=""
operation_parameters_collection_type["post9:::Request"]=""
operation_parameters_collection_type["get21:::graph"]=""
operation_parameters_collection_type["get21:::source"]=""
operation_parameters_collection_type["get21:::direction"]=""
operation_parameters_collection_type["get21:::label"]=""
operation_parameters_collection_type["get21:::max_depth"]=""
operation_parameters_collection_type["get21:::count_only"]=""
operation_parameters_collection_type["get21:::max_degree"]=""
operation_parameters_collection_type["get21:::limit"]=""
operation_parameters_collection_type["post10:::graph"]=""
operation_parameters_collection_type["post10:::Request"]=""
operation_parameters_collection_type["get22:::graph"]=""
operation_parameters_collection_type["get22:::source"]=""
operation_parameters_collection_type["get22:::direction"]=""
operation_parameters_collection_type["get22:::label"]=""
operation_parameters_collection_type["get22:::max_depth"]=""
operation_parameters_collection_type["get22:::nearest"]=""
operation_parameters_collection_type["get22:::count_only"]=""
operation_parameters_collection_type["get22:::max_degree"]=""
operation_parameters_collection_type["get22:::capacity"]=""
operation_parameters_collection_type["get22:::limit"]=""
operation_parameters_collection_type["post11:::graph"]=""
operation_parameters_collection_type["post11:::Request"]=""
operation_parameters_collection_type["login:::graph"]=""
operation_parameters_collection_type["login:::JsonLogin"]=""
operation_parameters_collection_type["logout:::graph"]=""
operation_parameters_collection_type["logout:::Authorization"]=""
operation_parameters_collection_type["verifyToken:::graph"]=""
operation_parameters_collection_type["verifyToken:::Authorization"]=""
operation_parameters_collection_type["all:::type"]=""
operation_parameters_collection_type["statistics:::type"]=""
operation_parameters_collection_type["post12:::graph"]=""
operation_parameters_collection_type["post12:::Request"]=""
operation_parameters_collection_type["neighborRank:::graph"]=""
operation_parameters_collection_type["neighborRank:::RankRequest"]=""
operation_parameters_collection_type["get23:::graph"]=""
operation_parameters_collection_type["get23:::source"]=""
operation_parameters_collection_type["get23:::target"]=""
operation_parameters_collection_type["get23:::direction"]=""
operation_parameters_collection_type["get23:::label"]=""
operation_parameters_collection_type["get23:::max_depth"]=""
operation_parameters_collection_type["get23:::max_degree"]=""
operation_parameters_collection_type["get23:::capacity"]=""
operation_parameters_collection_type["get23:::limit"]=""
operation_parameters_collection_type["post13:::graph"]=""
operation_parameters_collection_type["post13:::Request"]=""
operation_parameters_collection_type["personalRank:::graph"]=""
operation_parameters_collection_type["personalRank:::RankRequest"]=""
operation_parameters_collection_type["create3:::graph"]=""
operation_parameters_collection_type["create3:::JsonProject"]=""
operation_parameters_collection_type["delete3:::graph"]=""
operation_parameters_collection_type["delete3:::id"]=""
operation_parameters_collection_type["get3:::graph"]=""
operation_parameters_collection_type["get3:::id"]=""
operation_parameters_collection_type["list3:::graph"]=""
operation_parameters_collection_type["list3:::limit"]=""
operation_parameters_collection_type["update3:::graph"]=""
operation_parameters_collection_type["update3:::id"]=""
operation_parameters_collection_type["update3:::action"]=""
operation_parameters_collection_type["update3:::JsonProject"]=""
operation_parameters_collection_type["create13:::graph"]=""
operation_parameters_collection_type["create13:::JsonPropertyKey"]=""
operation_parameters_collection_type["delete11:::graph"]=""
operation_parameters_collection_type["delete11:::name"]=""
operation_parameters_collection_type["get14:::graph"]=""
operation_parameters_collection_type["get14:::name"]=""
operation_parameters_collection_type["list14:::graph"]=""
operation_parameters_collection_type["list14:::names"]="multi"
operation_parameters_collection_type["update13:::graph"]=""
operation_parameters_collection_type["update13:::name"]=""
operation_parameters_collection_type["update13:::action"]=""
operation_parameters_collection_type["update13:::JsonPropertyKey"]=""
operation_parameters_collection_type["addPeer:::graph"]=""
operation_parameters_collection_type["addPeer:::group"]=""
operation_parameters_collection_type["addPeer:::endpoint"]=""
operation_parameters_collection_type["getLeader:::graph"]=""
operation_parameters_collection_type["getLeader:::group"]=""
operation_parameters_collection_type["listPeers:::graph"]=""
operation_parameters_collection_type["listPeers:::group"]=""
operation_parameters_collection_type["removePeer:::graph"]=""
operation_parameters_collection_type["removePeer:::group"]=""
operation_parameters_collection_type["removePeer:::endpoint"]=""
operation_parameters_collection_type["setLeader:::graph"]=""
operation_parameters_collection_type["setLeader:::group"]=""
operation_parameters_collection_type["setLeader:::endpoint"]=""
operation_parameters_collection_type["transferLeader:::graph"]=""
operation_parameters_collection_type["transferLeader:::group"]=""
operation_parameters_collection_type["transferLeader:::endpoint"]=""
operation_parameters_collection_type["get24:::graph"]=""
operation_parameters_collection_type["get24:::source"]=""
operation_parameters_collection_type["get24:::direction"]=""
operation_parameters_collection_type["get24:::label"]=""
operation_parameters_collection_type["get24:::max_depth"]=""
operation_parameters_collection_type["get24:::max_degree"]=""
operation_parameters_collection_type["get24:::capacity"]=""
operation_parameters_collection_type["get24:::limit"]=""
operation_parameters_collection_type["get24:::with_vertex"]=""
operation_parameters_collection_type["get24:::with_edge"]=""
operation_parameters_collection_type["edgeLabelRebuild:::graph"]=""
operation_parameters_collection_type["edgeLabelRebuild:::name"]=""
operation_parameters_collection_type["indexLabelRebuild:::graph"]=""
operation_parameters_collection_type["indexLabelRebuild:::name"]=""
operation_parameters_collection_type["vertexLabelRebuild:::graph"]=""
operation_parameters_collection_type["vertexLabelRebuild:::name"]=""
operation_parameters_collection_type["create15:::graph"]=""
operation_parameters_collection_type["create15:::vertex"]=""
operation_parameters_collection_type["create15:::other"]=""
operation_parameters_collection_type["create15:::direction"]=""
operation_parameters_collection_type["create15:::label"]=""
operation_parameters_collection_type["create15:::max_degree"]=""
operation_parameters_collection_type["create15:::limit"]=""
operation_parameters_collection_type["get25:::graph"]=""
operation_parameters_collection_type["get25:::source"]=""
operation_parameters_collection_type["get25:::direction"]=""
operation_parameters_collection_type["get25:::label"]=""
operation_parameters_collection_type["get25:::max_depth"]=""
operation_parameters_collection_type["get25:::source_in_ring"]=""
operation_parameters_collection_type["get25:::max_degree"]=""
operation_parameters_collection_type["get25:::capacity"]=""
operation_parameters_collection_type["get25:::limit"]=""
operation_parameters_collection_type["get25:::with_vertex"]=""
operation_parameters_collection_type["get25:::with_edge"]=""
operation_parameters_collection_type["get26:::graph"]=""
operation_parameters_collection_type["get26:::vertex"]=""
operation_parameters_collection_type["get26:::other"]=""
operation_parameters_collection_type["get26:::direction"]=""
operation_parameters_collection_type["get26:::label"]=""
operation_parameters_collection_type["get26:::max_degree"]=""
operation_parameters_collection_type["get26:::limit"]=""
operation_parameters_collection_type["sameNeighbors:::graph"]=""
operation_parameters_collection_type["sameNeighbors:::Request"]=""
operation_parameters_collection_type["list15:::graph"]=""
operation_parameters_collection_type["get27:::graph"]=""
operation_parameters_collection_type["get27:::source"]=""
operation_parameters_collection_type["get27:::target"]=""
operation_parameters_collection_type["get27:::direction"]=""
operation_parameters_collection_type["get27:::label"]=""
operation_parameters_collection_type["get27:::max_depth"]=""
operation_parameters_collection_type["get27:::max_degree"]=""
operation_parameters_collection_type["get27:::skip_degree"]=""
operation_parameters_collection_type["get27:::with_vertex"]=""
operation_parameters_collection_type["get27:::with_edge"]=""
operation_parameters_collection_type["get27:::capacity"]=""
operation_parameters_collection_type["get28:::graph"]=""
operation_parameters_collection_type["get28:::source"]=""
operation_parameters_collection_type["get28:::direction"]=""
operation_parameters_collection_type["get28:::label"]=""
operation_parameters_collection_type["get28:::weight"]=""
operation_parameters_collection_type["get28:::max_degree"]=""
operation_parameters_collection_type["get28:::skip_degree"]=""
operation_parameters_collection_type["get28:::with_vertex"]=""
operation_parameters_collection_type["get28:::with_edge"]=""
operation_parameters_collection_type["get28:::capacity"]=""
operation_parameters_collection_type["get28:::limit"]=""
operation_parameters_collection_type["create4:::graph"]=""
operation_parameters_collection_type["create4:::JsonTarget"]=""
operation_parameters_collection_type["delete4:::graph"]=""
operation_parameters_collection_type["delete4:::id"]=""
operation_parameters_collection_type["get4:::graph"]=""
operation_parameters_collection_type["get4:::id"]=""
operation_parameters_collection_type["list4:::graph"]=""
operation_parameters_collection_type["list4:::limit"]=""
operation_parameters_collection_type["update4:::graph"]=""
operation_parameters_collection_type["update4:::id"]=""
operation_parameters_collection_type["update4:::JsonTarget"]=""
operation_parameters_collection_type["delete8:::graph"]=""
operation_parameters_collection_type["delete8:::id"]=""
operation_parameters_collection_type["delete8:::force"]=""
operation_parameters_collection_type["get10:::graph"]=""
operation_parameters_collection_type["get10:::id"]=""
operation_parameters_collection_type["list8:::graph"]=""
operation_parameters_collection_type["list8:::status"]=""
operation_parameters_collection_type["list8:::ids"]="multi"
operation_parameters_collection_type["list8:::limit"]=""
operation_parameters_collection_type["list8:::page"]=""
operation_parameters_collection_type["update10:::graph"]=""
operation_parameters_collection_type["update10:::id"]=""
operation_parameters_collection_type["update10:::action"]=""
operation_parameters_collection_type["post14:::graph"]=""
operation_parameters_collection_type["post14:::Request"]=""
operation_parameters_collection_type["trace:::body"]=""
operation_parameters_collection_type["create5:::graph"]=""
operation_parameters_collection_type["create5:::JsonUser"]=""
operation_parameters_collection_type["delete5:::graph"]=""
operation_parameters_collection_type["delete5:::id"]=""
operation_parameters_collection_type["get5:::graph"]=""
operation_parameters_collection_type["get5:::id"]=""
operation_parameters_collection_type["list5:::graph"]=""
operation_parameters_collection_type["list5:::limit"]=""
operation_parameters_collection_type["role:::graph"]=""
operation_parameters_collection_type["role:::id"]=""
operation_parameters_collection_type["update5:::graph"]=""
operation_parameters_collection_type["update5:::id"]=""
operation_parameters_collection_type["update5:::JsonUser"]=""
operation_parameters_collection_type["delete13:::graph"]=""
operation_parameters_collection_type["delete13:::key"]=""
operation_parameters_collection_type["get30:::graph"]=""
operation_parameters_collection_type["get30:::key"]=""
operation_parameters_collection_type["list19:::graph"]=""
operation_parameters_collection_type["update15:::graph"]=""
operation_parameters_collection_type["update15:::key"]=""
operation_parameters_collection_type["update15:::JsonVariableValue"]=""
operation_parameters_collection_type["create8:::graph"]=""
operation_parameters_collection_type["create8:::JsonVertex"]=""
operation_parameters_collection_type["create9:::graph"]=""
operation_parameters_collection_type["create9:::JsonVertex"]=
operation_parameters_collection_type["delete7:::graph"]=""
operation_parameters_collection_type["delete7:::id"]=""
operation_parameters_collection_type["delete7:::label"]=""
operation_parameters_collection_type["get8:::graph"]=""
operation_parameters_collection_type["get8:::id"]=""
operation_parameters_collection_type["list7:::graph"]=""
operation_parameters_collection_type["list7:::label"]=""
operation_parameters_collection_type["list7:::properties"]=""
operation_parameters_collection_type["list7:::keep_start_p"]=""
operation_parameters_collection_type["list7:::offset"]=""
operation_parameters_collection_type["list7:::page"]=""
operation_parameters_collection_type["list7:::limit"]=""
operation_parameters_collection_type["update8:::graph"]=""
operation_parameters_collection_type["update8:::BatchVertexRequest"]=""
operation_parameters_collection_type["update9:::graph"]=""
operation_parameters_collection_type["update9:::id"]=""
operation_parameters_collection_type["update9:::action"]=""
operation_parameters_collection_type["update9:::JsonVertex"]=""
operation_parameters_collection_type["create14:::graph"]=""
operation_parameters_collection_type["create14:::JsonVertexLabel"]=""
operation_parameters_collection_type["delete12:::graph"]=""
operation_parameters_collection_type["delete12:::name"]=""
operation_parameters_collection_type["get15:::graph"]=""
operation_parameters_collection_type["get15:::name"]=""
operation_parameters_collection_type["list16:::graph"]=""
operation_parameters_collection_type["list16:::names"]="multi"
operation_parameters_collection_type["update14:::graph"]=""
operation_parameters_collection_type["update14:::name"]=""
operation_parameters_collection_type["update14:::action"]=""
operation_parameters_collection_type["update14:::JsonVertexLabel"]=""
operation_parameters_collection_type["list18:::graph"]=""
operation_parameters_collection_type["list18:::ids"]="multi"
operation_parameters_collection_type["scan1:::graph"]=""
operation_parameters_collection_type["scan1:::start"]=""
operation_parameters_collection_type["scan1:::end"]=""
operation_parameters_collection_type["scan1:::page"]=""
operation_parameters_collection_type["scan1:::page_limit"]=""
operation_parameters_collection_type["shards1:::graph"]=""
operation_parameters_collection_type["shards1:::split_size"]=""
operation_parameters_collection_type["get29:::graph"]=""
operation_parameters_collection_type["get29:::source"]=""
operation_parameters_collection_type["get29:::target"]=""
operation_parameters_collection_type["get29:::direction"]=""
operation_parameters_collection_type["get29:::label"]=""
operation_parameters_collection_type["get29:::weight"]=""
operation_parameters_collection_type["get29:::max_degree"]=""
operation_parameters_collection_type["get29:::skip_degree"]=""
operation_parameters_collection_type["get29:::with_vertex"]=""
operation_parameters_collection_type["get29:::with_edge"]=""
operation_parameters_collection_type["get29:::capacity"]=""
operation_parameters_collection_type["updateStatus:::status"]=""
operation_parameters_collection_type["updateWhiteIPs:::request_body"]=


##
# Map for body parameters passed after operation as
# PARAMETER==STRING_VALUE or PARAMETER:=NUMERIC_VALUE
# These will be mapped to top level json keys ( { "PARAMETER": "VALUE" })
declare -A body_parameters

##
# These arguments will be directly passed to cURL
curl_arguments=""

##
# The host for making the request
host=""

##
# The user credentials for basic authentication
basic_auth_credential=""


##
# If true, the script will only output the actual cURL command that would be
# used
print_curl=false

##
# The operation ID passed on the command line
operation=""

##
# The provided Accept header value
header_accept=""

##
# The provided Content-type header value
header_content_type=""

##
# If there is any body content on the stdin pass it to the body of the request
body_content_temp_file=""

##
# If this variable is set to true, the request will be performed even
# if parameters for required query, header or body values are not provided
# (path parameters are still required).
force=false

##
# Declare some mime types abbreviations for easier content-type and accepts
# headers specification
declare -A mime_type_abbreviations
# text/*
mime_type_abbreviations["text"]="text/plain"
mime_type_abbreviations["html"]="text/html"
mime_type_abbreviations["md"]="text/x-markdown"
mime_type_abbreviations["csv"]="text/csv"
mime_type_abbreviations["css"]="text/css"
mime_type_abbreviations["rtf"]="text/rtf"
# application/*
mime_type_abbreviations["json"]="application/json"
mime_type_abbreviations["xml"]="application/xml"
mime_type_abbreviations["yaml"]="application/yaml"
mime_type_abbreviations["js"]="application/javascript"
mime_type_abbreviations["bin"]="application/octet-stream"
mime_type_abbreviations["rdf"]="application/rdf+xml"
# image/*
mime_type_abbreviations["jpg"]="image/jpeg"
mime_type_abbreviations["png"]="image/png"
mime_type_abbreviations["gif"]="image/gif"
mime_type_abbreviations["bmp"]="image/bmp"
mime_type_abbreviations["tiff"]="image/tiff"


##############################################################################
#
# Escape special URL characters
# Based on table at http://www.w3schools.com/tags/ref_urlencode.asp
#
##############################################################################
url_escape() {
    local raw_url="$1"

    value=$(sed -e 's/ /%20/g' \
       -e 's/!/%21/g' \
       -e 's/"/%22/g' \
       -e 's/#/%23/g' \
       -e 's/\&/%26/g' \
       -e 's/'\''/%28/g' \
       -e 's/(/%28/g' \
       -e 's/)/%29/g' \
       -e 's/:/%3A/g' \
       -e 's/\\t/%09/g' \
       -e 's/?/%3F/g' <<<"$raw_url");

    echo "$value"
}

##############################################################################
#
# Lookup the mime type abbreviation in the mime_type_abbreviations array.
# If not present assume the user provided a valid mime type
#
##############################################################################
lookup_mime_type() {
    local mime_type="$1"

    if [[ ${mime_type_abbreviations[$mime_type]} ]]; then
        echo "${mime_type_abbreviations[$mime_type]}"
    else
        echo "$mime_type"
    fi
}

##############################################################################
#
# Converts an associative array into a list of cURL header
# arguments (-H "KEY: VALUE")
#
##############################################################################
header_arguments_to_curl() {
    local headers_curl=""

    for key in "${!header_arguments[@]}"; do
        headers_curl+="-H \"${key}: ${header_arguments[${key}]}\" "
    done
    headers_curl+=" "

    echo "${headers_curl}"
}

##############################################################################
#
# Converts an associative array into a simple JSON with keys as top
# level object attributes
#
# \todo Add conversion of more complex attributes using paths
#
##############################################################################
body_parameters_to_json() {
    if [[ $RAW_BODY == "1" ]]; then
        echo "-d '${body_parameters["RAW_BODY"]}'"
    else
        local body_json="-d '{"
        local count=0
        for key in "${!body_parameters[@]}"; do
            if [[ $((count++)) -gt 0 ]]; then
                body_json+=", "
            fi
            body_json+="\"${key}\": ${body_parameters[${key}]}"
        done
        body_json+="}'"

        if [[ "${#body_parameters[@]}" -eq 0 ]]; then
            echo ""
        else
            echo "${body_json}"
        fi
    fi
}

##############################################################################
#
# Converts an associative array into form urlencoded string
#
##############################################################################
body_parameters_to_form_urlencoded() {
    local body_form_urlencoded="-d '"
    local count=0
    for key in "${!body_parameters[@]}"; do
        if [[ $((count++)) -gt 0 ]]; then
            body_form_urlencoded+="&"
        fi
        body_form_urlencoded+="${key}=${body_parameters[${key}]}"
    done
    body_form_urlencoded+="'"

    if [[ "${#body_parameters[@]}" -eq 0 ]]; then
        echo ""
    else
        echo "${body_form_urlencoded}"
    fi
}

##############################################################################
#
# Helper method for showing error because for example echo in
# build_request_path() is evaluated as part of command line not printed on
# output. Anyway better idea for resource clean up ;-).
#
##############################################################################
ERROR_MSG=""
function finish {
    if [[ -n "$ERROR_MSG" ]]; then
        echo >&2 "${OFF}${RED}$ERROR_MSG"
        echo >&2 "${OFF}Check usage: '${script_name} --help'"
    fi
}
trap finish EXIT


##############################################################################
#
# Validate and build request path including query parameters
#
##############################################################################
build_request_path() {
    local path_template=$1
    local -n path_params=$2
    local -n query_params=$3


    #
    # Check input parameters count against minimum and maximum required
    #
    if [[ "$force" = false ]]; then
        local was_error=""
        for qparam in "${query_params[@]}" "${path_params[@]}"; do
            local parameter_values
            mapfile -t parameter_values < <(sed -e 's/'":::"'/\n/g' <<<"${operation_parameters[$qparam]}")

            #
            # Check if the number of provided values is not less than minimum required
            #
            if [[ ${#parameter_values[@]} -lt ${operation_parameters_minimum_occurrences["${operation}:::${qparam}"]} ]]; then
                echo "ERROR: Too few values provided for '${qparam}' parameter."
                was_error=true
            fi

            #
            # Check if the number of provided values is not more than maximum
            #
            if [[ ${operation_parameters_maximum_occurrences["${operation}:::${qparam}"]} -gt 0 \
                  && ${#parameter_values[@]} -gt ${operation_parameters_maximum_occurrences["${operation}:::${qparam}"]} ]]; then
                echo "ERROR: Too many values provided for '${qparam}' parameter"
                was_error=true
            fi
        done
        if [[ -n "$was_error" ]]; then
            exit 1
        fi
    fi

    # First replace all path parameters in the path
    for pparam in "${path_params[@]}"; do
        local path_regex="(.*)(\\{$pparam\\})(.*)"
        if [[ $path_template =~ $path_regex ]]; then
            path_template=${BASH_REMATCH[1]}${operation_parameters[$pparam]}${BASH_REMATCH[3]}
        fi
    done

    local query_request_part=""

    for qparam in "${query_params[@]}"; do
        if [[ "${operation_parameters[$qparam]}" == "" ]]; then
            continue
        fi

        # Get the array of parameter values
        local parameter_value=""
        local parameter_values
        mapfile -t parameter_values < <(sed -e 's/'":::"'/\n/g' <<<"${operation_parameters[$qparam]}")



        #
        # Append parameters without specific cardinality
        #
        local collection_type="${operation_parameters_collection_type["${operation}:::${qparam}"]}"
        if [[ "${collection_type}" == "" ]]; then
            local vcount=0
            for qvalue in "${parameter_values[@]}"; do
                if [[ $((vcount++)) -gt 0 ]]; then
                    parameter_value+="&"
                fi
                parameter_value+="${qparam}=${qvalue}"
            done
        #
        # Append parameters specified as 'multi' collections i.e. param=value1&param=value2&...
        #
        elif [[ "${collection_type}" == "multi" ]]; then
            local vcount=0
            for qvalue in "${parameter_values[@]}"; do
                if [[ $((vcount++)) -gt 0 ]]; then
                    parameter_value+="&"
                fi
                parameter_value+="${qparam}=${qvalue}"
            done
        #
        # Append parameters specified as 'csv' collections i.e. param=value1,value2,...
        #
        elif [[ "${collection_type}" == "csv" ]]; then
            parameter_value+="${qparam}="
            local vcount=0
            for qvalue in "${parameter_values[@]}"; do
                if [[ $((vcount++)) -gt 0 ]]; then
                    parameter_value+=","
                fi
                parameter_value+="${qvalue}"
            done
        #
        # Append parameters specified as 'ssv' collections i.e. param="value1 value2 ..."
        #
        elif [[ "${collection_type}" == "ssv" ]]; then
            parameter_value+="${qparam}="
            local vcount=0
            for qvalue in "${parameter_values[@]}"; do
                if [[ $((vcount++)) -gt 0 ]]; then
                    parameter_value+=" "
                fi
                parameter_value+="${qvalue}"
            done
        #
        # Append parameters specified as 'tsv' collections i.e. param="value1\tvalue2\t..."
        #
        elif [[ "${collection_type}" == "tsv" ]]; then
            parameter_value+="${qparam}="
            local vcount=0
            for qvalue in "${parameter_values[@]}"; do
                if [[ $((vcount++)) -gt 0 ]]; then
                    parameter_value+="\\t"
                fi
                parameter_value+="${qvalue}"
            done
        else
            echo "Unsupported collection format \"${collection_type}\""
            exit 1
        fi

        if [[ -n "${parameter_value}" ]]; then
            if [[ -n "${query_request_part}" ]]; then
                query_request_part+="&"
            fi
            query_request_part+="${parameter_value}"
        fi

    done


    # Now append query parameters - if any
    if [[ -n "${query_request_part}" ]]; then
        path_template+="?${query_request_part}"
    fi

    echo "$path_template"
}



###############################################################################
#
# Print main help message
#
###############################################################################
print_help() {
cat <<EOF

${BOLD}${WHITE}HugeGraph RESTful API command line client (API version 1.5.0)${OFF}

${BOLD}${WHITE}Usage${OFF}

  ${GREEN}${script_name}${OFF} [-h|--help] [-V|--version] [--about] [${RED}<curl-options>${OFF}]
           [-ac|--accept ${GREEN}<mime-type>${OFF}] [-ct,--content-type ${GREEN}<mime-type>${OFF}]
           [--host ${CYAN}<url>${OFF}] [--dry-run] [-nc|--no-colors] ${YELLOW}<operation>${OFF} [-h|--help]
           [${BLUE}<headers>${OFF}] [${MAGENTA}<parameters>${OFF}] [${MAGENTA}<body-parameters>${OFF}]

  - ${CYAN}<url>${OFF} - endpoint of the REST service without basepath

  - ${RED}<curl-options>${OFF} - any valid cURL options can be passed before ${YELLOW}<operation>${OFF}
  - ${GREEN}<mime-type>${OFF} - either full mime-type or one of supported abbreviations:
                   (text, html, md, csv, css, rtf, json, xml, yaml, js, bin,
                    rdf, jpg, png, gif, bmp, tiff)
  - ${BLUE}<headers>${OFF} - HTTP headers can be passed in the form ${YELLOW}HEADER${OFF}:${BLUE}VALUE${OFF}
  - ${MAGENTA}<parameters>${OFF} - REST operation parameters can be passed in the following
                   forms:
                   * ${YELLOW}KEY${OFF}=${BLUE}VALUE${OFF} - path or query parameters
  - ${MAGENTA}<body-parameters>${OFF} - simple JSON body content (first level only) can be build
                        using the following arguments:
                        * ${YELLOW}KEY${OFF}==${BLUE}VALUE${OFF} - body parameters which will be added to body
                                      JSON as '{ ..., "${YELLOW}KEY${OFF}": "${BLUE}VALUE${OFF}", ... }'
                        * ${YELLOW}KEY${OFF}:=${BLUE}VALUE${OFF} - body parameters which will be added to body
                                      JSON as '{ ..., "${YELLOW}KEY${OFF}": ${BLUE}VALUE${OFF}, ... }'

EOF
    echo -e "${BOLD}${WHITE}Authentication methods${OFF}"
    echo -e ""
    echo -e "  - ${BLUE}Basic AUTH${OFF} - add '-u <username>:<password>' before ${YELLOW}<operation>${OFF}"
    
    echo ""
    echo -e "${BOLD}${WHITE}Operations (grouped by tags)${OFF}"
    echo ""
    echo -e "${BOLD}${WHITE}[accessAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create${OFF}; (AUTH) (AUTH)
  ${CYAN}delete${OFF}; (AUTH) (AUTH)
  ${CYAN}get${OFF}; (AUTH) (AUTH)
  ${CYAN}list${OFF}; (AUTH) (AUTH)
  ${CYAN}update${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[adamicAdarAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get16${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[algorithmAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post2${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[allShortestPathsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get17${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[arthasAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}startArthas${OFF};start arthas agent (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[belongAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create1${OFF}; (AUTH) (AUTH)
  ${CYAN}delete1${OFF}; (AUTH) (AUTH)
  ${CYAN}get1${OFF}; (AUTH) (AUTH)
  ${CYAN}list1${OFF}; (AUTH) (AUTH)
  ${CYAN}update1${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[computerAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post3${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[countAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post5${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[crosspointsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get18${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[customizedCrosspointsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post6${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[customizedPathsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post7${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[cypherAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post${OFF}; (AUTH) (AUTH)
  ${CYAN}query${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[default]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}getExternalGrammar${OFF}; (AUTH) (AUTH)
  ${CYAN}getWadl${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[edgeAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create6${OFF}; (AUTH) (AUTH)
  ${CYAN}create7${OFF}; (AUTH) (AUTH)
  ${CYAN}delete6${OFF}; (AUTH) (AUTH)
  ${CYAN}get7${OFF}; (AUTH) (AUTH)
  ${CYAN}list6${OFF}; (AUTH) (AUTH)
  ${CYAN}update6${OFF}; (AUTH) (AUTH)
  ${CYAN}update7${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[edgeExistenceAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get19${OFF};get edges from 'source' to 'target' vertex (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[edgeLabelAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create11${OFF}; (AUTH) (AUTH)
  ${CYAN}delete9${OFF}; (AUTH) (AUTH)
  ${CYAN}get12${OFF}; (AUTH) (AUTH)
  ${CYAN}list12${OFF}; (AUTH) (AUTH)
  ${CYAN}update11${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[edgesAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}list17${OFF}; (AUTH) (AUTH)
  ${CYAN}scan${OFF}; (AUTH) (AUTH)
  ${CYAN}shards${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[fusiformSimilarityAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post8${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[graphsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}clear${OFF}; (AUTH) (AUTH)
  ${CYAN}compact${OFF}; (AUTH) (AUTH)
  ${CYAN}create10${OFF}; (AUTH) (AUTH)
  ${CYAN}createSnapshot${OFF}; (AUTH) (AUTH)
  ${CYAN}drop${OFF}; (AUTH) (AUTH)
  ${CYAN}get11${OFF}; (AUTH) (AUTH)
  ${CYAN}getConf${OFF}; (AUTH) (AUTH)
  ${CYAN}graphReadMode${OFF}; (AUTH) (AUTH)
  ${CYAN}graphReadMode1${OFF}; (AUTH) (AUTH)
  ${CYAN}list9${OFF}; (AUTH) (AUTH)
  ${CYAN}mode${OFF}; (AUTH) (AUTH)
  ${CYAN}mode1${OFF}; (AUTH) (AUTH)
  ${CYAN}resumeSnapshot${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[gremlinAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get9${OFF}; (AUTH) (AUTH)
  ${CYAN}post1${OFF}; (AUTH) (AUTH)
  ${CYAN}post4${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[groupAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create2${OFF}; (AUTH) (AUTH)
  ${CYAN}delete2${OFF}; (AUTH) (AUTH)
  ${CYAN}get2${OFF}; (AUTH) (AUTH)
  ${CYAN}list2${OFF}; (AUTH) (AUTH)
  ${CYAN}update2${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[indexLabelAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create12${OFF}; (AUTH) (AUTH)
  ${CYAN}delete10${OFF}; (AUTH) (AUTH)
  ${CYAN}get13${OFF}; (AUTH) (AUTH)
  ${CYAN}list13${OFF}; (AUTH) (AUTH)
  ${CYAN}update12${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[jaccardSimilarityAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get20${OFF}; (AUTH) (AUTH)
  ${CYAN}post9${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[kneighborAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get21${OFF}; (AUTH) (AUTH)
  ${CYAN}post10${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[koutAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get22${OFF}; (AUTH) (AUTH)
  ${CYAN}post11${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[loginAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}login${OFF}; (AUTH) (AUTH)
  ${CYAN}logout${OFF}; (AUTH) (AUTH)
  ${CYAN}verifyToken${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[metricsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}all${OFF};get all base metrics (AUTH) (AUTH)
  ${CYAN}backend${OFF};get the backend metrics (AUTH) (AUTH)
  ${CYAN}counters${OFF};get the counters metrics (AUTH) (AUTH)
  ${CYAN}gauges${OFF};get the gauges metrics (AUTH) (AUTH)
  ${CYAN}histograms${OFF};get the histograms metrics (AUTH) (AUTH)
  ${CYAN}meters${OFF};get the meters metrics (AUTH) (AUTH)
  ${CYAN}statistics${OFF};get all statistics metrics (AUTH) (AUTH)
  ${CYAN}system${OFF};get the system metrics (AUTH) (AUTH)
  ${CYAN}timers${OFF};get the timers metrics (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[multiNodeShortestPathAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post12${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[neighborRankAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}neighborRank${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[pathsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get23${OFF}; (AUTH) (AUTH)
  ${CYAN}post13${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[personalRankAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}personalRank${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[profileAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}getProfile${OFF}; (AUTH) (AUTH)
  ${CYAN}showAllAPIs${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[projectAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create3${OFF}; (AUTH) (AUTH)
  ${CYAN}delete3${OFF}; (AUTH) (AUTH)
  ${CYAN}get3${OFF}; (AUTH) (AUTH)
  ${CYAN}list3${OFF}; (AUTH) (AUTH)
  ${CYAN}update3${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[propertyKeyAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create13${OFF}; (AUTH) (AUTH)
  ${CYAN}delete11${OFF}; (AUTH) (AUTH)
  ${CYAN}get14${OFF}; (AUTH) (AUTH)
  ${CYAN}list14${OFF}; (AUTH) (AUTH)
  ${CYAN}update13${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[raftAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}addPeer${OFF}; (AUTH) (AUTH)
  ${CYAN}getLeader${OFF}; (AUTH) (AUTH)
  ${CYAN}listPeers${OFF}; (AUTH) (AUTH)
  ${CYAN}removePeer${OFF}; (AUTH) (AUTH)
  ${CYAN}setLeader${OFF}; (AUTH) (AUTH)
  ${CYAN}transferLeader${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[raysAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get24${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[rebuildAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}edgeLabelRebuild${OFF}; (AUTH) (AUTH)
  ${CYAN}indexLabelRebuild${OFF}; (AUTH) (AUTH)
  ${CYAN}vertexLabelRebuild${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[resourceAllocationAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create15${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[ringsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get25${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[sameNeighborsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get26${OFF}; (AUTH) (AUTH)
  ${CYAN}sameNeighbors${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[schemaAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}list15${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[shortestPathAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get27${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[singleSourceShortestPathAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get28${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[targetAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create4${OFF}; (AUTH) (AUTH)
  ${CYAN}delete4${OFF}; (AUTH) (AUTH)
  ${CYAN}get4${OFF}; (AUTH) (AUTH)
  ${CYAN}list4${OFF}; (AUTH) (AUTH)
  ${CYAN}update4${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[taskAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}delete8${OFF}; (AUTH) (AUTH)
  ${CYAN}get10${OFF}; (AUTH) (AUTH)
  ${CYAN}list8${OFF}; (AUTH) (AUTH)
  ${CYAN}update10${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[templatePathsAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}post14${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[tracedExceptionAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get6${OFF}; (AUTH) (AUTH)
  ${CYAN}trace${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[userAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create5${OFF}; (AUTH) (AUTH)
  ${CYAN}delete5${OFF}; (AUTH) (AUTH)
  ${CYAN}get5${OFF}; (AUTH) (AUTH)
  ${CYAN}list5${OFF}; (AUTH) (AUTH)
  ${CYAN}role${OFF}; (AUTH) (AUTH)
  ${CYAN}update5${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[variablesAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}delete13${OFF}; (AUTH) (AUTH)
  ${CYAN}get30${OFF}; (AUTH) (AUTH)
  ${CYAN}list19${OFF}; (AUTH) (AUTH)
  ${CYAN}update15${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[versionAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}list10${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[vertexAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create8${OFF}; (AUTH) (AUTH)
  ${CYAN}create9${OFF}; (AUTH) (AUTH)
  ${CYAN}delete7${OFF}; (AUTH) (AUTH)
  ${CYAN}get8${OFF}; (AUTH) (AUTH)
  ${CYAN}list7${OFF}; (AUTH) (AUTH)
  ${CYAN}update8${OFF}; (AUTH) (AUTH)
  ${CYAN}update9${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[vertexLabelAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}create14${OFF}; (AUTH) (AUTH)
  ${CYAN}delete12${OFF}; (AUTH) (AUTH)
  ${CYAN}get15${OFF}; (AUTH) (AUTH)
  ${CYAN}list16${OFF}; (AUTH) (AUTH)
  ${CYAN}update14${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[verticesAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}list18${OFF}; (AUTH) (AUTH)
  ${CYAN}scan1${OFF}; (AUTH) (AUTH)
  ${CYAN}shards1${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[weightedShortestPathAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}get29${OFF}; (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}[whiteIpListAPI]${OFF}"
read -r -d '' ops <<EOF
  ${CYAN}list11${OFF};list white ips (AUTH) (AUTH)
  ${CYAN}updateStatus${OFF};enable/disable the white ip list (AUTH) (AUTH)
  ${CYAN}updateWhiteIPs${OFF};update white ip list (AUTH) (AUTH)
EOF
echo "  $ops" | column -t -s ';'
    echo ""
    echo -e "${BOLD}${WHITE}Options${OFF}"
    echo -e "  -h,--help\\t\\t\\t\\tPrint this help"
    echo -e "  -V,--version\\t\\t\\t\\tPrint API version"
    echo -e "  --about\\t\\t\\t\\tPrint the information about service"
    echo -e "  --host ${CYAN}<url>${OFF}\\t\\t\\t\\tSpecify the host URL "
echo -e "              \\t\\t\\t\\t(e.g. 'https://localhost')"

    echo -e "  --force\\t\\t\\t\\tForce command invocation in spite of missing"
    echo -e "         \\t\\t\\t\\trequired parameters or wrong content type"
    echo -e "  --dry-run\\t\\t\\t\\tPrint out the cURL command without"
    echo -e "           \\t\\t\\t\\texecuting it"
    echo -e "  -nc,--no-colors\\t\\t\\tEnforce print without colors, otherwise autodetected"
    echo -e "  -ac,--accept ${YELLOW}<mime-type>${OFF}\\t\\tSet the 'Accept' header in the request"
    echo -e "  -ct,--content-type ${YELLOW}<mime-type>${OFF}\\tSet the 'Content-type' header in "
    echo -e "                                \\tthe request"
    echo ""
}


##############################################################################
#
# Print REST service description
#
##############################################################################
print_about() {
    echo ""
    echo -e "${BOLD}${WHITE}HugeGraph RESTful API command line client (API version 1.5.0)${OFF}"
    echo ""
    echo -e "License: "
    echo -e "Contact: "
    echo ""
read -r -d '' appdescription <<EOF

All management API for HugeGraph
EOF
echo "$appdescription" | paste -sd' ' | fold -sw 80
}


##############################################################################
#
# Print REST api version
#
##############################################################################
print_version() {
    echo ""
    echo -e "${BOLD}HugeGraph RESTful API command line client (API version 1.5.0)${OFF}"
    echo ""
}

##############################################################################
#
# Print help for create operation
#
##############################################################################
print_create_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete operation
#
##############################################################################
print_delete_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get operation
#
##############################################################################
print_get_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list operation
#
##############################################################################
print_list_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}group${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: group=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}target${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: target=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update operation
#
##############################################################################
print_update_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get16 operation
#
##############################################################################
print_get16_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get16 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}vertex${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}other${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: other=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post2 operation
#
##############################################################################
print_post2_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post2 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get17 operation
#
##############################################################################
print_get17_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get17 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}target${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: target=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_depth${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: max_depth=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}skip_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 0)${OFF} - ${YELLOW} Specify as: skip_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_vertex${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_edge${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_edge=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for startArthas operation
#
##############################################################################
print_startArthas_help() {
    echo ""
    echo -e "${BOLD}${WHITE}startArthas - start arthas agent${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create1 operation
#
##############################################################################
print_create1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete1 operation
#
##############################################################################
print_delete1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get1 operation
#
##############################################################################
print_get1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list1 operation
#
##############################################################################
print_list1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}user${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: user=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}group${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: group=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update1 operation
#
##############################################################################
print_update1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post3 operation
#
##############################################################################
print_post3_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post3 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post5 operation
#
##############################################################################
print_post5_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post5 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get18 operation
#
##############################################################################
print_get18_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get18 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}target${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: target=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_depth${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: max_depth=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post6 operation
#
##############################################################################
print_post6_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post6 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post7 operation
#
##############################################################################
print_post7_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post7 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post operation
#
##############################################################################
print_post_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for query operation
#
##############################################################################
print_query_help() {
    echo ""
    echo -e "${BOLD}${WHITE}query - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}cypher${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: cypher=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for getExternalGrammar operation
#
##############################################################################
print_getExternalGrammar_help() {
    echo ""
    echo -e "${BOLD}${WHITE}getExternalGrammar - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}path${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: path=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for getWadl operation
#
##############################################################################
print_getWadl_help() {
    echo ""
    echo -e "${BOLD}${WHITE}getWadl - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create6 operation
#
##############################################################################
print_create6_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create6 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create7 operation
#
##############################################################################
print_create7_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create7 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}check_vertex${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: true)${OFF} - ${YELLOW} Specify as: check_vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete6 operation
#
##############################################################################
print_delete6_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete6 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get7 operation
#
##############################################################################
print_get7_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get7 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list6 operation
#
##############################################################################
print_list6_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list6 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}vertex_id${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: vertex_id=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}properties${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: properties=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}keep_start_p${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: keep_start_p=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}offset${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 0)${OFF} - ${YELLOW} Specify as: offset=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}page${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: page=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update6 operation
#
##############################################################################
print_update6_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update6 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update7 operation
#
##############################################################################
print_update7_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update7 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}action${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: action=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get19 operation
#
##############################################################################
print_get19_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get19 - get edges from 'source' to 'target' vertex${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}target${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: target=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}sort_values${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: )${OFF} - ${YELLOW} Specify as: sort_values=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create11 operation
#
##############################################################################
print_create11_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create11 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete9 operation
#
##############################################################################
print_delete9_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete9 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get12 operation
#
##############################################################################
print_get12_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get12 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list12 operation
#
##############################################################################
print_list12_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list12 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}names${OFF} ${BLUE}[array[string]]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: names=value1 names=value2 names=...${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update11 operation
#
##############################################################################
print_update11_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update11 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}action${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: action=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list17 operation
#
##############################################################################
print_list17_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list17 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}ids${OFF} ${BLUE}[array[string]]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: ids=value1 ids=value2 ids=...${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for scan operation
#
##############################################################################
print_scan_help() {
    echo ""
    echo -e "${BOLD}${WHITE}scan - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}start${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: start=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}end${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: end=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}page${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: page=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}page_limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100000)${OFF} - ${YELLOW} Specify as: page_limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for shards operation
#
##############################################################################
print_shards_help() {
    echo ""
    echo -e "${BOLD}${WHITE}shards - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}split_size${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: split_size=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post8 operation
#
##############################################################################
print_post8_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post8 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for clear operation
#
##############################################################################
print_clear_help() {
    echo ""
    echo -e "${BOLD}${WHITE}clear - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}confirm_message${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: confirm_message=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for compact operation
#
##############################################################################
print_compact_help() {
    echo ""
    echo -e "${BOLD}${WHITE}compact - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create10 operation
#
##############################################################################
print_create10_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create10 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}clone_graph_name${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: clone_graph_name=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[text/plain]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for createSnapshot operation
#
##############################################################################
print_createSnapshot_help() {
    echo ""
    echo -e "${BOLD}${WHITE}createSnapshot - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for drop operation
#
##############################################################################
print_drop_help() {
    echo ""
    echo -e "${BOLD}${WHITE}drop - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}confirm_message${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: confirm_message=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get11 operation
#
##############################################################################
print_get11_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get11 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for getConf operation
#
##############################################################################
print_getConf_help() {
    echo ""
    echo -e "${BOLD}${WHITE}getConf - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for graphReadMode operation
#
##############################################################################
print_graphReadMode_help() {
    echo ""
    echo -e "${BOLD}${WHITE}graphReadMode - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for graphReadMode1 operation
#
##############################################################################
print_graphReadMode1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}graphReadMode1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list9 operation
#
##############################################################################
print_list9_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list9 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for mode operation
#
##############################################################################
print_mode_help() {
    echo ""
    echo -e "${BOLD}${WHITE}mode - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for mode1 operation
#
##############################################################################
print_mode1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}mode1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for resumeSnapshot operation
#
##############################################################################
print_resumeSnapshot_help() {
    echo ""
    echo -e "${BOLD}${WHITE}resumeSnapshot - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get9 operation
#
##############################################################################
print_get9_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get9 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post1 operation
#
##############################################################################
print_post1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post4 operation
#
##############################################################################
print_post4_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post4 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create2 operation
#
##############################################################################
print_create2_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create2 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete2 operation
#
##############################################################################
print_delete2_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete2 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get2 operation
#
##############################################################################
print_get2_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get2 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list2 operation
#
##############################################################################
print_list2_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list2 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update2 operation
#
##############################################################################
print_update2_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update2 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create12 operation
#
##############################################################################
print_create12_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create12 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete10 operation
#
##############################################################################
print_delete10_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete10 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get13 operation
#
##############################################################################
print_get13_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get13 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list13 operation
#
##############################################################################
print_list13_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list13 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}names${OFF} ${BLUE}[array[string]]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: names=value1 names=value2 names=...${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update12 operation
#
##############################################################################
print_update12_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update12 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}action${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: action=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get20 operation
#
##############################################################################
print_get20_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get20 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}vertex${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}other${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: other=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post9 operation
#
##############################################################################
print_post9_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post9 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get21 operation
#
##############################################################################
print_get21_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get21 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_depth${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: max_depth=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}count_only${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: count_only=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post10 operation
#
##############################################################################
print_post10_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post10 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get22 operation
#
##############################################################################
print_get22_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get22 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_depth${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: max_depth=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}nearest${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: true)${OFF} - ${YELLOW} Specify as: nearest=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}count_only${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: count_only=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post11 operation
#
##############################################################################
print_post11_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post11 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for login operation
#
##############################################################################
print_login_help() {
    echo ""
    echo -e "${BOLD}${WHITE}login - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for logout operation
#
##############################################################################
print_logout_help() {
    echo ""
    echo -e "${BOLD}${WHITE}logout - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}Authorization${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: Authorization:value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for verifyToken operation
#
##############################################################################
print_verifyToken_help() {
    echo ""
    echo -e "${BOLD}${WHITE}verifyToken - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}Authorization${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: Authorization:value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for all operation
#
##############################################################################
print_all_help() {
    echo ""
    echo -e "${BOLD}${WHITE}all - get all base metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}type${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: type=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for backend operation
#
##############################################################################
print_backend_help() {
    echo ""
    echo -e "${BOLD}${WHITE}backend - get the backend metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for counters operation
#
##############################################################################
print_counters_help() {
    echo ""
    echo -e "${BOLD}${WHITE}counters - get the counters metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for gauges operation
#
##############################################################################
print_gauges_help() {
    echo ""
    echo -e "${BOLD}${WHITE}gauges - get the gauges metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for histograms operation
#
##############################################################################
print_histograms_help() {
    echo ""
    echo -e "${BOLD}${WHITE}histograms - get the histograms metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for meters operation
#
##############################################################################
print_meters_help() {
    echo ""
    echo -e "${BOLD}${WHITE}meters - get the meters metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for statistics operation
#
##############################################################################
print_statistics_help() {
    echo ""
    echo -e "${BOLD}${WHITE}statistics - get all statistics metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}type${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: type=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for system operation
#
##############################################################################
print_system_help() {
    echo ""
    echo -e "${BOLD}${WHITE}system - get the system metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for timers operation
#
##############################################################################
print_timers_help() {
    echo ""
    echo -e "${BOLD}${WHITE}timers - get the timers metrics${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post12 operation
#
##############################################################################
print_post12_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post12 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for neighborRank operation
#
##############################################################################
print_neighborRank_help() {
    echo ""
    echo -e "${BOLD}${WHITE}neighborRank - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get23 operation
#
##############################################################################
print_get23_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get23 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}target${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: target=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_depth${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: max_depth=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post13 operation
#
##############################################################################
print_post13_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post13 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for personalRank operation
#
##############################################################################
print_personalRank_help() {
    echo ""
    echo -e "${BOLD}${WHITE}personalRank - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for getProfile operation
#
##############################################################################
print_getProfile_help() {
    echo ""
    echo -e "${BOLD}${WHITE}getProfile - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for showAllAPIs operation
#
##############################################################################
print_showAllAPIs_help() {
    echo ""
    echo -e "${BOLD}${WHITE}showAllAPIs - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create3 operation
#
##############################################################################
print_create3_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create3 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete3 operation
#
##############################################################################
print_delete3_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete3 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get3 operation
#
##############################################################################
print_get3_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get3 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list3 operation
#
##############################################################################
print_list3_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list3 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update3 operation
#
##############################################################################
print_update3_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update3 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}action${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: action=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create13 operation
#
##############################################################################
print_create13_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create13 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete11 operation
#
##############################################################################
print_delete11_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete11 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get14 operation
#
##############################################################################
print_get14_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get14 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list14 operation
#
##############################################################################
print_list14_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list14 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}names${OFF} ${BLUE}[array[string]]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: names=value1 names=value2 names=...${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update13 operation
#
##############################################################################
print_update13_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update13 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}action${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: action=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for addPeer operation
#
##############################################################################
print_addPeer_help() {
    echo ""
    echo -e "${BOLD}${WHITE}addPeer - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}group${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: default)${OFF} - ${YELLOW} Specify as: group=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}endpoint${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: endpoint=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for getLeader operation
#
##############################################################################
print_getLeader_help() {
    echo ""
    echo -e "${BOLD}${WHITE}getLeader - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}group${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: default)${OFF} - ${YELLOW} Specify as: group=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for listPeers operation
#
##############################################################################
print_listPeers_help() {
    echo ""
    echo -e "${BOLD}${WHITE}listPeers - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}group${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: default)${OFF} - ${YELLOW} Specify as: group=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for removePeer operation
#
##############################################################################
print_removePeer_help() {
    echo ""
    echo -e "${BOLD}${WHITE}removePeer - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}group${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: default)${OFF} - ${YELLOW} Specify as: group=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}endpoint${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: endpoint=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for setLeader operation
#
##############################################################################
print_setLeader_help() {
    echo ""
    echo -e "${BOLD}${WHITE}setLeader - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}group${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: default)${OFF} - ${YELLOW} Specify as: group=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}endpoint${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: endpoint=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for transferLeader operation
#
##############################################################################
print_transferLeader_help() {
    echo ""
    echo -e "${BOLD}${WHITE}transferLeader - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}group${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: default)${OFF} - ${YELLOW} Specify as: group=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}endpoint${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: endpoint=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get24 operation
#
##############################################################################
print_get24_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get24 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_depth${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: max_depth=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_vertex${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_edge${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_edge=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for edgeLabelRebuild operation
#
##############################################################################
print_edgeLabelRebuild_help() {
    echo ""
    echo -e "${BOLD}${WHITE}edgeLabelRebuild - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for indexLabelRebuild operation
#
##############################################################################
print_indexLabelRebuild_help() {
    echo ""
    echo -e "${BOLD}${WHITE}indexLabelRebuild - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for vertexLabelRebuild operation
#
##############################################################################
print_vertexLabelRebuild_help() {
    echo ""
    echo -e "${BOLD}${WHITE}vertexLabelRebuild - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create15 operation
#
##############################################################################
print_create15_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create15 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}vertex${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}other${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: other=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get25 operation
#
##############################################################################
print_get25_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get25 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_depth${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: max_depth=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source_in_ring${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: true)${OFF} - ${YELLOW} Specify as: source_in_ring=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_vertex${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_edge${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_edge=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get26 operation
#
##############################################################################
print_get26_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get26 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}vertex${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}other${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: other=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for sameNeighbors operation
#
##############################################################################
print_sameNeighbors_help() {
    echo ""
    echo -e "${BOLD}${WHITE}sameNeighbors - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list15 operation
#
##############################################################################
print_list15_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list15 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get27 operation
#
##############################################################################
print_get27_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get27 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}target${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: target=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_depth${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: max_depth=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}skip_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 0)${OFF} - ${YELLOW} Specify as: skip_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_vertex${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_edge${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_edge=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get28 operation
#
##############################################################################
print_get28_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get28 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}weight${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: weight=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}skip_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 0)${OFF} - ${YELLOW} Specify as: skip_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_vertex${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_edge${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_edge=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create4 operation
#
##############################################################################
print_create4_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create4 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete4 operation
#
##############################################################################
print_delete4_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete4 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get4 operation
#
##############################################################################
print_get4_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get4 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list4 operation
#
##############################################################################
print_list4_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list4 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update4 operation
#
##############################################################################
print_update4_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update4 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete8 operation
#
##############################################################################
print_delete8_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete8 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[integer]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}force${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: force=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get10 operation
#
##############################################################################
print_get10_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get10 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[integer]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list8 operation
#
##############################################################################
print_list8_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list8 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}status${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: status=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}ids${OFF} ${BLUE}[array[integer]]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: ids=value1 ids=value2 ids=...${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}page${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: page=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update10 operation
#
##############################################################################
print_update10_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update10 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[integer]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}action${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: action=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for post14 operation
#
##############################################################################
print_post14_help() {
    echo ""
    echo -e "${BOLD}${WHITE}post14 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get6 operation
#
##############################################################################
print_get6_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get6 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for trace operation
#
##############################################################################
print_trace_help() {
    echo ""
    echo -e "${BOLD}${WHITE}trace - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create5 operation
#
##############################################################################
print_create5_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create5 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete5 operation
#
##############################################################################
print_delete5_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete5 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get5 operation
#
##############################################################################
print_get5_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get5 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list5 operation
#
##############################################################################
print_list5_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list5 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for role operation
#
##############################################################################
print_role_help() {
    echo ""
    echo -e "${BOLD}${WHITE}role - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update5 operation
#
##############################################################################
print_update5_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update5 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete13 operation
#
##############################################################################
print_delete13_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete13 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}key${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: key=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get30 operation
#
##############################################################################
print_get30_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get30 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}key${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: key=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list19 operation
#
##############################################################################
print_list19_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list19 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update15 operation
#
##############################################################################
print_update15_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update15 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}key${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: key=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list10 operation
#
##############################################################################
print_list10_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list10 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create8 operation
#
##############################################################################
print_create8_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create8 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create9 operation
#
##############################################################################
print_create9_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create9 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete7 operation
#
##############################################################################
print_delete7_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete7 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get8 operation
#
##############################################################################
print_get8_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get8 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list7 operation
#
##############################################################################
print_list7_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list7 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}properties${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: properties=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}keep_start_p${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: keep_start_p=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}offset${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 0)${OFF} - ${YELLOW} Specify as: offset=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}page${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: page=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100)${OFF} - ${YELLOW} Specify as: limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update8 operation
#
##############################################################################
print_update8_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update8 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update9 operation
#
##############################################################################
print_update9_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update9 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}id${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: id=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}action${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: action=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for create14 operation
#
##############################################################################
print_create14_help() {
    echo ""
    echo -e "${BOLD}${WHITE}create14 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for delete12 operation
#
##############################################################################
print_delete12_help() {
    echo ""
    echo -e "${BOLD}${WHITE}delete12 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get15 operation
#
##############################################################################
print_get15_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get15 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list16 operation
#
##############################################################################
print_list16_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list16 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}names${OFF} ${BLUE}[array[string]]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: names=value1 names=value2 names=...${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for update14 operation
#
##############################################################################
print_update14_help() {
    echo ""
    echo -e "${BOLD}${WHITE}update14 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}name${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: name=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}action${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: action=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list18 operation
#
##############################################################################
print_list18_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list18 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}ids${OFF} ${BLUE}[array[string]]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: ids=value1 ids=value2 ids=...${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for scan1 operation
#
##############################################################################
print_scan1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}scan1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}start${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: start=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}end${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: end=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}page${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: page=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}page_limit${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 100000)${OFF} - ${YELLOW} Specify as: page_limit=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for shards1 operation
#
##############################################################################
print_shards1_help() {
    echo ""
    echo -e "${BOLD}${WHITE}shards1 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}split_size${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: split_size=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for get29 operation
#
##############################################################################
print_get29_help() {
    echo ""
    echo -e "${BOLD}${WHITE}get29 - ${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}graph${OFF} ${BLUE}[string]${OFF} ${RED}(required)${OFF} ${CYAN}(default: null)${OFF} -  ${YELLOW}Specify as: graph=value${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}source${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: source=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}target${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: target=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}direction${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: direction=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}label${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: label=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}weight${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: weight=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}max_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000)${OFF} - ${YELLOW} Specify as: max_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}skip_degree${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 0)${OFF} - ${YELLOW} Specify as: skip_degree=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_vertex${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_vertex=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}with_edge${OFF} ${BLUE}[boolean]${OFF} ${CYAN}(default: false)${OFF} - ${YELLOW} Specify as: with_edge=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e "  * ${GREEN}capacity${OFF} ${BLUE}[integer]${OFF} ${CYAN}(default: 10000000)${OFF} - ${YELLOW} Specify as: capacity=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for list11 operation
#
##############################################################################
print_list11_help() {
    echo ""
    echo -e "${BOLD}${WHITE}list11 - list white ips${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for updateStatus operation
#
##############################################################################
print_updateStatus_help() {
    echo ""
    echo -e "${BOLD}${WHITE}updateStatus - enable/disable the white ip list${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}status${OFF} ${BLUE}[string]${OFF} ${CYAN}(default: null)${OFF} - ${YELLOW} Specify as: status=value${OFF}" \
        | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}
##############################################################################
#
# Print help for updateWhiteIPs operation
#
##############################################################################
print_updateWhiteIPs_help() {
    echo ""
    echo -e "${BOLD}${WHITE}updateWhiteIPs - update white ip list${OFF}${BLUE}(AUTH - )${OFF}${BLUE}(AUTH - BASIC)${OFF}" | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo -e "${BOLD}${WHITE}Parameters${OFF}"
    echo -e "  * ${GREEN}body${OFF} ${BLUE}[application/json]${OFF}${OFF} - " | paste -sd' ' | fold -sw 80 | sed '2,$s/^/    /'
    echo -e ""
    echo ""
    echo -e "${BOLD}${WHITE}Responses${OFF}"
    code=0
    echo -e "${result_color_table[${code:0:1}]}  0;default response${OFF}" | paste -sd' ' | column -t -s ';' | fold -sw 80 | sed '2,$s/^/       /'
}


##############################################################################
#
# Call create operation
#
##############################################################################
call_create() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/accesses" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete operation
#
##############################################################################
call_delete() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/accesses/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get operation
#
##############################################################################
call_get() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/accesses/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list operation
#
##############################################################################
call_list() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(group target limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/accesses" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update operation
#
##############################################################################
call_update() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/accesses/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get16 operation
#
##############################################################################
call_get16() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(vertex other direction label max_degree limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/adamicadar" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post2 operation
#
##############################################################################
call_post2() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/jobs/algorithm/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get17 operation
#
##############################################################################
call_get17() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source target direction label max_depth max_degree skip_degree with_vertex with_edge capacity    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/allshortestpaths" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call startArthas operation
#
##############################################################################
call_startArthas() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/arthas" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call create1 operation
#
##############################################################################
call_create1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/belongs" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete1 operation
#
##############################################################################
call_delete1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/belongs/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get1 operation
#
##############################################################################
call_get1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/belongs/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list1 operation
#
##############################################################################
call_list1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(user group limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/belongs" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update1 operation
#
##############################################################################
call_update1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/belongs/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call post3 operation
#
##############################################################################
call_post3() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/jobs/computer/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call post5 operation
#
##############################################################################
call_post5() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/count" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get18 operation
#
##############################################################################
call_get18() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source target direction label max_depth max_degree capacity limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/crosspoints" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post6 operation
#
##############################################################################
call_post6() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/customizedcrosspoints" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call post7 operation
#
##############################################################################
call_post7() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/customizedpaths" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call post operation
#
##############################################################################
call_post() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/cypher" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call query operation
#
##############################################################################
call_query() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(cypher    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/cypher" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call getExternalGrammar operation
#
##############################################################################
call_getExternalGrammar() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(path)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/application.wadl/{path}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call getWadl operation
#
##############################################################################
call_getWadl() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/application.wadl" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call create6 operation
#
##############################################################################
call_create6() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/edges" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call create7 operation
#
##############################################################################
call_create7() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(check_vertex    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/edges/batch" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete6 operation
#
##############################################################################
call_delete6() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(label    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/edges/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get7 operation
#
##############################################################################
call_get7() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/edges/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list6 operation
#
##############################################################################
call_list6() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(vertex_id direction label properties keep_start_p offset page limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/edges" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update6 operation
#
##############################################################################
call_update6() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/edges/batch" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call update7 operation
#
##############################################################################
call_update7() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(action    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/edges/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get19 operation
#
##############################################################################
call_get19() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source target label sort_values limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/edgeexist" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call create11 operation
#
##############################################################################
call_create11() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/edgelabels" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete9 operation
#
##############################################################################
call_delete9() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/edgelabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get12 operation
#
##############################################################################
call_get12() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/edgelabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list12 operation
#
##############################################################################
call_list12() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(names    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/edgelabels" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update11 operation
#
##############################################################################
call_update11() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(action    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/edgelabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call list17 operation
#
##############################################################################
call_list17() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(ids    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/edges" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call scan operation
#
##############################################################################
call_scan() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(start end page page_limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/edges/scan" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call shards operation
#
##############################################################################
call_shards() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(split_size    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/edges/shards" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post8 operation
#
##############################################################################
call_post8() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/fusiformsimilarity" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call clear operation
#
##############################################################################
call_clear() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(confirm_message    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/clear" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call compact operation
#
##############################################################################
call_compact() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/compact" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call create10 operation
#
##############################################################################
call_create10() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(clone_graph_name    )
    local path

    if ! path=$(build_request_path "/graphs/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="text/plain"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- text/plain"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call createSnapshot operation
#
##############################################################################
call_createSnapshot() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/snapshot_create" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call drop operation
#
##############################################################################
call_drop() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(confirm_message    )
    local path

    if ! path=$(build_request_path "/graphs/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get11 operation
#
##############################################################################
call_get11() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call getConf operation
#
##############################################################################
call_getConf() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/conf" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call graphReadMode operation
#
##############################################################################
call_graphReadMode() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/graph_read_mode" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call graphReadMode1 operation
#
##############################################################################
call_graphReadMode1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/graph_read_mode" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call list9 operation
#
##############################################################################
call_list9() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call mode operation
#
##############################################################################
call_mode() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/mode" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call mode1 operation
#
##############################################################################
call_mode1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/mode" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call resumeSnapshot operation
#
##############################################################################
call_resumeSnapshot() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{name}/snapshot_resume" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get9 operation
#
##############################################################################
call_get9() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/gremlin" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post1 operation
#
##############################################################################
call_post1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/gremlin" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call post4 operation
#
##############################################################################
call_post4() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/jobs/gremlin" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call create2 operation
#
##############################################################################
call_create2() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/groups" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete2 operation
#
##############################################################################
call_delete2() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/groups/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get2 operation
#
##############################################################################
call_get2() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/groups/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list2 operation
#
##############################################################################
call_list2() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/groups" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update2 operation
#
##############################################################################
call_update2() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/groups/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call create12 operation
#
##############################################################################
call_create12() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/indexlabels" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete10 operation
#
##############################################################################
call_delete10() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/indexlabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get13 operation
#
##############################################################################
call_get13() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/indexlabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list13 operation
#
##############################################################################
call_list13() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(names    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/indexlabels" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update12 operation
#
##############################################################################
call_update12() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(action    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/indexlabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get20 operation
#
##############################################################################
call_get20() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(vertex other direction label max_degree    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/jaccardsimilarity" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post9 operation
#
##############################################################################
call_post9() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/jaccardsimilarity" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get21 operation
#
##############################################################################
call_get21() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source direction label max_depth count_only max_degree limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/kneighbor" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post10 operation
#
##############################################################################
call_post10() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/kneighbor" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get22 operation
#
##############################################################################
call_get22() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source direction label max_depth nearest count_only max_degree capacity limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/kout" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post11 operation
#
##############################################################################
call_post11() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/kout" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call login operation
#
##############################################################################
call_login() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/login" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call logout operation
#
##############################################################################
call_logout() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/logout" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call verifyToken operation
#
##############################################################################
call_verifyToken() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/verify" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call all operation
#
##############################################################################
call_all() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(type    )
    local path

    if ! path=$(build_request_path "/metrics" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call backend operation
#
##############################################################################
call_backend() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/metrics/backend" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call counters operation
#
##############################################################################
call_counters() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/metrics/counters" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call gauges operation
#
##############################################################################
call_gauges() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/metrics/gauges" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call histograms operation
#
##############################################################################
call_histograms() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/metrics/histograms" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call meters operation
#
##############################################################################
call_meters() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/metrics/meters" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call statistics operation
#
##############################################################################
call_statistics() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(type    )
    local path

    if ! path=$(build_request_path "/metrics/statistics" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call system operation
#
##############################################################################
call_system() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/metrics/system" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call timers operation
#
##############################################################################
call_timers() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/metrics/timers" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post12 operation
#
##############################################################################
call_post12() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/multinodeshortestpath" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call neighborRank operation
#
##############################################################################
call_neighborRank() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/neighborrank" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get23 operation
#
##############################################################################
call_get23() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source target direction label max_depth max_degree capacity limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/paths" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post13 operation
#
##############################################################################
call_post13() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/paths" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call personalRank operation
#
##############################################################################
call_personalRank() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/personalrank" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call getProfile operation
#
##############################################################################
call_getProfile() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call showAllAPIs operation
#
##############################################################################
call_showAllAPIs() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/apis" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call create3 operation
#
##############################################################################
call_create3() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/projects" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete3 operation
#
##############################################################################
call_delete3() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/projects/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get3 operation
#
##############################################################################
call_get3() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/projects/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list3 operation
#
##############################################################################
call_list3() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/projects" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update3 operation
#
##############################################################################
call_update3() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(action    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/projects/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call create13 operation
#
##############################################################################
call_create13() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/propertykeys" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete11 operation
#
##############################################################################
call_delete11() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/propertykeys/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get14 operation
#
##############################################################################
call_get14() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/propertykeys/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list14 operation
#
##############################################################################
call_list14() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(names    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/propertykeys" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update13 operation
#
##############################################################################
call_update13() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(action    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/propertykeys/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call addPeer operation
#
##############################################################################
call_addPeer() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(group endpoint    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/raft/add_peer" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call getLeader operation
#
##############################################################################
call_getLeader() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(group    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/raft/get_leader" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call listPeers operation
#
##############################################################################
call_listPeers() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(group    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/raft/list_peers" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call removePeer operation
#
##############################################################################
call_removePeer() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(group endpoint    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/raft/remove_peer" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call setLeader operation
#
##############################################################################
call_setLeader() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(group endpoint    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/raft/set_leader" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call transferLeader operation
#
##############################################################################
call_transferLeader() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(group endpoint    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/raft/transfer_leader" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get24 operation
#
##############################################################################
call_get24() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source direction label max_depth max_degree capacity limit with_vertex with_edge    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/rays" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call edgeLabelRebuild operation
#
##############################################################################
call_edgeLabelRebuild() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/jobs/rebuild/edgelabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call indexLabelRebuild operation
#
##############################################################################
call_indexLabelRebuild() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/jobs/rebuild/indexlabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call vertexLabelRebuild operation
#
##############################################################################
call_vertexLabelRebuild() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/jobs/rebuild/vertexlabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call create15 operation
#
##############################################################################
call_create15() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(vertex other direction label max_degree limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/resourceallocation" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get25 operation
#
##############################################################################
call_get25() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source direction label max_depth source_in_ring max_degree capacity limit with_vertex with_edge    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/rings" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get26 operation
#
##############################################################################
call_get26() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(vertex other direction label max_degree limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/sameneighbors" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call sameNeighbors operation
#
##############################################################################
call_sameNeighbors() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/sameneighbors" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call list15 operation
#
##############################################################################
call_list15() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get27 operation
#
##############################################################################
call_get27() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source target direction label max_depth max_degree skip_degree with_vertex with_edge capacity    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/shortestpath" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get28 operation
#
##############################################################################
call_get28() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source direction label weight max_degree skip_degree with_vertex with_edge capacity limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/singlesourceshortestpath" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call create4 operation
#
##############################################################################
call_create4() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/targets" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete4 operation
#
##############################################################################
call_delete4() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/targets/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get4 operation
#
##############################################################################
call_get4() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/targets/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list4 operation
#
##############################################################################
call_list4() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/targets" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update4 operation
#
##############################################################################
call_update4() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/targets/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete8 operation
#
##############################################################################
call_delete8() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(force    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/tasks/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get10 operation
#
##############################################################################
call_get10() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/tasks/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list8 operation
#
##############################################################################
call_list8() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(status ids limit page    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/tasks" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update10 operation
#
##############################################################################
call_update10() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(action    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/tasks/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call post14 operation
#
##############################################################################
call_post14() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/templatepaths" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call get6 operation
#
##############################################################################
call_get6() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/exception/trace" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call trace operation
#
##############################################################################
call_trace() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/exception/trace" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call create5 operation
#
##############################################################################
call_create5() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/users" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete5 operation
#
##############################################################################
call_delete5() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/users/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get5 operation
#
##############################################################################
call_get5() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/users/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list5 operation
#
##############################################################################
call_list5() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/users" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call role operation
#
##############################################################################
call_role() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/users/{id}/role" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update5 operation
#
##############################################################################
call_update5() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/auth/users/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete13 operation
#
##############################################################################
call_delete13() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph key)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/variables/{key}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get30 operation
#
##############################################################################
call_get30() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph key)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/variables/{key}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list19 operation
#
##############################################################################
call_list19() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/variables" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update15 operation
#
##############################################################################
call_update15() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph key)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/variables/{key}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call list10 operation
#
##############################################################################
call_list10() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/versions" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call create8 operation
#
##############################################################################
call_create8() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/vertices" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call create9 operation
#
##############################################################################
call_create9() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/vertices/batch" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete7 operation
#
##############################################################################
call_delete7() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(label    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/vertices/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get8 operation
#
##############################################################################
call_get8() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/vertices/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list7 operation
#
##############################################################################
call_list7() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(label properties keep_start_p offset page limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/vertices" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update8 operation
#
##############################################################################
call_update8() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/vertices/batch" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call update9 operation
#
##############################################################################
call_update9() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph id)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(action    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/graph/vertices/{id}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call create14 operation
#
##############################################################################
call_create14() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/vertexlabels" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call delete12 operation
#
##############################################################################
call_delete12() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/vertexlabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="DELETE"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get15 operation
#
##############################################################################
call_get15() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/vertexlabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list16 operation
#
##############################################################################
call_list16() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(names    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/vertexlabels" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call update14 operation
#
##############################################################################
call_update14() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph name)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(action    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/schema/vertexlabels/{name}" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}

##############################################################################
#
# Call list18 operation
#
##############################################################################
call_list18() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(ids    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/vertices" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call scan1 operation
#
##############################################################################
call_scan1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(start end page page_limit    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/vertices/scan" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call shards1 operation
#
##############################################################################
call_shards1() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(split_size    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/vertices/shards" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call get29 operation
#
##############################################################################
call_get29() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=(graph)
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(source target direction label weight max_degree skip_degree with_vertex with_edge capacity    )
    local path

    if ! path=$(build_request_path "/graphs/{graph}/traversers/weightedshortestpath" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call list11 operation
#
##############################################################################
call_list11() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/whiteiplist" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="GET"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call updateStatus operation
#
##############################################################################
call_updateStatus() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(status    )
    local path

    if ! path=$(build_request_path "/whiteiplist" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="PUT"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    if [[ "$print_curl" = true ]]; then
        echo "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    else
        eval "curl -d '' ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\""
    fi
}

##############################################################################
#
# Call updateWhiteIPs operation
#
##############################################################################
call_updateWhiteIPs() {
    # ignore error about 'path_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local path_parameter_names=()
    # ignore error about 'query_parameter_names' being unused; passed by reference
    # shellcheck disable=SC2034
    local query_parameter_names=(    )
    local path

    if ! path=$(build_request_path "/whiteiplist" path_parameter_names query_parameter_names); then
        ERROR_MSG=$path
        exit 1
    fi
    local method="POST"
    local headers_curl
    headers_curl=$(header_arguments_to_curl)
    if [[ -n $header_accept ]]; then
        headers_curl="${headers_curl} -H 'Accept: ${header_accept}'"
    fi

    local basic_auth_option=""
    if [[ -n $basic_auth_credential ]]; then
        basic_auth_option="-u ${basic_auth_credential}"
    fi
    local body_json_curl=""

    #
    # Check if the user provided 'Content-type' headers in the
    # command line. If not try to set them based on the OpenAPI specification
    # if values produces and consumes are defined unambiguously
    #
    if [[ -z $header_content_type ]]; then
        header_content_type="application/json"
    fi


    if [[ -z $header_content_type && "$force" = false ]]; then
        :
        echo "ERROR: Request's content-type not specified!!!"
        echo "This operation expects content-type in one of the following formats:"
        echo -e "\\t- application/json"
        echo ""
        echo "Use '--content-type' to set proper content type"
        exit 1
    else
        headers_curl="${headers_curl} -H 'Content-type: ${header_content_type}'"
    fi


    #
    # If we have received some body content over pipe, pass it from the
    # temporary file to cURL
    #
    if [[ -n $body_content_temp_file ]]; then
        if [[ "$print_curl" = true ]]; then
            echo "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        else
            eval "cat ${body_content_temp_file} | curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} \"${host}${path}\" -d @-"
        fi
        rm "${body_content_temp_file}"
    #
    # If not, try to build the content body from arguments KEY==VALUE and KEY:=VALUE
    #
    else
        body_json_curl=$(body_parameters_to_json)
        if [[ "$print_curl" = true ]]; then
            echo "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        else
            eval "curl ${basic_auth_option} ${curl_arguments} ${headers_curl} -X ${method} ${body_json_curl} \"${host}${path}\""
        fi
    fi
}



##############################################################################
#
# Main
#
##############################################################################


# Check dependencies
type curl >/dev/null 2>&1 || { echo >&2 "ERROR: You do not have 'cURL' installed."; exit 1; }
type sed >/dev/null 2>&1 || { echo >&2 "ERROR: You do not have 'sed' installed."; exit 1; }
type column >/dev/null 2>&1 || { echo >&2 "ERROR: You do not have 'bsdmainutils' installed."; exit 1; }

#
# Process command line
#
# Pass all arguments before 'operation' to cURL except the ones we override
#
take_user=false
take_host=false
take_accept_header=false
take_contenttype_header=false

for key in "$@"; do
# Take the value of -u|--user argument
if [[ "$take_user" = true ]]; then
    basic_auth_credential="$key"
    take_user=false
    continue
fi
# Take the value of --host argument
if [[ "$take_host" = true ]]; then
    host="$key"
    take_host=false
    continue
fi
# Take the value of --accept argument
if [[ "$take_accept_header" = true ]]; then
    header_accept=$(lookup_mime_type "$key")
    take_accept_header=false
    continue
fi
# Take the value of --content-type argument
if [[ "$take_contenttype_header" = true ]]; then
    header_content_type=$(lookup_mime_type "$key")
    take_contenttype_header=false
    continue
fi
case $key in
    -h|--help)
    if [[ "x$operation" == "x" ]]; then
        print_help
        exit 0
    else
        eval "print_${operation}_help"
        exit 0
    fi
    ;;
    -V|--version)
    print_version
    exit 0
    ;;
    --about)
    print_about
    exit 0
    ;;
    -u|--user)
    take_user=true
    ;;
    --host)
    take_host=true
    ;;
    --force)
    force=true
    ;;
    -ac|--accept)
    take_accept_header=true
    ;;
    -ct|--content-type)
    take_contenttype_header=true
    ;;
    --dry-run)
    print_curl=true
    ;;
    -nc|--no-colors)
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        MAGENTA=""
        CYAN=""
        WHITE=""
        BOLD=""
        OFF=""
        result_color_table=( "" "" "" "" "" "" "" )
    ;;
    create)
    operation="create"
    ;;
    delete)
    operation="delete"
    ;;
    get)
    operation="get"
    ;;
    list)
    operation="list"
    ;;
    update)
    operation="update"
    ;;
    get16)
    operation="get16"
    ;;
    post2)
    operation="post2"
    ;;
    get17)
    operation="get17"
    ;;
    startArthas)
    operation="startArthas"
    ;;
    create1)
    operation="create1"
    ;;
    delete1)
    operation="delete1"
    ;;
    get1)
    operation="get1"
    ;;
    list1)
    operation="list1"
    ;;
    update1)
    operation="update1"
    ;;
    post3)
    operation="post3"
    ;;
    post5)
    operation="post5"
    ;;
    get18)
    operation="get18"
    ;;
    post6)
    operation="post6"
    ;;
    post7)
    operation="post7"
    ;;
    post)
    operation="post"
    ;;
    query)
    operation="query"
    ;;
    getExternalGrammar)
    operation="getExternalGrammar"
    ;;
    getWadl)
    operation="getWadl"
    ;;
    create6)
    operation="create6"
    ;;
    create7)
    operation="create7"
    ;;
    delete6)
    operation="delete6"
    ;;
    get7)
    operation="get7"
    ;;
    list6)
    operation="list6"
    ;;
    update6)
    operation="update6"
    ;;
    update7)
    operation="update7"
    ;;
    get19)
    operation="get19"
    ;;
    create11)
    operation="create11"
    ;;
    delete9)
    operation="delete9"
    ;;
    get12)
    operation="get12"
    ;;
    list12)
    operation="list12"
    ;;
    update11)
    operation="update11"
    ;;
    list17)
    operation="list17"
    ;;
    scan)
    operation="scan"
    ;;
    shards)
    operation="shards"
    ;;
    post8)
    operation="post8"
    ;;
    clear)
    operation="clear"
    ;;
    compact)
    operation="compact"
    ;;
    create10)
    operation="create10"
    ;;
    createSnapshot)
    operation="createSnapshot"
    ;;
    drop)
    operation="drop"
    ;;
    get11)
    operation="get11"
    ;;
    getConf)
    operation="getConf"
    ;;
    graphReadMode)
    operation="graphReadMode"
    ;;
    graphReadMode1)
    operation="graphReadMode1"
    ;;
    list9)
    operation="list9"
    ;;
    mode)
    operation="mode"
    ;;
    mode1)
    operation="mode1"
    ;;
    resumeSnapshot)
    operation="resumeSnapshot"
    ;;
    get9)
    operation="get9"
    ;;
    post1)
    operation="post1"
    ;;
    post4)
    operation="post4"
    ;;
    create2)
    operation="create2"
    ;;
    delete2)
    operation="delete2"
    ;;
    get2)
    operation="get2"
    ;;
    list2)
    operation="list2"
    ;;
    update2)
    operation="update2"
    ;;
    create12)
    operation="create12"
    ;;
    delete10)
    operation="delete10"
    ;;
    get13)
    operation="get13"
    ;;
    list13)
    operation="list13"
    ;;
    update12)
    operation="update12"
    ;;
    get20)
    operation="get20"
    ;;
    post9)
    operation="post9"
    ;;
    get21)
    operation="get21"
    ;;
    post10)
    operation="post10"
    ;;
    get22)
    operation="get22"
    ;;
    post11)
    operation="post11"
    ;;
    login)
    operation="login"
    ;;
    logout)
    operation="logout"
    ;;
    verifyToken)
    operation="verifyToken"
    ;;
    all)
    operation="all"
    ;;
    backend)
    operation="backend"
    ;;
    counters)
    operation="counters"
    ;;
    gauges)
    operation="gauges"
    ;;
    histograms)
    operation="histograms"
    ;;
    meters)
    operation="meters"
    ;;
    statistics)
    operation="statistics"
    ;;
    system)
    operation="system"
    ;;
    timers)
    operation="timers"
    ;;
    post12)
    operation="post12"
    ;;
    neighborRank)
    operation="neighborRank"
    ;;
    get23)
    operation="get23"
    ;;
    post13)
    operation="post13"
    ;;
    personalRank)
    operation="personalRank"
    ;;
    getProfile)
    operation="getProfile"
    ;;
    showAllAPIs)
    operation="showAllAPIs"
    ;;
    create3)
    operation="create3"
    ;;
    delete3)
    operation="delete3"
    ;;
    get3)
    operation="get3"
    ;;
    list3)
    operation="list3"
    ;;
    update3)
    operation="update3"
    ;;
    create13)
    operation="create13"
    ;;
    delete11)
    operation="delete11"
    ;;
    get14)
    operation="get14"
    ;;
    list14)
    operation="list14"
    ;;
    update13)
    operation="update13"
    ;;
    addPeer)
    operation="addPeer"
    ;;
    getLeader)
    operation="getLeader"
    ;;
    listPeers)
    operation="listPeers"
    ;;
    removePeer)
    operation="removePeer"
    ;;
    setLeader)
    operation="setLeader"
    ;;
    transferLeader)
    operation="transferLeader"
    ;;
    get24)
    operation="get24"
    ;;
    edgeLabelRebuild)
    operation="edgeLabelRebuild"
    ;;
    indexLabelRebuild)
    operation="indexLabelRebuild"
    ;;
    vertexLabelRebuild)
    operation="vertexLabelRebuild"
    ;;
    create15)
    operation="create15"
    ;;
    get25)
    operation="get25"
    ;;
    get26)
    operation="get26"
    ;;
    sameNeighbors)
    operation="sameNeighbors"
    ;;
    list15)
    operation="list15"
    ;;
    get27)
    operation="get27"
    ;;
    get28)
    operation="get28"
    ;;
    create4)
    operation="create4"
    ;;
    delete4)
    operation="delete4"
    ;;
    get4)
    operation="get4"
    ;;
    list4)
    operation="list4"
    ;;
    update4)
    operation="update4"
    ;;
    delete8)
    operation="delete8"
    ;;
    get10)
    operation="get10"
    ;;
    list8)
    operation="list8"
    ;;
    update10)
    operation="update10"
    ;;
    post14)
    operation="post14"
    ;;
    get6)
    operation="get6"
    ;;
    trace)
    operation="trace"
    ;;
    create5)
    operation="create5"
    ;;
    delete5)
    operation="delete5"
    ;;
    get5)
    operation="get5"
    ;;
    list5)
    operation="list5"
    ;;
    role)
    operation="role"
    ;;
    update5)
    operation="update5"
    ;;
    delete13)
    operation="delete13"
    ;;
    get30)
    operation="get30"
    ;;
    list19)
    operation="list19"
    ;;
    update15)
    operation="update15"
    ;;
    list10)
    operation="list10"
    ;;
    create8)
    operation="create8"
    ;;
    create9)
    operation="create9"
    ;;
    delete7)
    operation="delete7"
    ;;
    get8)
    operation="get8"
    ;;
    list7)
    operation="list7"
    ;;
    update8)
    operation="update8"
    ;;
    update9)
    operation="update9"
    ;;
    create14)
    operation="create14"
    ;;
    delete12)
    operation="delete12"
    ;;
    get15)
    operation="get15"
    ;;
    list16)
    operation="list16"
    ;;
    update14)
    operation="update14"
    ;;
    list18)
    operation="list18"
    ;;
    scan1)
    operation="scan1"
    ;;
    shards1)
    operation="shards1"
    ;;
    get29)
    operation="get29"
    ;;
    list11)
    operation="list11"
    ;;
    updateStatus)
    operation="updateStatus"
    ;;
    updateWhiteIPs)
    operation="updateWhiteIPs"
    ;;
    *==*)
    # Parse body arguments and convert them into top level
    # JSON properties passed in the body content as strings
    if [[ "$operation" ]]; then
        IFS='==' read -r body_key sep body_value <<< "$key"
        body_parameters[${body_key}]="\"${body_value}\""
    fi
    ;;
    --body=*)
    # Parse value of body as argument and convert it into only
    # the raw body content
    if [[ "$operation" ]]; then
        IFS='--body=' read -r body_value <<< "$key"
        body_value=${body_value##--body=}
        body_parameters["RAW_BODY"]="${body_value}"
        RAW_BODY=1
    fi
    ;;
    *:=*)
    # Parse body arguments and convert them into top level
    # JSON properties passed in the body content without quotes
    if [[ "$operation" ]]; then
        # ignore error about 'sep' being unused
        # shellcheck disable=SC2034
        IFS=':=' read -r body_key sep body_value <<< "$key"
        body_parameters[${body_key}]=${body_value}
    fi
    ;;
    +([^=]):*)
    # Parse header arguments and convert them into curl
    # only after the operation argument
    if [[ "$operation" ]]; then
        IFS=':' read -r header_name header_value <<< "$key"
        header_arguments[$header_name]=$header_value
    else
        curl_arguments+=" $key"
    fi
    ;;
    -)
    body_content_temp_file=$(mktemp)
    cat - > "$body_content_temp_file"
    ;;
    *=*)
    # Parse operation arguments and convert them into curl
    # only after the operation argument
    if [[ "$operation" ]]; then
        IFS='=' read -r parameter_name parameter_value <<< "$key"
        if [[ -z "${operation_parameters[$parameter_name]+foo}" ]]; then
            operation_parameters[$parameter_name]=$(url_escape "${parameter_value}")
        else
            operation_parameters[$parameter_name]+=":::"$(url_escape "${parameter_value}")
        fi
    else
        curl_arguments+=" $key"
    fi
    ;;
    *)
    # If we are before the operation, treat the arguments as cURL arguments
    if [[ "x$operation" == "x" ]]; then
        # Maintain quotes around cURL arguments if necessary
        space_regexp="[[:space:]]"
        if [[ $key =~ $space_regexp ]]; then
            curl_arguments+=" \"$key\""
        else
            curl_arguments+=" $key"
        fi
    fi
    ;;
esac
done


# Check if user provided host name
if [[ -z "$host" ]]; then
    ERROR_MSG="ERROR: No hostname provided!!! You have to  provide on command line option '--host ...'"
    exit 1
fi

# Check if user specified operation ID
if [[ -z "$operation" ]]; then
    ERROR_MSG="ERROR: No operation specified!!!"
    exit 1
fi


# Run cURL command based on the operation ID
case $operation in
    create)
    call_create
    ;;
    delete)
    call_delete
    ;;
    get)
    call_get
    ;;
    list)
    call_list
    ;;
    update)
    call_update
    ;;
    get16)
    call_get16
    ;;
    post2)
    call_post2
    ;;
    get17)
    call_get17
    ;;
    startArthas)
    call_startArthas
    ;;
    create1)
    call_create1
    ;;
    delete1)
    call_delete1
    ;;
    get1)
    call_get1
    ;;
    list1)
    call_list1
    ;;
    update1)
    call_update1
    ;;
    post3)
    call_post3
    ;;
    post5)
    call_post5
    ;;
    get18)
    call_get18
    ;;
    post6)
    call_post6
    ;;
    post7)
    call_post7
    ;;
    post)
    call_post
    ;;
    query)
    call_query
    ;;
    getExternalGrammar)
    call_getExternalGrammar
    ;;
    getWadl)
    call_getWadl
    ;;
    create6)
    call_create6
    ;;
    create7)
    call_create7
    ;;
    delete6)
    call_delete6
    ;;
    get7)
    call_get7
    ;;
    list6)
    call_list6
    ;;
    update6)
    call_update6
    ;;
    update7)
    call_update7
    ;;
    get19)
    call_get19
    ;;
    create11)
    call_create11
    ;;
    delete9)
    call_delete9
    ;;
    get12)
    call_get12
    ;;
    list12)
    call_list12
    ;;
    update11)
    call_update11
    ;;
    list17)
    call_list17
    ;;
    scan)
    call_scan
    ;;
    shards)
    call_shards
    ;;
    post8)
    call_post8
    ;;
    clear)
    call_clear
    ;;
    compact)
    call_compact
    ;;
    create10)
    call_create10
    ;;
    createSnapshot)
    call_createSnapshot
    ;;
    drop)
    call_drop
    ;;
    get11)
    call_get11
    ;;
    getConf)
    call_getConf
    ;;
    graphReadMode)
    call_graphReadMode
    ;;
    graphReadMode1)
    call_graphReadMode1
    ;;
    list9)
    call_list9
    ;;
    mode)
    call_mode
    ;;
    mode1)
    call_mode1
    ;;
    resumeSnapshot)
    call_resumeSnapshot
    ;;
    get9)
    call_get9
    ;;
    post1)
    call_post1
    ;;
    post4)
    call_post4
    ;;
    create2)
    call_create2
    ;;
    delete2)
    call_delete2
    ;;
    get2)
    call_get2
    ;;
    list2)
    call_list2
    ;;
    update2)
    call_update2
    ;;
    create12)
    call_create12
    ;;
    delete10)
    call_delete10
    ;;
    get13)
    call_get13
    ;;
    list13)
    call_list13
    ;;
    update12)
    call_update12
    ;;
    get20)
    call_get20
    ;;
    post9)
    call_post9
    ;;
    get21)
    call_get21
    ;;
    post10)
    call_post10
    ;;
    get22)
    call_get22
    ;;
    post11)
    call_post11
    ;;
    login)
    call_login
    ;;
    logout)
    call_logout
    ;;
    verifyToken)
    call_verifyToken
    ;;
    all)
    call_all
    ;;
    backend)
    call_backend
    ;;
    counters)
    call_counters
    ;;
    gauges)
    call_gauges
    ;;
    histograms)
    call_histograms
    ;;
    meters)
    call_meters
    ;;
    statistics)
    call_statistics
    ;;
    system)
    call_system
    ;;
    timers)
    call_timers
    ;;
    post12)
    call_post12
    ;;
    neighborRank)
    call_neighborRank
    ;;
    get23)
    call_get23
    ;;
    post13)
    call_post13
    ;;
    personalRank)
    call_personalRank
    ;;
    getProfile)
    call_getProfile
    ;;
    showAllAPIs)
    call_showAllAPIs
    ;;
    create3)
    call_create3
    ;;
    delete3)
    call_delete3
    ;;
    get3)
    call_get3
    ;;
    list3)
    call_list3
    ;;
    update3)
    call_update3
    ;;
    create13)
    call_create13
    ;;
    delete11)
    call_delete11
    ;;
    get14)
    call_get14
    ;;
    list14)
    call_list14
    ;;
    update13)
    call_update13
    ;;
    addPeer)
    call_addPeer
    ;;
    getLeader)
    call_getLeader
    ;;
    listPeers)
    call_listPeers
    ;;
    removePeer)
    call_removePeer
    ;;
    setLeader)
    call_setLeader
    ;;
    transferLeader)
    call_transferLeader
    ;;
    get24)
    call_get24
    ;;
    edgeLabelRebuild)
    call_edgeLabelRebuild
    ;;
    indexLabelRebuild)
    call_indexLabelRebuild
    ;;
    vertexLabelRebuild)
    call_vertexLabelRebuild
    ;;
    create15)
    call_create15
    ;;
    get25)
    call_get25
    ;;
    get26)
    call_get26
    ;;
    sameNeighbors)
    call_sameNeighbors
    ;;
    list15)
    call_list15
    ;;
    get27)
    call_get27
    ;;
    get28)
    call_get28
    ;;
    create4)
    call_create4
    ;;
    delete4)
    call_delete4
    ;;
    get4)
    call_get4
    ;;
    list4)
    call_list4
    ;;
    update4)
    call_update4
    ;;
    delete8)
    call_delete8
    ;;
    get10)
    call_get10
    ;;
    list8)
    call_list8
    ;;
    update10)
    call_update10
    ;;
    post14)
    call_post14
    ;;
    get6)
    call_get6
    ;;
    trace)
    call_trace
    ;;
    create5)
    call_create5
    ;;
    delete5)
    call_delete5
    ;;
    get5)
    call_get5
    ;;
    list5)
    call_list5
    ;;
    role)
    call_role
    ;;
    update5)
    call_update5
    ;;
    delete13)
    call_delete13
    ;;
    get30)
    call_get30
    ;;
    list19)
    call_list19
    ;;
    update15)
    call_update15
    ;;
    list10)
    call_list10
    ;;
    create8)
    call_create8
    ;;
    create9)
    call_create9
    ;;
    delete7)
    call_delete7
    ;;
    get8)
    call_get8
    ;;
    list7)
    call_list7
    ;;
    update8)
    call_update8
    ;;
    update9)
    call_update9
    ;;
    create14)
    call_create14
    ;;
    delete12)
    call_delete12
    ;;
    get15)
    call_get15
    ;;
    list16)
    call_list16
    ;;
    update14)
    call_update14
    ;;
    list18)
    call_list18
    ;;
    scan1)
    call_scan1
    ;;
    shards1)
    call_shards1
    ;;
    get29)
    call_get29
    ;;
    list11)
    call_list11
    ;;
    updateStatus)
    call_updateStatus
    ;;
    updateWhiteIPs)
    call_updateWhiteIPs
    ;;
    *)
    ERROR_MSG="ERROR: Unknown operation: $operation"
    exit 1
esac
