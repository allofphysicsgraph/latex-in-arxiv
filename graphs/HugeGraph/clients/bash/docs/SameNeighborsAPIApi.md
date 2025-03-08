# SameNeighborsAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**get26**](SameNeighborsAPIApi.md#get26) | **GET** /graphs/{graph}/traversers/sameneighbors | 
[**sameNeighbors**](SameNeighborsAPIApi.md#sameNeighbors) | **POST** /graphs/{graph}/traversers/sameneighbors | 



## get26



### Example

```bash
 get26 graph=value  vertex=value  other=value  direction=value  label=value  max_degree=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **vertex** | **string** |  | [optional] [default to null]
 **other** | **string** |  | [optional] [default to null]
 **direction** | **string** |  | [optional] [default to null]
 **label** | **string** |  | [optional] [default to null]
 **maxDegree** | **integer** |  | [optional] [default to 10000]
 **limit** | **integer** |  | [optional] [default to 10000000]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## sameNeighbors



### Example

```bash
 sameNeighbors graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **request** | [**Request**](Request.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

