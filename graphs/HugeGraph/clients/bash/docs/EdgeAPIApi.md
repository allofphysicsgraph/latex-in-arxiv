# EdgeAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**create6**](EdgeAPIApi.md#create6) | **POST** /graphs/{graph}/graph/edges | 
[**create7**](EdgeAPIApi.md#create7) | **POST** /graphs/{graph}/graph/edges/batch | 
[**delete6**](EdgeAPIApi.md#delete6) | **DELETE** /graphs/{graph}/graph/edges/{id} | 
[**get7**](EdgeAPIApi.md#get7) | **GET** /graphs/{graph}/graph/edges/{id} | 
[**list6**](EdgeAPIApi.md#list6) | **GET** /graphs/{graph}/graph/edges | 
[**update6**](EdgeAPIApi.md#update6) | **PUT** /graphs/{graph}/graph/edges/batch | 
[**update7**](EdgeAPIApi.md#update7) | **PUT** /graphs/{graph}/graph/edges/{id} | 



## create6



### Example

```bash
 create6 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonEdge** | [**JsonEdge**](JsonEdge.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## create7



### Example

```bash
 create7 graph=value  check_vertex=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **checkVertex** | **boolean** |  | [optional] [default to true]
 **jsonEdge** | [**array[JsonEdge]**](JsonEdge.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## delete6



### Example

```bash
 delete6 graph=value id=value  label=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **string** |  | [default to null]
 **label** | **string** |  | [optional] [default to null]

### Return type

(empty response body)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## get7



### Example

```bash
 get7 graph=value id=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **string** |  | [default to null]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## list6



### Example

```bash
 list6 graph=value  vertex_id=value  direction=value  label=value  properties=value  keep_start_p=value  offset=value  page=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **vertexId** | **string** |  | [optional] [default to null]
 **direction** | **string** |  | [optional] [default to null]
 **label** | **string** |  | [optional] [default to null]
 **properties** | **string** |  | [optional] [default to null]
 **keepStartP** | **boolean** |  | [optional] [default to false]
 **offset** | **integer** |  | [optional] [default to 0]
 **page** | **string** |  | [optional] [default to null]
 **limit** | **integer** |  | [optional] [default to 100]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## update6



### Example

```bash
 update6 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **batchEdgeRequest** | [**BatchEdgeRequest**](BatchEdgeRequest.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## update7



### Example

```bash
 update7 graph=value id=value  action=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **string** |  | [default to null]
 **action** | **string** |  | [optional] [default to null]
 **jsonEdge** | [**JsonEdge**](JsonEdge.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

