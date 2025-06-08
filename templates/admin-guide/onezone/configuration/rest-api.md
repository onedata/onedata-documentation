<!-- @include rest-api/start.md
  {
    "serviceUpper": "Onezone",
    "serviceLowerShort": "zone",
    "introTasks": "user management, health status checks"
  }
-->

| Request                  | Link to API                     |
| ------------------------ | ------------------------------- |
| Get public configuration | [API][api-get-configuration]    |
| Check cluster health     | [API][api-health]               |
| Create user              | [API][api-add-onezone-user]     |
| List users               | [API][api-get-onezone-users]    |
| Get user details         | [API][api-get-onezone-user]     |
| Set password for user    | [API][api-change-user-password] |

## Example request

Let's assume, that your Onezone is located at `my.zone.domain.org` and your
access token is available under `TOKEN` environment variable. You can create a
new Onezone user account using cURL command:

```
curl -X POST -H "X-Auth-Token: $TOKEN" https://my.zone.domain.org/api/v3/onepanel/zone/users \
-H "Content-Type: application/json" -d '{
    "username": "someUser",
    "password": "somePassword"
}'
```

The result of the above request will contain an ID of the created user:

```
{
    "id": "b519b3ac46823b2b83b6cb85e1b16f4fchaa0f"
}
```

<!-- references -->

<!-- @include rest-api/common-references.md -->

[api-get-configuration]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_configuration

[api-health]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/health

[api-add-onezone-user]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/add_onezone_user

[api-get-onezone-users]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_onezone_users

[api-get-onezone-user]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_onezone_user

[api-change-user-password]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/change_user_password
