# KoutAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**get22**](KoutAPIApi.md#get22) | **GET** /graphs/{graph}/traversers/kout | 
[**post11**](KoutAPIApi.md#post11) | **POST** /graphs/{graph}/traversers/kout | 



## get22



### Example

```bash
 get22 graph=value  source=value  direction=value  label=value  max_depth=value  nearest=value  count_only=value  max_degree=value  capacity=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **source** | **string** |  | [optional] [default to null]
 **direction** | **string** |  | [optional] [default to null]
 **label** | **string** |  | [optional] [default to null]
 **maxDepth** | **integer** |  | [optional] [default to null]
 **nearest** | **boolean** |  | [optional] [default to true]
 **countOnly** | **boolean** |  | [optional] [default to false]
 **maxDegree** | **integer** |  | [optional] [default to 10000]
 **capacity** | **integer** |  | [optional] [default to 10000000]
 **limit** | **integer** |  | [optional] [default to 10000000]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## post11



### Example

```bash
 post11 graph=value
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

