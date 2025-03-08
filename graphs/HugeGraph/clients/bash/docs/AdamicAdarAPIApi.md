# AdamicAdarAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**get16**](AdamicAdarAPIApi.md#get16) | **GET** /graphs/{graph}/traversers/adamicadar | 



## get16



### Example

```bash
 get16 graph=value  vertex=value  other=value  direction=value  label=value  max_degree=value  limit=value
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

