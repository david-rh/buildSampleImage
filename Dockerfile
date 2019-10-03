FROM registry.access.redhat.com/ubi7/ubi
USER root
LABEL maintainer="David Anderson"
# Update image
RUN yum update --disableplugin=subscription-manager -y && rm -rf /var/cache/yum
RUN yum install --disableplugin=subscription-manager httpd -y && rm -rf /var/cache/yum
RUN sed 'sed s/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
# Add default Web page and expose port
RUN echo "The Web Server is Running" > /var/www/html/index.html
EXPOSE 8080
# Start the service
USER default
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
