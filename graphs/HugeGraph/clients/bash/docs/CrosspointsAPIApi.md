# CrosspointsAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**get18**](CrosspointsAPIApi.md#get18) | **GET** /graphs/{graph}/traversers/crosspoints | 



## get18



### Example

```bash
 get18 graph=value  source=value  target=value  direction=value  label=value  max_depth=value  max_degree=value  capacity=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **source** | **string** |  | [optional] [default to null]
 **target** | **string** |  | [optional] [default to null]
 **direction** | **string** |  | [optional] [default to null]
 **label** | **string** |  | [optional] [default to null]
 **maxDepth** | **integer** |  | [optional] [default to null]
 **maxDegree** | **integer** |  | [optional] [default to 10000]
 **capacity** | **integer** |  | [optional] [default to 10000000]
 **limit** | **integer** |  | [optional] [default to 10]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

