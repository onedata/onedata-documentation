# File popularity and automatic replica cleaning

<!-- toc -->

## File popularity

In order to automate the process of maintaining the storage usage at a certain limit and ensuring that there is a space left for new replicas when performing continous computations, each Oneprovider can track the file popularity for selected spaces, which allows to list ID's of the files which match specified usage metrics. The endpoint to query can be obtained from the Onepanel interface after enabling the *File popularity* feature for a given space:

![](../img/admin/op_panel_file_popularity.png)

When this option is enabled, Oneprovider will collect the statistics automatically in a special index attached to the space and they will be available via the Oneprovider REST API endpoint for querying:

```bash
$ curl --tlsv1.2 -sSk -X GET -H "X-Auth-Token: $TOKEN" "https://$HOST/api/v3/oneprovider/query-index/file-popularity-9JO51239nL1b01YEvwnft1r20gwgwlkIp19NDin8hgxs?spatial=true&start_range=\[1,0,0,0,0,0\]&end_range=\[null,null,null,null,null,null\]"

```

The index has six dimensions for which ranges have to be provided (or skipped using `null`) in the query as shown above. The range is an array consisting of 6 fields which have to be specified in this order:

* file size in bytes
* last file open time (in hours since Unix Epoch timestamp)
* number of file open requests
* average number of open requests per hour
* average number of open requests per day
* average number of open requests per month

## Auto cleaning

The statistics collected for file popularity can be used by the auto-cleaning mechanism, which can be enabled for each space supported by Oneprovider in order to maintain the size of data in a supported space in certain limits. Of course, only files which have remote replicas will be considered for replication, i.e. files which exist only on this Oneprovider will not be removed.

The user interface allows administrator to specify low and high thresholds.

The **high threshold** determines the amount of data stored on the local storage this Oneprovider attached to a space, which when exceeded will trigger removal of redundant replicas. Once the storage space used will be less than the **low threshold** the auto cleaning process will stop.

The thresholds can be adjusted using the GUI as shown below or using REST API:

![](../img/admin/op_panel_auto_cleaning.png)

It is possible to fine tune the auto cleaning process by specifying the following options:

* *Lower size limit* - only files bigger then this limit will be auto-cleaned
* Upper size limit - only files smaller than this limit will be auto-cleaned
* *Not opened for* - only files opened before the specified period will be auto-cleaned

After each auto-cleaning iteration a cleaning report will show the released size and number of removed replicas.