[ ! -s config/security.xml ] && cp config/security.xml{.back,}
kubectl create cm webspoon-config-cm \
  --from-file config/web.xml \
  --from-file config/security.xml \
  --from-file config/catalina.policy
kubectl apply -f .