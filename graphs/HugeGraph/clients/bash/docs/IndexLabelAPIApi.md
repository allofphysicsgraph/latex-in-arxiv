# IndexLabelAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**create12**](IndexLabelAPIApi.md#create12) | **POST** /graphs/{graph}/schema/indexlabels | 
[**delete10**](IndexLabelAPIApi.md#delete10) | **DELETE** /graphs/{graph}/schema/indexlabels/{name} | 
[**get13**](IndexLabelAPIApi.md#get13) | **GET** /graphs/{graph}/schema/indexlabels/{name} | 
[**list13**](IndexLabelAPIApi.md#list13) | **GET** /graphs/{graph}/schema/indexlabels | 
[**update12**](IndexLabelAPIApi.md#update12) | **PUT** /graphs/{graph}/schema/indexlabels/{name} | 



## create12



### Example

```bash
 create12 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonIndexLabel** | [**JsonIndexLabel**](JsonIndexLabel.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## delete10



### Example

```bash
 delete10 graph=value name=value
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


## get13



### Example

```bash
 get13 graph=value name=value
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


## list13



### Example

```bash
 list13 graph=value  Specify as:  names=value1 names=value2 names=...
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


## update12



### Example

```bash
 update12 graph=value name=value  action=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **name** | **string** |  | [default to null]
 **action** | **string** |  | [optional] [default to null]
 **jsonIndexLabel** | [**JsonIndexLabel**](JsonIndexLabel.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

