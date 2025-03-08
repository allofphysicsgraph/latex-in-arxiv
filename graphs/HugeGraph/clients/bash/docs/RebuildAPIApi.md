# RebuildAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**edgeLabelRebuild**](RebuildAPIApi.md#edgeLabelRebuild) | **PUT** /graphs/{graph}/jobs/rebuild/edgelabels/{name} | 
[**indexLabelRebuild**](RebuildAPIApi.md#indexLabelRebuild) | **PUT** /graphs/{graph}/jobs/rebuild/indexlabels/{name} | 
[**vertexLabelRebuild**](RebuildAPIApi.md#vertexLabelRebuild) | **PUT** /graphs/{graph}/jobs/rebuild/vertexlabels/{name} | 



## edgeLabelRebuild



### Example

```bash
 edgeLabelRebuild graph=value name=value
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


## indexLabelRebuild



### Example

```bash
 indexLabelRebuild graph=value name=value
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


## vertexLabelRebuild



### Example

```bash
 vertexLabelRebuild graph=value name=value
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

