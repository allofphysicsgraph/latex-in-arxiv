# TaskAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete8**](TaskAPIApi.md#delete8) | **DELETE** /graphs/{graph}/tasks/{id} | 
[**get10**](TaskAPIApi.md#get10) | **GET** /graphs/{graph}/tasks/{id} | 
[**list8**](TaskAPIApi.md#list8) | **GET** /graphs/{graph}/tasks | 
[**update10**](TaskAPIApi.md#update10) | **PUT** /graphs/{graph}/tasks/{id} | 



## delete8



### Example

```bash
 delete8 graph=value id=value  force=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **integer** |  | [default to null]
 **force** | **boolean** |  | [optional] [default to false]

### Return type

(empty response body)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## get10



### Example

```bash
 get10 graph=value id=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **integer** |  | [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## list8



### Example

```bash
 list8 graph=value  status=value  Specify as:  ids=value1 ids=value2 ids=...  limit=value  page=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **status** | **string** |  | [optional] [default to null]
 **ids** | [**array[integer]**](integer.md) |  | [optional] [default to null]
 **limit** | **integer** |  | [optional] [default to 100]
 **page** | **string** |  | [optional] [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## update10



### Example

```bash
 update10 graph=value id=value  action=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **id** | **integer** |  | [default to null]
 **action** | **string** |  | [optional] [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

