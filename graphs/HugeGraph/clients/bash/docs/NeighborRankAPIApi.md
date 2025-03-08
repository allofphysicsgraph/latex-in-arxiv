# NeighborRankAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**neighborRank**](NeighborRankAPIApi.md#neighborRank) | **POST** /graphs/{graph}/traversers/neighborrank | 



## neighborRank



### Example

```bash
 neighborRank graph=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **graph** | **string** |  | [default to null]
 **rankRequest** | [**RankRequest**](RankRequest.md) |  | [optional]

### Return type

**string**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

