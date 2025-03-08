# UserAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**create5**](UserAPIApi.md#create5) | **POST** /graphs/{graph}/auth/users | 
[**delete5**](UserAPIApi.md#delete5) | **DELETE** /graphs/{graph}/auth/users/{id} | 
[**get5**](UserAPIApi.md#get5) | **GET** /graphs/{graph}/auth/users/{id} | 
[**list5**](UserAPIApi.md#list5) | **GET** /graphs/{graph}/auth/users | 
[**role**](UserAPIApi.md#role) | **GET** /graphs/{graph}/auth/users/{id}/role | 
[**update5**](UserAPIApi.md#update5) | **PUT** /graphs/{graph}/auth/users/{id} | 



## create5



### Example

```bash
 create5 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **jsonUser** | [**JsonUser**](JsonUser.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## delete5



### Example

```bash
 delete5 graph=value id=value
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


## get5



### Example

```bash
 get5 graph=value id=value
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


## list5



### Example

```bash
 list5 graph=value  limit=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **limit** | **integer** |  | [optional] [default to 100]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## role



### Example

```bash
 role graph=value id=value
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


## update5



### Example

```bash
 update5 graph=value id=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **string** |  | [default to null]
 **jsonUser** | [**JsonUser**](JsonUser.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

