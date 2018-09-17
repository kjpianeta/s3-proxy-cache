```bash
docker run -dit --hostname s3-cache-proxy --name s3-cache-proxy -p 80:80 kpianeta/s3-proxy-cache:20171215-1441
```
```bash
docker run -dit --hostname s3-cache-proxy --name s3-cache-proxy -p 8080:80 kpianeta/s3-proxy-cache:20171215-1441
```

```bash
docker build -t kpianeta/s3-proxy:20171219-1439 .
```

```bash
docker pull kpianeta/s3-proxy:20171214-957
```

```
cd /tmp
echo "Config and start YUM proxy cache"
docker run --rm kpianeta/s3-proxy-cache:20171219-1439 cat /usr/local/apache2/conf/httpd.conf > /tmp/httpd.conf
sed -i "s/https\:\/\/s3\.amazonaws\.com/https\:\/\/s3\.${AWS_DEFAULT_REGION}\.amazonaws\.com/g" /tmp/httpd.conf
chown $USER:$USER httpd.conf


docker run \
    -dit \
    --hostname s3-cache-proxy \
    --name s3-cache-proxy \
    --restart always \
    --dns=10.0.0.2 \
    --network host \
    -v /tmp/httpd.conf:/usr/local/apache2/conf/httpd.conf:Z \
    kpianeta/s3-proxy-cache:20171219-1439

docker inspect s3-cache-proxy
```
docker run \
    -dit \
    --hostname s3-cache-proxy \
    --name s3-cache-proxy \
    --restart always \
    --dns=10.0.0.2 \
    --network host \
    -e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
    -e HTTPD_LOG_LEVEL=debug \
    --log-driver=journald --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}" \
    kpianeta/s3-proxy-cache:20180914-1643
```
