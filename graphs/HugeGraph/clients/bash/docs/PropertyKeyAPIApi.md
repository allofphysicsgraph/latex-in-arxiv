# PropertyKeyAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**create13**](PropertyKeyAPIApi.md#create13) | **POST** /graphs/{graph}/schema/propertykeys | 
[**delete11**](PropertyKeyAPIApi.md#delete11) | **DELETE** /graphs/{graph}/schema/propertykeys/{name} | 
[**get14**](PropertyKeyAPIApi.md#get14) | **GET** /graphs/{graph}/schema/propertykeys/{name} | 
[**list14**](PropertyKeyAPIApi.md#list14) | **GET** /graphs/{graph}/schema/propertykeys | 
[**update13**](PropertyKeyAPIApi.md#update13) | **PUT** /graphs/{graph}/schema/propertykeys/{name} | 



## create13



### Example

```bash
 create13 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonPropertyKey** | [**JsonPropertyKey**](JsonPropertyKey.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## delete11



### Example

```bash
 delete11 graph=value name=value
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


## get14



### Example

```bash
 get14 graph=value name=value
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


## list14



### Example

```bash
 list14 graph=value  Specify as:  names=value1 names=value2 names=...
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


## update13



### Example

```bash
 update13 graph=value name=value  action=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **name** | **string** |  | [default to null]
 **action** | **string** |  | [optional] [default to null]
 **jsonPropertyKey** | [**JsonPropertyKey**](JsonPropertyKey.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

