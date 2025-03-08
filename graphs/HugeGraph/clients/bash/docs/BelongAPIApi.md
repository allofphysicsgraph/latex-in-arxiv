# BelongAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**create1**](BelongAPIApi.md#create1) | **POST** /graphs/{graph}/auth/belongs | 
[**delete1**](BelongAPIApi.md#delete1) | **DELETE** /graphs/{graph}/auth/belongs/{id} | 
[**get1**](BelongAPIApi.md#get1) | **GET** /graphs/{graph}/auth/belongs/{id} | 
[**list1**](BelongAPIApi.md#list1) | **GET** /graphs/{graph}/auth/belongs | 
[**update1**](BelongAPIApi.md#update1) | **PUT** /graphs/{graph}/auth/belongs/{id} | 



## create1



### Example

```bash
 create1 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonBelong** | [**JsonBelong**](JsonBelong.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## delete1



### Example

```bash
 delete1 graph=value id=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **string** |  | [default to null]

### Return type

(empty response body)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## get1



### Example

```bash
 get1 graph=value id=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **string** |  | [default to null]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## list1



### Example

```bash
 list1 graph=value  user=value  group=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **user** | **string** |  | [optional] [default to null]
 **group** | **string** |  | [optional] [default to null]
 **limit** | **integer** |  | [optional] [default to 100]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## update1



### Example

```bash
 update1 graph=value id=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **string** |  | [default to null]
 **jsonBelong** | [**JsonBelong**](JsonBelong.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

