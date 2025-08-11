#!/bin/bash

openssl genrsa -out alexey.key 2048
openssl req -new -key alexey.key -out alexey.csr -subj "/CN=alexey/O=developers"
openssl x509 -req -in alexey.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out alexey.crt -days 365

openssl genrsa -out evgenii.key 2048
openssl req -new -key evgenii.key -out evgenii.csr -subj "/CN=evgenii/O=security"
openssl x509 -req -in evgenii.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out evgenii.crt -days 365

kubectl config set-credentials alexey --client-certificate=alexey.crt --client-key=alexey.key
kubectl config set-credentials evgenii --client-certificate=evgenii.crt --client-key=evgenii.key