# RDS-Cert-Check


Simple example script that queries all regions and outputs table.

Steps to remedy: Steps to Remedy Out of Data Cert: https://aws.amazon.com/blogs/database/amazon-rds-customers-update-your-ssl-tls-certificates-by-february-5-2020/

```
./rds_cert.sh -h
Checks for out of date RDS Cert

Syntax: scriptTemplate [h|f]
options:
h     Print this Help.
f     Show only affected RDS Instance

```


```
# Show all DB instances
./rds_cert.sh
```

```
# Show only rds instance without rds-ca-2019 cert
./rds_cert.sh -f

```


### Considerations

- Does not paginate list, max is 100 per region
- Does not accept custom profile as input
- Does not apply changes
- Requires ec2:DescribeRegions and rds:DescribeDBInstances permissions