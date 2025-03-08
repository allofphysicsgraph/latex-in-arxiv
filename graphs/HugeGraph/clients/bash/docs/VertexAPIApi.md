# VertexAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**create8**](VertexAPIApi.md#create8) | **POST** /graphs/{graph}/graph/vertices | 
[**create9**](VertexAPIApi.md#create9) | **POST** /graphs/{graph}/graph/vertices/batch | 
[**delete7**](VertexAPIApi.md#delete7) | **DELETE** /graphs/{graph}/graph/vertices/{id} | 
[**get8**](VertexAPIApi.md#get8) | **GET** /graphs/{graph}/graph/vertices/{id} | 
[**list7**](VertexAPIApi.md#list7) | **GET** /graphs/{graph}/graph/vertices | 
[**update8**](VertexAPIApi.md#update8) | **PUT** /graphs/{graph}/graph/vertices/batch | 
[**update9**](VertexAPIApi.md#update9) | **PUT** /graphs/{graph}/graph/vertices/{id} | 



## create8



### Example

```bash
 create8 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonVertex** | [**JsonVertex**](JsonVertex.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## create9



### Example

```bash
 create9 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonVertex** | [**array[JsonVertex]**](JsonVertex.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## delete7



### Example

```bash
 delete7 graph=value id=value  label=value
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


## get8



### Example

```bash
 get8 graph=value id=value
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


## list7



### Example

```bash
 list7 graph=value  label=value  properties=value  keep_start_p=value  offset=value  page=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
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


## update8



### Example

```bash
 update8 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **batchVertexRequest** | [**BatchVertexRequest**](BatchVertexRequest.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## update9



### Example

```bash
 update9 graph=value id=value  action=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **string** |  | [default to null]
 **action** | **string** |  | [optional] [default to null]
 **jsonVertex** | [**JsonVertex**](JsonVertex.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

