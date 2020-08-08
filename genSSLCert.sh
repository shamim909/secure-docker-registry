#!/bin/sh
#------------------ generate certificate ---------------------------------

#key
openssl genrsa -out ca.key 2048
#cert
openssl req -new -x509 -days 365 -key ca.key -subj "/C=US/ST=WA/L=Bellevue/O=xyzInc/OU=IoT/CN=10.0.1.3/" -out ca.crt
#server 
openssl req -newkey rsa:2048 -nodes -keyout server.key -subj "/C=US/ST=WA/L=Bellevue/O=xyzInc/OU=IoT/CN=10.0.1.3/" -out server.csr

#self sign
openssl x509 -req -extfile <(printf "subjectAltName=IP:10.0.1.3,IP:192.168.1.8, DNS:app.xyz.com") -days 365 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt
#verify
openssl x509 -in server.crt -text -noout
# please look for DNS entry/IP address.
