# EdgeLabelAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**create11**](EdgeLabelAPIApi.md#create11) | **POST** /graphs/{graph}/schema/edgelabels | 
[**delete9**](EdgeLabelAPIApi.md#delete9) | **DELETE** /graphs/{graph}/schema/edgelabels/{name} | 
[**get12**](EdgeLabelAPIApi.md#get12) | **GET** /graphs/{graph}/schema/edgelabels/{name} | 
[**list12**](EdgeLabelAPIApi.md#list12) | **GET** /graphs/{graph}/schema/edgelabels | 
[**update11**](EdgeLabelAPIApi.md#update11) | **PUT** /graphs/{graph}/schema/edgelabels/{name} | 



## create11



### Example

```bash
 create11 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonEdgeLabel** | [**JsonEdgeLabel**](JsonEdgeLabel.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## delete9



### Example

```bash
 delete9 graph=value name=value
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


## get12



### Example

```bash
 get12 graph=value name=value
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


## list12



### Example

```bash
 list12 graph=value  Specify as:  names=value1 names=value2 names=...
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


## update11



### Example

```bash
 update11 graph=value name=value  action=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **name** | **string** |  | [default to null]
 **action** | **string** |  | [optional] [default to null]
 **jsonEdgeLabel** | [**JsonEdgeLabel**](JsonEdgeLabel.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

