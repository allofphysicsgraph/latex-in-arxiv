# WhiteIpListAPIApi

All URIs are relative to **

Method | HTTP request | Description
------------- | ------------- | -------------
[**list11**](WhiteIpListAPIApi.md#list11) | **GET** /whiteiplist | list white ips
[**updateStatus**](WhiteIpListAPIApi.md#updateStatus) | **PUT** /whiteiplist | enable/disable the white ip list
[**updateWhiteIPs**](WhiteIpListAPIApi.md#updateWhiteIPs) | **POST** /whiteiplist | update white ip list



## list11

list white ips

### Example

```bash
 list11
```

### Parameters

This endpoint does not need any parameter.

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## updateStatus

enable/disable the white ip list

### Example

```bash
 updateStatus  status=value
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **string** |  | [optional] [default to null]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not Applicable
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## updateWhiteIPs

update white ip list

### Example

```bash
 updateWhiteIPs
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**map[String, map]**](map.md) |  | [optional]

### Return type

**map[String, map]**

### Authorization

[bearer](../README.md#bearer), [basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json;charset=UTF-8

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

