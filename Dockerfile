FROM registry.access.redhat.com/ubi7/ubi
USER root
LABEL maintainer="David Anderson"
# Update image
RUN yum update --disableplugin=subscription-manager -y && rm -rf /var/cache/yum
RUN yum install --disableplugin=subscription-manager httpd -y && rm -rf /var/cache/yum
RUN sed -i 's/^Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
RUN sed -i 's/^#ServerName.*/ServerName localhost:8080/' /etc/httpd/conf/httpd.conf
RUN chgrp -R root /var/run/httpd
RUN chmod -R g+rw /var/run/httpd
RUN chgrp -R root /var/log/httpd
RUN chmod -R g+rw /var/log/httpd
# Add default Web page and expose port
RUN echo "The Web Server is Running!!!" > /var/www/html/index.html
EXPOSE 8080
# Start the service
USER default
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
