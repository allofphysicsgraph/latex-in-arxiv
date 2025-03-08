# LoginAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**login**](LoginAPIApi.md#login) | **POST** /graphs/{graph}/auth/login | 
[**logout**](LoginAPIApi.md#logout) | **DELETE** /graphs/{graph}/auth/logout | 
[**verifyToken**](LoginAPIApi.md#verifyToken) | **GET** /graphs/{graph}/auth/verify | 



## login



### Example

```bash
 login graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonLogin** | [**JsonLogin**](JsonLogin.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## logout



### Example

```bash
 logout graph=value Authorization:value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **authorization** | **string** |  | [optional] [default to null]

### Return type

(empty response body)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## verifyToken



### Example

```bash
 verifyToken graph=value Authorization:value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **authorization** | **string** |  | [optional] [default to null]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

