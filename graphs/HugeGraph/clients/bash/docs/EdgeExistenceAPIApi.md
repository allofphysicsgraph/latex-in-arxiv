# EdgeExistenceAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**get19**](EdgeExistenceAPIApi.md#get19) | **GET** /graphs/{graph}/traversers/edgeexist | get edges from &#39;source&#39; to &#39;target&#39; vertex



## get19

get edges from 'source' to 'target' vertex

### Example

```bash
 get19 graph=value  source=value  target=value  label=value  sort_values=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **source** | **string** |  | [optional] [default to null]
 **target** | **string** |  | [optional] [default to null]
 **label** | **string** |  | [optional] [default to null]
 **sortValues** | **string** |  | [optional] [default to ]
 **limit** | **integer** |  | [optional] [default to 100]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

