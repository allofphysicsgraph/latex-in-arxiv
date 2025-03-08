# RaftAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**addPeer**](RaftAPIApi.md#addPeer) | **POST** /graphs/{graph}/raft/add_peer | 
[**getLeader**](RaftAPIApi.md#getLeader) | **GET** /graphs/{graph}/raft/get_leader | 
[**listPeers**](RaftAPIApi.md#listPeers) | **GET** /graphs/{graph}/raft/list_peers | 
[**removePeer**](RaftAPIApi.md#removePeer) | **POST** /graphs/{graph}/raft/remove_peer | 
[**setLeader**](RaftAPIApi.md#setLeader) | **POST** /graphs/{graph}/raft/set_leader | 
[**transferLeader**](RaftAPIApi.md#transferLeader) | **POST** /graphs/{graph}/raft/transfer_leader | 



## addPeer



### Example

```bash
 addPeer graph=value  group=value  endpoint=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **group** | **string** |  | [optional] [default to default]
 **endpoint** | **string** |  | [optional] [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## getLeader



### Example

```bash
 getLeader graph=value  group=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **group** | **string** |  | [optional] [default to default]

### Return type

**map[String, string]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## listPeers



### Example

```bash
 listPeers graph=value  group=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **group** | **string** |  | [optional] [default to default]

### Return type

**map[String, array[string]]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## removePeer



### Example

```bash
 removePeer graph=value  group=value  endpoint=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **group** | **string** |  | [optional] [default to default]
 **endpoint** | **string** |  | [optional] [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## setLeader



### Example

```bash
 setLeader graph=value  group=value  endpoint=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **group** | **string** |  | [optional] [default to default]
 **endpoint** | **string** |  | [optional] [default to null]

### Return type

**map[String, string]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## transferLeader



### Example

```bash
 transferLeader graph=value  group=value  endpoint=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **group** | **string** |  | [optional] [default to default]
 **endpoint** | **string** |  | [optional] [default to null]

### Return type

**map[String, string]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

