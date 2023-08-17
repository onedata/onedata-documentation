# File popularity

[toc][1]

As a prerequisite for understanding this chapter we advise to familiarize with
the concept of [*views*][2].

The *file popularity* mechanism enables tracking of usage statistics for files in a space.
It allows listing File IDs sorted in ascending order by the
[*popularity function*][3], so that the least popular files
are at the beginning of the list.

> **NOTE:** Usage statistics can be collected only for local storage supporting the space.
> It is impossible to obtain *file popularity* statistics gathered by a remote provider.

The mechanism can be enabled for chosen space in the `Spaces -> "Space Name" -> File popularity` tab,
in the Spaces menu of Oneprovider panel GUI (as shown below) or using [REST API][4].

![screen-5][]

Internally, the mechanism creates the *file popularity view*. All notes presented in the
[*Views* chapter][2]
applies also to the *file popularity view*.

> **NOTE:** The *file popularity view* is a special view, therefore it is forbidden to create
> a view with such name. Furthermore, it is forbidden and impossible to
> modify or delete the view using
> [*Views API*][2].

## Querying the file popularity view

The *file popularity view* can be queried using the following request:

```bash
curl -sS -k -H "X-Auth-Token:$TOKEN" -X GET https://$HOST/api/v3/oneprovider/spaces/$SPACE_ID/views/file-popularity/query
```

An example of such request is presented in the *file popularity* configuration tab of Onepanel GUI.
The example request returns 10 least popular files in the space.

For more information on querying [*views*][2], see
[here][6].

## Advanced topics

### The popularity function

The key that is emitted to the *file popularity view* is the value of the
*popularity function* for given file.
The function is defined as follows:

```
P(lastOpenHour, avgOpenCountPerDay) = w1 * lastOpenHour + w2 * min(avgOpenCountPerDay, MAX_AVG_OPEN_COUNT_PER_DAY)
```

where:

* `lastOpenHour` — parameter which is equal to timestamp (in hours since 01.01.1970)
  of last open operation on given file
* `w1` — weight of lastOpenHour parameter
* `avgOpenCountPerDay` — parameter equal to moving average of number of open
  operations on given file per day. The value is calculated over last 30 days.
* `w2` — weight of avgOpenCountPerDay parameter
* `MAX_AVG_OPEN_COUNT_PER_DAY` — upper boundary for avgOpenCountPerDay parameter

Entries in the views are modified only when associated document
in the database is modified. It means that an entry in the *file popularity view*
is modified only when the
[file popularity model][7]
document is updated, which happens on each file close operation.
The downside of this approach is that the `avgOpenCountPerDay` may not be recalculated in certain
circumstances and the file may be indexed as "popular" forever, contrary to the actual popularity.
This is possible when the file that has been intensively used for some time but hasn't been opened
since then, so that no recalculation could be triggered to update its popularity. This is why the
`lastOpenHour` parameter is used in the *popularity function* — to balance the importance of
`avgOpenCountPerDay` parameter.

### Default parameters

The default values of the *file popularity view* are as follows:

* `w1 = 1.0`
* `w2 = 20.0`
* `MAX_AVG_OPEN_COUNT_PER_DAY = 100`

The default value of `MAX_AVG_OPEN_COUNT_PER_DAY` makes all files with `avgOpenCountPerDay > 100`
to be treated as equally popular.

The above values of `w1` and `w2` cause the below two files to have similar calculated popularity:

* a file that has been opened just once
* a file that had been opened about 1000 times in the month preceding the last open, and the open was
  performed a month before opening the former file

These weights were estimated using the following approach:

```
Assume that we have 2 files: F1 and F2.

F1 was opened at timestamp (in hours) T1.
F1 - lastOpenHour1 = T1
   - number of opens in the month preceding last open: opensCount1 = 1
   - avgOpenCountPerDay1 = avg1 = opensCount1 / 30 = 1 / 30
   
F2 was opened a month earlier than T1 for the last time.
F2 - lastOpenHour2 = T2 = T1 - 30 * 24
   - number of opens in the month preceding last open: opensCount2 = 1000
   - avgOpenCountPerDay2 = avg2 = opensCount2 / 30 = 1000 / 30

Calculate popularity for both files:

P1 = P(lastOpenHour1, avgOpenCountPerDay1)
P1 = w1 * T1 + w2 * min(avg1, 100)
P1 = w1 * T1 + w2 * avg1

P2 = P(lastOpenHour2, avgOpenCountPerDay2)
P2 = w1 * T2 + w2 * min(avg2, 100)
P2 = w1 * T2 + w2 * avg2
P2 = w1 * (T1 - 720) + w2 * avg2

We want P1 = P2:

w1 * T1 + w2 * avg1 = w1 * (T1 - 720) + w2 * avg2
w1 * T1 + w2 * avg1 = w1 * T1 - w1 * 720 + w2 * avg2
w1 * 720 = w2 * (avg2 - avg1)
w1 / w2 = (avg2 - avg1)/720
w1 / w2 = 999 / 21600

We can set w1 := 1 and therefore we have:

w2 = 21600 / 999 ~= 21,62

Finally, to make it simpler, we set:
w1 := 1.0
w2 := 20.0
```

### Tuning the file popularity function

The three parameters of the function: `w1`, `w2` and `MAX_AVG_OPEN_COUNT_PER_DAY`
can be modified in the *file popularity* configuration panel.

> **NOTE:** Modification of the [*popularity function*][3]
> parameters results in modification of the mapping function of the
> *file popularity view*. It means that all already indexed files need to be
> re-indexed. Such operation can be very time-consuming, depending on the number
> of the files in the space.

> **NOTE:** The same notice applies to disabling/enabling the mechanism.
> Disabling the view results in its deletion, therefore re-enabling the view
> results in re-indexing of all files in the space.

> <span style="color:red">MODIFICATION OF THE [*POPULARITY FUNCTION*][3] MUST BE PERFORMED WITH CARE!!!</span>

### REST API

All operations related to file popularity can be performed using the REST API.
Refer to the linked API documentation for detailed information and examples.

| Request                                | Link to API |
| -------------------------------------- | ----------- |
| Get *file popularity* configuration    | [API][8]    |
| Update *file popularity* configuration | [API][9]    |

[1]: <>

[2]: ../../../user-guide/views.md

[3]: #the-popularity-function

[4]: #rest-api

[screen-5]: ../../../../images/admin-guide/oneprovider/configuration/file-popularity/file_popularity_tab.png

[6]: ../../../user-guide/views.md#rest-api

[7]: ../../../user-guide/views.md#file-popularity-model

[8]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_file_popularity_configuration

[9]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/configure_file_popularity
