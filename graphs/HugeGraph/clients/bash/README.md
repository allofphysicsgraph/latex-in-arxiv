# HugeGraph RESTful API Bash client

## Overview

This is a Bash client script for accessing HugeGraph RESTful API service.

The script uses cURL underneath for making all REST calls.

## Usage

```shell
# Make sure the script has executable rights
$ chmod u+x 

# Print the list of operations available on the service
$ ./ -h

# Print the service description
$ ./ --about

# Print detailed information about specific operation
$ ./ <operationId> -h

# Make GET request
./ --host http://<hostname>:<port> --accept xml <operationId> <queryParam1>=<value1> <header_key1>:<header_value2>

# Make GET request using arbitrary curl options (must be passed before <operationId>) to an SSL service using username:password
 -k -sS --tlsv1.2 --host https://<hostname> -u <user>:<password> --accept xml <operationId> <queryParam1>=<value1> <header_key1>:<header_value2>

# Make POST request
$ echo '<body_content>' |  --host <hostname> --content-type json <operationId> -

# Make POST request with simple JSON content, e.g.:
# {
#   "key1": "value1",
#   "key2": "value2",
#   "key3": 23
# }
$ echo '<body_content>' |  --host <hostname> --content-type json <operationId> key1==value1 key2=value2 key3:=23 -

# Make POST request with form data
$  --host <hostname> <operationId> key1:=value1 key2:=value2 key3:=23

# Preview the cURL command without actually executing it
$  --host http://<hostname>:<port> --dry-run <operationid>

```

## Docker image

You can easily create a Docker image containing a preconfigured environment
for using the REST Bash client including working autocompletion and short
welcome message with basic instructions, using the generated Dockerfile:

```shell
docker build -t my-rest-client .
docker run -it my-rest-client
```

By default you will be logged into a Zsh environment which has much more
advanced auto completion, but you can switch to Bash, where basic autocompletion
is also available.

## Shell completion

### Bash

The generated bash-completion script can be either directly loaded to the current Bash session using:

```shell
source .bash-completion
```

Alternatively, the script can be copied to the `/etc/bash-completion.d` (or on OSX with Homebrew to `/usr/local/etc/bash-completion.d`):

```shell
sudo cp .bash-completion /etc/bash-completion.d/
```

#### OS X

On OSX you might need to install bash-completion using Homebrew:

```shell
brew install bash-completion
```

and add the following to the `~/.bashrc`:

```shell
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
```

### Zsh

In Zsh, the generated `_` Zsh completion file must be copied to one of the folders under `$FPATH` variable.

## Documentation for API Endpoints

All URIs are relative to **

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*AccessAPIApi* | [**create**](docs/AccessAPIApi.md#create) | **POST** /graphs/{graph}/auth/accesses | 
*AccessAPIApi* | [**delete**](docs/AccessAPIApi.md#delete) | **DELETE** /graphs/{graph}/auth/accesses/{id} | 
*AccessAPIApi* | [**get**](docs/AccessAPIApi.md#get) | **GET** /graphs/{graph}/auth/accesses/{id} | 
*AccessAPIApi* | [**list**](docs/AccessAPIApi.md#list) | **GET** /graphs/{graph}/auth/accesses | 
*AccessAPIApi* | [**update**](docs/AccessAPIApi.md#update) | **PUT** /graphs/{graph}/auth/accesses/{id} | 
*AdamicAdarAPIApi* | [**get16**](docs/AdamicAdarAPIApi.md#get16) | **GET** /graphs/{graph}/traversers/adamicadar | 
*AlgorithmAPIApi* | [**post2**](docs/AlgorithmAPIApi.md#post2) | **POST** /graphs/{graph}/jobs/algorithm/{name} | 
*AllShortestPathsAPIApi* | [**get17**](docs/AllShortestPathsAPIApi.md#get17) | **GET** /graphs/{graph}/traversers/allshortestpaths | 
*ArthasAPIApi* | [**startArthas**](docs/ArthasAPIApi.md#startarthas) | **PUT** /arthas | start arthas agent
*BelongAPIApi* | [**create1**](docs/BelongAPIApi.md#create1) | **POST** /graphs/{graph}/auth/belongs | 
*BelongAPIApi* | [**delete1**](docs/BelongAPIApi.md#delete1) | **DELETE** /graphs/{graph}/auth/belongs/{id} | 
*BelongAPIApi* | [**get1**](docs/BelongAPIApi.md#get1) | **GET** /graphs/{graph}/auth/belongs/{id} | 
*BelongAPIApi* | [**list1**](docs/BelongAPIApi.md#list1) | **GET** /graphs/{graph}/auth/belongs | 
*BelongAPIApi* | [**update1**](docs/BelongAPIApi.md#update1) | **PUT** /graphs/{graph}/auth/belongs/{id} | 
*ComputerAPIApi* | [**post3**](docs/ComputerAPIApi.md#post3) | **POST** /graphs/{graph}/jobs/computer/{name} | 
*CountAPIApi* | [**post5**](docs/CountAPIApi.md#post5) | **POST** /graphs/{graph}/traversers/count | 
*CrosspointsAPIApi* | [**get18**](docs/CrosspointsAPIApi.md#get18) | **GET** /graphs/{graph}/traversers/crosspoints | 
*CustomizedCrosspointsAPIApi* | [**post6**](docs/CustomizedCrosspointsAPIApi.md#post6) | **POST** /graphs/{graph}/traversers/customizedcrosspoints | 
*CustomizedPathsAPIApi* | [**post7**](docs/CustomizedPathsAPIApi.md#post7) | **POST** /graphs/{graph}/traversers/customizedpaths | 
*CypherAPIApi* | [**post**](docs/CypherAPIApi.md#post) | **POST** /graphs/{graph}/cypher | 
*CypherAPIApi* | [**query**](docs/CypherAPIApi.md#query) | **GET** /graphs/{graph}/cypher | 
*DefaultApi* | [**getExternalGrammar**](docs/DefaultApi.md#getexternalgrammar) | **GET** /application.wadl/{path} | 
*DefaultApi* | [**getWadl**](docs/DefaultApi.md#getwadl) | **GET** /application.wadl | 
*EdgeAPIApi* | [**create6**](docs/EdgeAPIApi.md#create6) | **POST** /graphs/{graph}/graph/edges | 
*EdgeAPIApi* | [**create7**](docs/EdgeAPIApi.md#create7) | **POST** /graphs/{graph}/graph/edges/batch | 
*EdgeAPIApi* | [**delete6**](docs/EdgeAPIApi.md#delete6) | **DELETE** /graphs/{graph}/graph/edges/{id} | 
*EdgeAPIApi* | [**get7**](docs/EdgeAPIApi.md#get7) | **GET** /graphs/{graph}/graph/edges/{id} | 
*EdgeAPIApi* | [**list6**](docs/EdgeAPIApi.md#list6) | **GET** /graphs/{graph}/graph/edges | 
*EdgeAPIApi* | [**update6**](docs/EdgeAPIApi.md#update6) | **PUT** /graphs/{graph}/graph/edges/batch | 
*EdgeAPIApi* | [**update7**](docs/EdgeAPIApi.md#update7) | **PUT** /graphs/{graph}/graph/edges/{id} | 
*EdgeExistenceAPIApi* | [**get19**](docs/EdgeExistenceAPIApi.md#get19) | **GET** /graphs/{graph}/traversers/edgeexist | get edges from &#39;source&#39; to &#39;target&#39; vertex
*EdgeLabelAPIApi* | [**create11**](docs/EdgeLabelAPIApi.md#create11) | **POST** /graphs/{graph}/schema/edgelabels | 
*EdgeLabelAPIApi* | [**delete9**](docs/EdgeLabelAPIApi.md#delete9) | **DELETE** /graphs/{graph}/schema/edgelabels/{name} | 
*EdgeLabelAPIApi* | [**get12**](docs/EdgeLabelAPIApi.md#get12) | **GET** /graphs/{graph}/schema/edgelabels/{name} | 
*EdgeLabelAPIApi* | [**list12**](docs/EdgeLabelAPIApi.md#list12) | **GET** /graphs/{graph}/schema/edgelabels | 
*EdgeLabelAPIApi* | [**update11**](docs/EdgeLabelAPIApi.md#update11) | **PUT** /graphs/{graph}/schema/edgelabels/{name} | 
*EdgesAPIApi* | [**list17**](docs/EdgesAPIApi.md#list17) | **GET** /graphs/{graph}/traversers/edges | 
*EdgesAPIApi* | [**scan**](docs/EdgesAPIApi.md#scan) | **GET** /graphs/{graph}/traversers/edges/scan | 
*EdgesAPIApi* | [**shards**](docs/EdgesAPIApi.md#shards) | **GET** /graphs/{graph}/traversers/edges/shards | 
*FusiformSimilarityAPIApi* | [**post8**](docs/FusiformSimilarityAPIApi.md#post8) | **POST** /graphs/{graph}/traversers/fusiformsimilarity | 
*GraphsAPIApi* | [**clear**](docs/GraphsAPIApi.md#clear) | **DELETE** /graphs/{name}/clear | 
*GraphsAPIApi* | [**compact**](docs/GraphsAPIApi.md#compact) | **PUT** /graphs/{name}/compact | 
*GraphsAPIApi* | [**create10**](docs/GraphsAPIApi.md#create10) | **POST** /graphs/{name} | 
*GraphsAPIApi* | [**createSnapshot**](docs/GraphsAPIApi.md#createsnapshot) | **PUT** /graphs/{name}/snapshot_create | 
*GraphsAPIApi* | [**drop**](docs/GraphsAPIApi.md#drop) | **DELETE** /graphs/{name} | 
*GraphsAPIApi* | [**get11**](docs/GraphsAPIApi.md#get11) | **GET** /graphs/{name} | 
*GraphsAPIApi* | [**getConf**](docs/GraphsAPIApi.md#getconf) | **GET** /graphs/{name}/conf | 
*GraphsAPIApi* | [**graphReadMode**](docs/GraphsAPIApi.md#graphreadmode) | **GET** /graphs/{name}/graph_read_mode | 
*GraphsAPIApi* | [**graphReadMode1**](docs/GraphsAPIApi.md#graphreadmode1) | **PUT** /graphs/{name}/graph_read_mode | 
*GraphsAPIApi* | [**list9**](docs/GraphsAPIApi.md#list9) | **GET** /graphs | 
*GraphsAPIApi* | [**mode**](docs/GraphsAPIApi.md#mode) | **GET** /graphs/{name}/mode | 
*GraphsAPIApi* | [**mode1**](docs/GraphsAPIApi.md#mode1) | **PUT** /graphs/{name}/mode | 
*GraphsAPIApi* | [**resumeSnapshot**](docs/GraphsAPIApi.md#resumesnapshot) | **PUT** /graphs/{name}/snapshot_resume | 
*GremlinAPIApi* | [**get9**](docs/GremlinAPIApi.md#get9) | **GET** /gremlin | 
*GremlinAPIApi* | [**post1**](docs/GremlinAPIApi.md#post1) | **POST** /gremlin | 
*GremlinAPIApi* | [**post4**](docs/GremlinAPIApi.md#post4) | **POST** /graphs/{graph}/jobs/gremlin | 
*GroupAPIApi* | [**create2**](docs/GroupAPIApi.md#create2) | **POST** /graphs/{graph}/auth/groups | 
*GroupAPIApi* | [**delete2**](docs/GroupAPIApi.md#delete2) | **DELETE** /graphs/{graph}/auth/groups/{id} | 
*GroupAPIApi* | [**get2**](docs/GroupAPIApi.md#get2) | **GET** /graphs/{graph}/auth/groups/{id} | 
*GroupAPIApi* | [**list2**](docs/GroupAPIApi.md#list2) | **GET** /graphs/{graph}/auth/groups | 
*GroupAPIApi* | [**update2**](docs/GroupAPIApi.md#update2) | **PUT** /graphs/{graph}/auth/groups/{id} | 
*IndexLabelAPIApi* | [**create12**](docs/IndexLabelAPIApi.md#create12) | **POST** /graphs/{graph}/schema/indexlabels | 
*IndexLabelAPIApi* | [**delete10**](docs/IndexLabelAPIApi.md#delete10) | **DELETE** /graphs/{graph}/schema/indexlabels/{name} | 
*IndexLabelAPIApi* | [**get13**](docs/IndexLabelAPIApi.md#get13) | **GET** /graphs/{graph}/schema/indexlabels/{name} | 
*IndexLabelAPIApi* | [**list13**](docs/IndexLabelAPIApi.md#list13) | **GET** /graphs/{graph}/schema/indexlabels | 
*IndexLabelAPIApi* | [**update12**](docs/IndexLabelAPIApi.md#update12) | **PUT** /graphs/{graph}/schema/indexlabels/{name} | 
*JaccardSimilarityAPIApi* | [**get20**](docs/JaccardSimilarityAPIApi.md#get20) | **GET** /graphs/{graph}/traversers/jaccardsimilarity | 
*JaccardSimilarityAPIApi* | [**post9**](docs/JaccardSimilarityAPIApi.md#post9) | **POST** /graphs/{graph}/traversers/jaccardsimilarity | 
*KneighborAPIApi* | [**get21**](docs/KneighborAPIApi.md#get21) | **GET** /graphs/{graph}/traversers/kneighbor | 
*KneighborAPIApi* | [**post10**](docs/KneighborAPIApi.md#post10) | **POST** /graphs/{graph}/traversers/kneighbor | 
*KoutAPIApi* | [**get22**](docs/KoutAPIApi.md#get22) | **GET** /graphs/{graph}/traversers/kout | 
*KoutAPIApi* | [**post11**](docs/KoutAPIApi.md#post11) | **POST** /graphs/{graph}/traversers/kout | 
*LoginAPIApi* | [**login**](docs/LoginAPIApi.md#login) | **POST** /graphs/{graph}/auth/login | 
*LoginAPIApi* | [**logout**](docs/LoginAPIApi.md#logout) | **DELETE** /graphs/{graph}/auth/logout | 
*LoginAPIApi* | [**verifyToken**](docs/LoginAPIApi.md#verifytoken) | **GET** /graphs/{graph}/auth/verify | 
*MetricsAPIApi* | [**all**](docs/MetricsAPIApi.md#all) | **GET** /metrics | get all base metrics
*MetricsAPIApi* | [**backend**](docs/MetricsAPIApi.md#backend) | **GET** /metrics/backend | get the backend metrics
*MetricsAPIApi* | [**counters**](docs/MetricsAPIApi.md#counters) | **GET** /metrics/counters | get the counters metrics
*MetricsAPIApi* | [**gauges**](docs/MetricsAPIApi.md#gauges) | **GET** /metrics/gauges | get the gauges metrics
*MetricsAPIApi* | [**histograms**](docs/MetricsAPIApi.md#histograms) | **GET** /metrics/histograms | get the histograms metrics
*MetricsAPIApi* | [**meters**](docs/MetricsAPIApi.md#meters) | **GET** /metrics/meters | get the meters metrics
*MetricsAPIApi* | [**statistics**](docs/MetricsAPIApi.md#statistics) | **GET** /metrics/statistics | get all statistics metrics
*MetricsAPIApi* | [**system**](docs/MetricsAPIApi.md#system) | **GET** /metrics/system | get the system metrics
*MetricsAPIApi* | [**timers**](docs/MetricsAPIApi.md#timers) | **GET** /metrics/timers | get the timers metrics
*MultiNodeShortestPathAPIApi* | [**post12**](docs/MultiNodeShortestPathAPIApi.md#post12) | **POST** /graphs/{graph}/traversers/multinodeshortestpath | 
*NeighborRankAPIApi* | [**neighborRank**](docs/NeighborRankAPIApi.md#neighborrank) | **POST** /graphs/{graph}/traversers/neighborrank | 
*PathsAPIApi* | [**get23**](docs/PathsAPIApi.md#get23) | **GET** /graphs/{graph}/traversers/paths | 
*PathsAPIApi* | [**post13**](docs/PathsAPIApi.md#post13) | **POST** /graphs/{graph}/traversers/paths | 
*PersonalRankAPIApi* | [**personalRank**](docs/PersonalRankAPIApi.md#personalrank) | **POST** /graphs/{graph}/traversers/personalrank | 
*ProfileAPIApi* | [**getProfile**](docs/ProfileAPIApi.md#getprofile) | **GET** / | 
*ProfileAPIApi* | [**showAllAPIs**](docs/ProfileAPIApi.md#showallapis) | **GET** /apis | 
*ProjectAPIApi* | [**create3**](docs/ProjectAPIApi.md#create3) | **POST** /graphs/{graph}/auth/projects | 
*ProjectAPIApi* | [**delete3**](docs/ProjectAPIApi.md#delete3) | **DELETE** /graphs/{graph}/auth/projects/{id} | 
*ProjectAPIApi* | [**get3**](docs/ProjectAPIApi.md#get3) | **GET** /graphs/{graph}/auth/projects/{id} | 
*ProjectAPIApi* | [**list3**](docs/ProjectAPIApi.md#list3) | **GET** /graphs/{graph}/auth/projects | 
*ProjectAPIApi* | [**update3**](docs/ProjectAPIApi.md#update3) | **PUT** /graphs/{graph}/auth/projects/{id} | 
*PropertyKeyAPIApi* | [**create13**](docs/PropertyKeyAPIApi.md#create13) | **POST** /graphs/{graph}/schema/propertykeys | 
*PropertyKeyAPIApi* | [**delete11**](docs/PropertyKeyAPIApi.md#delete11) | **DELETE** /graphs/{graph}/schema/propertykeys/{name} | 
*PropertyKeyAPIApi* | [**get14**](docs/PropertyKeyAPIApi.md#get14) | **GET** /graphs/{graph}/schema/propertykeys/{name} | 
*PropertyKeyAPIApi* | [**list14**](docs/PropertyKeyAPIApi.md#list14) | **GET** /graphs/{graph}/schema/propertykeys | 
*PropertyKeyAPIApi* | [**update13**](docs/PropertyKeyAPIApi.md#update13) | **PUT** /graphs/{graph}/schema/propertykeys/{name} | 
*RaftAPIApi* | [**addPeer**](docs/RaftAPIApi.md#addpeer) | **POST** /graphs/{graph}/raft/add_peer | 
*RaftAPIApi* | [**getLeader**](docs/RaftAPIApi.md#getleader) | **GET** /graphs/{graph}/raft/get_leader | 
*RaftAPIApi* | [**listPeers**](docs/RaftAPIApi.md#listpeers) | **GET** /graphs/{graph}/raft/list_peers | 
*RaftAPIApi* | [**removePeer**](docs/RaftAPIApi.md#removepeer) | **POST** /graphs/{graph}/raft/remove_peer | 
*RaftAPIApi* | [**setLeader**](docs/RaftAPIApi.md#setleader) | **POST** /graphs/{graph}/raft/set_leader | 
*RaftAPIApi* | [**transferLeader**](docs/RaftAPIApi.md#transferleader) | **POST** /graphs/{graph}/raft/transfer_leader | 
*RaysAPIApi* | [**get24**](docs/RaysAPIApi.md#get24) | **GET** /graphs/{graph}/traversers/rays | 
*RebuildAPIApi* | [**edgeLabelRebuild**](docs/RebuildAPIApi.md#edgelabelrebuild) | **PUT** /graphs/{graph}/jobs/rebuild/edgelabels/{name} | 
*RebuildAPIApi* | [**indexLabelRebuild**](docs/RebuildAPIApi.md#indexlabelrebuild) | **PUT** /graphs/{graph}/jobs/rebuild/indexlabels/{name} | 
*RebuildAPIApi* | [**vertexLabelRebuild**](docs/RebuildAPIApi.md#vertexlabelrebuild) | **PUT** /graphs/{graph}/jobs/rebuild/vertexlabels/{name} | 
*ResourceAllocationAPIApi* | [**create15**](docs/ResourceAllocationAPIApi.md#create15) | **GET** /graphs/{graph}/traversers/resourceallocation | 
*RingsAPIApi* | [**get25**](docs/RingsAPIApi.md#get25) | **GET** /graphs/{graph}/traversers/rings | 
*SameNeighborsAPIApi* | [**get26**](docs/SameNeighborsAPIApi.md#get26) | **GET** /graphs/{graph}/traversers/sameneighbors | 
*SameNeighborsAPIApi* | [**sameNeighbors**](docs/SameNeighborsAPIApi.md#sameneighbors) | **POST** /graphs/{graph}/traversers/sameneighbors | 
*SchemaAPIApi* | [**list15**](docs/SchemaAPIApi.md#list15) | **GET** /graphs/{graph}/schema | 
*ShortestPathAPIApi* | [**get27**](docs/ShortestPathAPIApi.md#get27) | **GET** /graphs/{graph}/traversers/shortestpath | 
*SingleSourceShortestPathAPIApi* | [**get28**](docs/SingleSourceShortestPathAPIApi.md#get28) | **GET** /graphs/{graph}/traversers/singlesourceshortestpath | 
*TargetAPIApi* | [**create4**](docs/TargetAPIApi.md#create4) | **POST** /graphs/{graph}/auth/targets | 
*TargetAPIApi* | [**delete4**](docs/TargetAPIApi.md#delete4) | **DELETE** /graphs/{graph}/auth/targets/{id} | 
*TargetAPIApi* | [**get4**](docs/TargetAPIApi.md#get4) | **GET** /graphs/{graph}/auth/targets/{id} | 
*TargetAPIApi* | [**list4**](docs/TargetAPIApi.md#list4) | **GET** /graphs/{graph}/auth/targets | 
*TargetAPIApi* | [**update4**](docs/TargetAPIApi.md#update4) | **PUT** /graphs/{graph}/auth/targets/{id} | 
*TaskAPIApi* | [**delete8**](docs/TaskAPIApi.md#delete8) | **DELETE** /graphs/{graph}/tasks/{id} | 
*TaskAPIApi* | [**get10**](docs/TaskAPIApi.md#get10) | **GET** /graphs/{graph}/tasks/{id} | 
*TaskAPIApi* | [**list8**](docs/TaskAPIApi.md#list8) | **GET** /graphs/{graph}/tasks | 
*TaskAPIApi* | [**update10**](docs/TaskAPIApi.md#update10) | **PUT** /graphs/{graph}/tasks/{id} | 
*TemplatePathsAPIApi* | [**post14**](docs/TemplatePathsAPIApi.md#post14) | **POST** /graphs/{graph}/traversers/templatepaths | 
*TracedExceptionAPIApi* | [**get6**](docs/TracedExceptionAPIApi.md#get6) | **GET** /exception/trace | 
*TracedExceptionAPIApi* | [**trace**](docs/TracedExceptionAPIApi.md#trace) | **PUT** /exception/trace | 
*UserAPIApi* | [**create5**](docs/UserAPIApi.md#create5) | **POST** /graphs/{graph}/auth/users | 
*UserAPIApi* | [**delete5**](docs/UserAPIApi.md#delete5) | **DELETE** /graphs/{graph}/auth/users/{id} | 
*UserAPIApi* | [**get5**](docs/UserAPIApi.md#get5) | **GET** /graphs/{graph}/auth/users/{id} | 
*UserAPIApi* | [**list5**](docs/UserAPIApi.md#list5) | **GET** /graphs/{graph}/auth/users | 
*UserAPIApi* | [**role**](docs/UserAPIApi.md#role) | **GET** /graphs/{graph}/auth/users/{id}/role | 
*UserAPIApi* | [**update5**](docs/UserAPIApi.md#update5) | **PUT** /graphs/{graph}/auth/users/{id} | 
*VariablesAPIApi* | [**delete13**](docs/VariablesAPIApi.md#delete13) | **DELETE** /graphs/{graph}/variables/{key} | 
*VariablesAPIApi* | [**get30**](docs/VariablesAPIApi.md#get30) | **GET** /graphs/{graph}/variables/{key} | 
*VariablesAPIApi* | [**list19**](docs/VariablesAPIApi.md#list19) | **GET** /graphs/{graph}/variables | 
*VariablesAPIApi* | [**update15**](docs/VariablesAPIApi.md#update15) | **PUT** /graphs/{graph}/variables/{key} | 
*VersionAPIApi* | [**list10**](docs/VersionAPIApi.md#list10) | **GET** /versions | 
*VertexAPIApi* | [**create8**](docs/VertexAPIApi.md#create8) | **POST** /graphs/{graph}/graph/vertices | 
*VertexAPIApi* | [**create9**](docs/VertexAPIApi.md#create9) | **POST** /graphs/{graph}/graph/vertices/batch | 
*VertexAPIApi* | [**delete7**](docs/VertexAPIApi.md#delete7) | **DELETE** /graphs/{graph}/graph/vertices/{id} | 
*VertexAPIApi* | [**get8**](docs/VertexAPIApi.md#get8) | **GET** /graphs/{graph}/graph/vertices/{id} | 
*VertexAPIApi* | [**list7**](docs/VertexAPIApi.md#list7) | **GET** /graphs/{graph}/graph/vertices | 
*VertexAPIApi* | [**update8**](docs/VertexAPIApi.md#update8) | **PUT** /graphs/{graph}/graph/vertices/batch | 
*VertexAPIApi* | [**update9**](docs/VertexAPIApi.md#update9) | **PUT** /graphs/{graph}/graph/vertices/{id} | 
*VertexLabelAPIApi* | [**create14**](docs/VertexLabelAPIApi.md#create14) | **POST** /graphs/{graph}/schema/vertexlabels | 
*VertexLabelAPIApi* | [**delete12**](docs/VertexLabelAPIApi.md#delete12) | **DELETE** /graphs/{graph}/schema/vertexlabels/{name} | 
*VertexLabelAPIApi* | [**get15**](docs/VertexLabelAPIApi.md#get15) | **GET** /graphs/{graph}/schema/vertexlabels/{name} | 
*VertexLabelAPIApi* | [**list16**](docs/VertexLabelAPIApi.md#list16) | **GET** /graphs/{graph}/schema/vertexlabels | 
*VertexLabelAPIApi* | [**update14**](docs/VertexLabelAPIApi.md#update14) | **PUT** /graphs/{graph}/schema/vertexlabels/{name} | 
*VerticesAPIApi* | [**list18**](docs/VerticesAPIApi.md#list18) | **GET** /graphs/{graph}/traversers/vertices | 
*VerticesAPIApi* | [**scan1**](docs/VerticesAPIApi.md#scan1) | **GET** /graphs/{graph}/traversers/vertices/scan | 
*VerticesAPIApi* | [**shards1**](docs/VerticesAPIApi.md#shards1) | **GET** /graphs/{graph}/traversers/vertices/shards | 
*WeightedShortestPathAPIApi* | [**get29**](docs/WeightedShortestPathAPIApi.md#get29) | **GET** /graphs/{graph}/traversers/weightedshortestpath | 
*WhiteIpListAPIApi* | [**list11**](docs/WhiteIpListAPIApi.md#list11) | **GET** /whiteiplist | list white ips
*WhiteIpListAPIApi* | [**updateStatus**](docs/WhiteIpListAPIApi.md#updatestatus) | **PUT** /whiteiplist | enable/disable the white ip list
*WhiteIpListAPIApi* | [**updateWhiteIPs**](docs/WhiteIpListAPIApi.md#updatewhiteips) | **POST** /whiteiplist | update white ip list


## Documentation For Models

 - [BatchEdgeRequest](docs/BatchEdgeRequest.md)
 - [BatchVertexRequest](docs/BatchVertexRequest.md)
 - [CountRequest](docs/CountRequest.md)
 - [CrosspointsRequest](docs/CrosspointsRequest.md)
 - [CypherModel](docs/CypherModel.md)
 - [FusiformSimilarityRequest](docs/FusiformSimilarityRequest.md)
 - [GremlinRequest](docs/GremlinRequest.md)
 - [JsonAccess](docs/JsonAccess.md)
 - [JsonBelong](docs/JsonBelong.md)
 - [JsonEdge](docs/JsonEdge.md)
 - [JsonEdgeLabel](docs/JsonEdgeLabel.md)
 - [JsonEdgeLabelUserData](docs/JsonEdgeLabelUserData.md)
 - [JsonGroup](docs/JsonGroup.md)
 - [JsonIndexLabel](docs/JsonIndexLabel.md)
 - [JsonLogin](docs/JsonLogin.md)
 - [JsonProject](docs/JsonProject.md)
 - [JsonPropertyKey](docs/JsonPropertyKey.md)
 - [JsonTarget](docs/JsonTarget.md)
 - [JsonUser](docs/JsonUser.md)
 - [JsonVariableValue](docs/JsonVariableValue.md)
 - [JsonVertex](docs/JsonVertex.md)
 - [JsonVertexLabel](docs/JsonVertexLabel.md)
 - [PathPattern](docs/PathPattern.md)
 - [PathRequest](docs/PathRequest.md)
 - [RankRequest](docs/RankRequest.md)
 - [Request](docs/Request.md)
 - [Result](docs/Result.md)
 - [Status](docs/Status.md)
 - [Step](docs/Step.md)
 - [TemplatePathStep](docs/TemplatePathStep.md)
 - [Userdata](docs/Userdata.md)
 - [VEStepEntity](docs/VEStepEntity.md)
 - [VESteps](docs/VESteps.md)
 - [Vertices](docs/Vertices.md)


## Documentation For Authorization


## bearer


- **Type**: HTTP Bearer Token authentication

## basic


- **Type**: HTTP basic authentication

