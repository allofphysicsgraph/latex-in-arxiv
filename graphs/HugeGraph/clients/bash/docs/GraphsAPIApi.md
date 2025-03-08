# GraphsAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**clear**](GraphsAPIApi.md#clear) | **DELETE** /graphs/{name}/clear | 
[**compact**](GraphsAPIApi.md#compact) | **PUT** /graphs/{name}/compact | 
[**create10**](GraphsAPIApi.md#create10) | **POST** /graphs/{name} | 
[**createSnapshot**](GraphsAPIApi.md#createSnapshot) | **PUT** /graphs/{name}/snapshot_create | 
[**drop**](GraphsAPIApi.md#drop) | **DELETE** /graphs/{name} | 
[**get11**](GraphsAPIApi.md#get11) | **GET** /graphs/{name} | 
[**getConf**](GraphsAPIApi.md#getConf) | **GET** /graphs/{name}/conf | 
[**graphReadMode**](GraphsAPIApi.md#graphReadMode) | **GET** /graphs/{name}/graph_read_mode | 
[**graphReadMode1**](GraphsAPIApi.md#graphReadMode1) | **PUT** /graphs/{name}/graph_read_mode | 
[**list9**](GraphsAPIApi.md#list9) | **GET** /graphs | 
[**mode**](GraphsAPIApi.md#mode) | **GET** /graphs/{name}/mode | 
[**mode1**](GraphsAPIApi.md#mode1) | **PUT** /graphs/{name}/mode | 
[**resumeSnapshot**](GraphsAPIApi.md#resumeSnapshot) | **PUT** /graphs/{name}/snapshot_resume | 



## clear



### Example

```bash
 clear name=value  confirm_message=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]
 **confirmMessage** | **string** |  | [optional] [default to null]

### Return type

(empty response body)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## compact



### Example

```bash
 compact name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## create10



### Example

```bash
 create10 name=value  clone_graph_name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]
 **cloneGraphName** | **string** |  | [optional] [default to null]
 **body** | **string** |  | [optional]

### Return type

**map**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: text/plain
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## createSnapshot



### Example

```bash
 createSnapshot name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]

### Return type

**map**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## drop



### Example

```bash
 drop name=value  confirm_message=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]
 **confirmMessage** | **string** |  | [optional] [default to null]

### Return type

(empty response body)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## get11



### Example

```bash
 get11 name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]

### Return type

**map**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## getConf



### Example

```bash
 getConf name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]

### Return type

**binary**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## graphReadMode



### Example

```bash
 graphReadMode name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]

### Return type

**map[String, string]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## graphReadMode1



### Example

```bash
 graphReadMode1 name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]
 **body** | **string** |  | [optional]

### Return type

**map[String, string]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## list9



### Example

```bash
 list9
```

### Parameters

This endpoint does not need any parameter.

### Return type

**map**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## mode



### Example

```bash
 mode name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]

### Return type

**map[String, string]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## mode1



### Example

```bash
 mode1 name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]
 **body** | **string** |  | [optional]

### Return type

**map[String, string]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## resumeSnapshot



### Example

```bash
 resumeSnapshot name=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **string** |  | [default to null]

### Return type

**map**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

