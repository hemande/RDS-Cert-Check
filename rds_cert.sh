#!/bin/bash


FILTER='DBInstances[].{DBInstanceIdentifier:DBInstanceIdentifier,Engine:Engine,CACertificateIdentifier:CACertificateIdentifier}'

Help()
{
   # Display Help
   echo "Checks for out of date RDS Cert"
   echo
   echo "Syntax: scriptTemplate [h|f]"
   echo "options:"
   echo "h     Print this Help."
   echo "f     Show only affected RDS Instance"
}


while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      f) # filter 
      FILTER='DBInstances[?CACertificateIdentifier!=`rds-ca-2019`].{DBInstanceIdentifier:DBInstanceIdentifier,Engine:Engine,CACertificateIdentifier:CACertificateIdentifier}'
        
   esac
done
echo 'Starting RDS Cert Script'

echo 'Generating List of Regions'

REGIONS=($(aws ec2 describe-regions --query 'Regions[].RegionName' --output text))

# echo "Region List: $REGIONS"

echo 'Steps to Remedy Out of Data Cert: https://aws.amazon.com/blogs/database/amazon-rds-customers-update-your-ssl-tls-certificates-by-february-5-2020/'
for i in "${REGIONS[@]}"
do
   : 
   # do whatever on $i
   echo "Querying Region $i"
   aws --region $i rds describe-db-instances --max-items 100 --query $FILTER --output table 
   
   
done