#!/usr/bin/env bash

#sed -i "s/https\:\/\/s3\.amazonaws\.com/https\:\/\/s3\.${AWS_DEFAULT_REGION}\.amazonaws\.com/g" /usr/local/apache2/conf/httpd.conf

/usr/local/bin/httpd-foreground