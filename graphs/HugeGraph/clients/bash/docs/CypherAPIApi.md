# CypherAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**post**](CypherAPIApi.md#post) | **POST** /graphs/{graph}/cypher | 
[**query**](CypherAPIApi.md#query) | **GET** /graphs/{graph}/cypher | 



## post



### Example

```bash
 post graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **body** | **string** |  | [optional]

### Return type

[**CypherModel**](CypherModel.md)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## query



### Example

```bash
 query graph=value  cypher=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **cypher** | **string** |  | [optional] [default to null]

### Return type

[**CypherModel**](CypherModel.md)

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

