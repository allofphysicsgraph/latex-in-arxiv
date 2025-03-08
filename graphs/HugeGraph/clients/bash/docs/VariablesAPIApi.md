# VariablesAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete13**](VariablesAPIApi.md#delete13) | **DELETE** /graphs/{graph}/variables/{key} | 
[**get30**](VariablesAPIApi.md#get30) | **GET** /graphs/{graph}/variables/{key} | 
[**list19**](VariablesAPIApi.md#list19) | **GET** /graphs/{graph}/variables | 
[**update15**](VariablesAPIApi.md#update15) | **PUT** /graphs/{graph}/variables/{key} | 



## delete13



### Example

```bash
 delete13 graph=value key=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **key** | **string** |  | [default to null]

### Return type

(empty response body)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## get30



### Example

```bash
 get30 graph=value key=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **key** | **string** |  | [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## list19



### Example

```bash
 list19 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## update15



### Example

```bash
 update15 graph=value key=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **key** | **string** |  | [default to null]
 **jsonVariableValue** | [**JsonVariableValue**](JsonVariableValue.md) |  | [optional]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

