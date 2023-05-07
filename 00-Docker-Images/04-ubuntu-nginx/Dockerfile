FROM ubuntu:18.04
RUN apt-get update -y 
RUN apt-get install nginx -y
RUN apt-get install curl -y 
RUN mkdir -p /var/www/abdhesh/myapp1
RUN rm -rf /var/www/html/index.nginx-debian.html 
COPY index.html abdhesh.jpg status.html  /var/www/abdhesh/myapp1/
COPY abdhesh /etc/nginx/sites-available/ 
#RUN rm -f /etc/nginx/nginx.conf 
#COPY  ./nginx.conf  /etc/nginx/
RUN rm -f /etc/nginx/sites-enabled/* 
RUN ln -s /etc/nginx/sites-available/abdhesh /etc/nginx/sites-enabled/
COPY healthcheck.sh /etc/healthcheck.sh
#RUN chmod +x /etc/healthcheck.sh
EXPOSE 80:80 
CMD ["/usr/sbin/nginx", "-g", "daemon off;"] 



