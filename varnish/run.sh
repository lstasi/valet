#!/bin/bash

#Build Docker Container
docker build -t proxy /vagrant/varnish

#Run Docker Container
pid=$(docker run -p 8080:8080 -d proxy)