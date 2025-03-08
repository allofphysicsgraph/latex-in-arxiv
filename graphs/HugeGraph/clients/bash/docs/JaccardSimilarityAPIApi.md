# JaccardSimilarityAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**get20**](JaccardSimilarityAPIApi.md#get20) | **GET** /graphs/{graph}/traversers/jaccardsimilarity | 
[**post9**](JaccardSimilarityAPIApi.md#post9) | **POST** /graphs/{graph}/traversers/jaccardsimilarity | 



## get20



### Example

```bash
 get20 graph=value  vertex=value  other=value  direction=value  label=value  max_degree=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **vertex** | **string** |  | [optional] [default to null]
 **other** | **string** |  | [optional] [default to null]
 **direction** | **string** |  | [optional] [default to null]
 **label** | **string** |  | [optional] [default to null]
 **maxDegree** | **integer** |  | [optional] [default to 10000]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## post9



### Example

```bash
 post9 graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **request** | [**Request**](Request.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

