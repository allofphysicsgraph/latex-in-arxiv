# VertexLabelAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**create14**](VertexLabelAPIApi.md#create14) | **POST** /graphs/{graph}/schema/vertexlabels | 
[**delete12**](VertexLabelAPIApi.md#delete12) | **DELETE** /graphs/{graph}/schema/vertexlabels/{name} | 
[**get15**](VertexLabelAPIApi.md#get15) | **GET** /graphs/{graph}/schema/vertexlabels/{name} | 
[**list16**](VertexLabelAPIApi.md#list16) | **GET** /graphs/{graph}/schema/vertexlabels | 
[**update14**](VertexLabelAPIApi.md#update14) | **PUT** /graphs/{graph}/schema/vertexlabels/{name} | 



## create14



### Example

```bash
 create14 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonVertexLabel** | [**JsonVertexLabel**](JsonVertexLabel.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## delete12



### Example

```bash
 delete12 graph=value name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **name** | **string** |  | [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## get15



### Example

```bash
 get15 graph=value name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **name** | **string** |  | [default to null]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## list16



### Example

```bash
 list16 graph=value  Specify as:  names=value1 names=value2 names=...
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **names** | [**array[string]**](string.md) |  | [optional] [default to null]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## update14



### Example

```bash
 update14 graph=value name=value  action=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **name** | **string** |  | [default to null]
 **action** | **string** |  | [optional] [default to null]
 **jsonVertexLabel** | [**JsonVertexLabel**](JsonVertexLabel.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

