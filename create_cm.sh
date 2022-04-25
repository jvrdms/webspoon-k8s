kubectl create cm webspoon-config-cm \
  --from-file config/web.xml \
  --from-file config/security.xml