# System requirements

<!-- toc -->

Onedata services have certain minimum system requirements, which should be considered before deployment.

> Please note that these numbers are rough estimates and depend on actual
> data access patterns of users, network capacity and underlying storage
> performance.

## Onezone

| Requirement | Minimum | Optimal |
|----         |----     |----     |
| No of VMs   | 1       | 2 + 1 for every 5000 users |
| CPU | 8 vCPU | 16 vCPU |
| RAM | 32GB   | 64GB    |
| Local disk | SATA | SSD |
| Local storage space | 20GB | 40GB |
| OS (Docker deployment)| Any Docker compatible | Any Docker compatible |
| OS (Package deployment)| Ubuntu (16.04), CentOS 7 | Ubuntu (16.04), CentOS 7 |

## Oneprovider

| Requirement | Minimum | Optimal |
|----         |----     |----     |
| No of VMs   | 1       | 2 + 1 for every 500 concurrent users |
| CPU | 8 vCPU | 16 vCPU |
| RAM | 32GB   | 64GB    |
| Local disk | SSD | SSD |
| Local storage space | 20GB + 8MB for each 1000 files | 40GB + 8MB for each 1000 files |
| OS (Docker deployment) | Any Docker compatible | Any Docker compatible |
| OS (Package deployment)| Ubuntu (16.04), CentOS 7 | Ubuntu (16.04), CentOS 7 |
