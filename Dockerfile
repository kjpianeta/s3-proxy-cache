FROM httpd:2.4

ENV DOCKERIZE_VERSION v1.1.0
ADD my-httpd.conf.tmpl /usr/local/apache2/conf/httpd.conf.tmpl
COPY httpd-foreground /usr/local/bin/
RUN set -ex \ 
    && apt-get update \
    && apt-get install -y wget \
    && rm -r /var/lib/apt/lists/* \
    && wget https://github.com/presslabs/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && apt-get purge -y --auto-remove wget \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && mkdir -p /usr/local/apache2/cache \
    && chown -R www-data:www-data /usr/local/apache2/cache \
    && chmod -R 777 /usr/local/apache2/cache \
    && chmod 755 /usr/local/bin/httpd-foreground
EXPOSE 80
CMD dockerize -template /usr/local/apache2/conf/httpd.conf.tmpl:/usr/local/apache2/conf/httpd.conf /usr/local/bin/httpd-foreground