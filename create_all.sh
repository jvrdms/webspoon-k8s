#!/bin/bash

kubectl create configmap webspoon-config-cm \
  --from-file=config/web.xml \
  --from-file=config/catalina.policy
[ ! -s config/security.xml ] && cp config/security.xml{.back,}
kubectl create secret generic webspoon-secret \
  --from-file=config/security.xml
kubectl apply -f .
