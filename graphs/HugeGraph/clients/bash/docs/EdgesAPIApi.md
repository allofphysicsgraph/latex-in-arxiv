# EdgesAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**list17**](EdgesAPIApi.md#list17) | **GET** /graphs/{graph}/traversers/edges | 
[**scan**](EdgesAPIApi.md#scan) | **GET** /graphs/{graph}/traversers/edges/scan | 
[**shards**](EdgesAPIApi.md#shards) | **GET** /graphs/{graph}/traversers/edges/shards | 



## list17



### Example

```bash
 list17 graph=value  Specify as:  ids=value1 ids=value2 ids=...
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **ids** | [**array[string]**](string.md) |  | [optional] [default to null]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## scan



### Example

```bash
 scan graph=value  start=value  end=value  page=value  page_limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **start** | **string** |  | [optional] [default to null]
 **end** | **string** |  | [optional] [default to null]
 **page** | **string** |  | [optional] [default to null]
 **pageLimit** | **integer** |  | [optional] [default to 100000]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## shards



### Example

```bash
 shards graph=value  split_size=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **splitSize** | **integer** |  | [optional] [default to null]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

