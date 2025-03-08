# KneighborAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**get21**](KneighborAPIApi.md#get21) | **GET** /graphs/{graph}/traversers/kneighbor | 
[**post10**](KneighborAPIApi.md#post10) | **POST** /graphs/{graph}/traversers/kneighbor | 



## get21



### Example

```bash
 get21 graph=value  source=value  direction=value  label=value  max_depth=value  count_only=value  max_degree=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **source** | **string** |  | [optional] [default to null]
 **direction** | **string** |  | [optional] [default to null]
 **label** | **string** |  | [optional] [default to null]
 **maxDepth** | **integer** |  | [optional] [default to null]
 **countOnly** | **boolean** |  | [optional] [default to false]
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


## post10



### Example

```bash
 post10 graph=value
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

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

