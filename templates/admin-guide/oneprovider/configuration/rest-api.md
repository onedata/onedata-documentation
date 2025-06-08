<!-- @include rest-api/start.md
  {
    "serviceUpper": "Oneprovider",
    "serviceLowerShort": "provider",
    "introTasks": "storage creation, space support"
  }
-->

| Request                     | Link to API                    |
| --------------------------- | ------------------------------ |
| Get public configuration    | [API][api-get-configuration]   |
| Check cluster health        | [API][api-health]              |
| Add storage backend         | [API][api-add-storage]         |
| List storage backends       | [API][api-get-storages]        |
| Get storage backend details | [API][api-get-storage-details] |
| Support space               | [API][api-support-space]       |
| List supported spaces       | [API][api-get-provider-spaces] |
| Get space support details   | [API][api-get-space-details]   |

## Example request

Let's assume, that your provider is located at `my.provider.domain.org` and your
access token is available under `TOKEN` environment variable. You can get the
list of provider storage backends using cURL command:

```
curl -X GET -H "X-Auth-Token: $TOKEN" https://my.provider.domain.org/api/v3/onepanel/provider/storages
```

The result of the above request will contain a list of storage backend IDs:

```
{
    "ids": [
        "18a42a43b1b2d92455ffa09e9a15df7fch4f82",
        "0a26877440f6ce457106c6958dfe7ecbch0ac6",
        "b3d7d10504393556d9b1631a74c34520ch8359"
    ]
}
```

<!-- references -->

<!-- @include rest-api/common-references.md -->

[api-get-configuration]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_configuration

[api-health]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/health

[api-add-storage]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/add_storage

[api-get-storages]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_storages

[api-get-storage-details]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_storage_details

[api-support-space]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/support_space

[api-get-provider-spaces]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_provider_spaces

[api-get-space-details]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_space_details
