# System requirements

<!-- toc -->

Onedata services have certain minimum system requirements, which should be considered
before deployment.

> Please note that these numbers are rough estimates and depend on actual
> data access patterns of users, network capacity and underlying storage
> performance.

## Onezone

| Requirement | Minimum | Optimal |
|----         |----     |----     |
| No of VMs   | 1       | 2 + 1 for each 5000 users |
| CPU | 8 vCPU | 16 vCPU |
| RAM | 32GB   | 64GB    |
| Local disk | SATA | SSD |
| Local storage space | 20GB | 40GB |
| OS | Any Docker compatible | Any Docker compatible |


## Oneprovider

| Requirement | Minimum | Optimal |
|----         |----     |----     |
| No of VMs   | 1       | 2 + 1 for each 500 concurrent users |
| CPU | 8 vCPU | 16 vCPU |
| RAM | 32GB   | 64GB    |
| Local disk | SSD | SSD |
| Local storage space | 20GB + 8MB for each 1000 files | 40GB + 8MB for each 1000 files |
| OS | Any Docker compatible | Any Docker compatible |
