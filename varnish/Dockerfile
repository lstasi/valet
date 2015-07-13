FROM        ubuntu:15.04
MAINTAINER  Ubuntu Core
 
ENV DEBIAN_FRONTEND noninteractive

# Update apt sources
RUN echo "deb http://archive.ubuntu.com/ubuntu vivid main universe" > /etc/apt/sources.list
RUN apt-get update

# Install Varnish
RUN apt-get -y install varnish

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

# Export environment variables
ENV VARNISH_PORT 8081

# Expose port 8081
EXPOSE 8081

ADD start /start

RUN chmod 0755 /start
# Start Service
CMD ["/start"]

