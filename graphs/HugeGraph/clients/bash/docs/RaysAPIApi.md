# RaysAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**get24**](RaysAPIApi.md#get24) | **GET** /graphs/{graph}/traversers/rays | 



## get24



### Example

```bash
 get24 graph=value  source=value  direction=value  label=value  max_depth=value  max_degree=value  capacity=value  limit=value  with_vertex=value  with_edge=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **source** | **string** |  | [optional] [default to null]
 **direction** | **string** |  | [optional] [default to null]
 **label** | **string** |  | [optional] [default to null]
 **maxDepth** | **integer** |  | [optional] [default to null]
 **maxDegree** | **integer** |  | [optional] [default to 10000]
 **capacity** | **integer** |  | [optional] [default to 10000000]
 **limit** | **integer** |  | [optional] [default to 10]
 **withVertex** | **boolean** |  | [optional] [default to false]
 **withEdge** | **boolean** |  | [optional] [default to false]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

