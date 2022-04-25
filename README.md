# Run webSpoon on Kubernetes
forcked from https://github.com/HiromuHota/webspoon-docker/tree/master/k8s

- Clone this repository.
- Copy `config/security.xml.bak` to `config/security.xml` and edit users/passwords.
- Run this command to create required resources (`ConfigMaps`, `PersistentVolumes`, `Deployment` and `Service`).

```sh
$ kubectl create cm webspoon-config-cm \
  --from-file config/web.xml \
  --from-file config/security.xml
$ kubectl apply -f .
```

Check that webspoon is running.

```sh
$ kubectl get pod
NAME                        READY   STATUS              RESTARTS   AGE
webspoon-78767c7f57-b9fzd   1/1     Running             0          5m7s
```

Do port forwarding of `8080` port of the service to local machine.

```sh
kubectl port-forward service/webspoon 8080:8080 &
```

While port forwarding, access to the port of local machine.

```
http://localhost:8080
```

# Shared `~/.kettle` and `~/.pentaho` directory

Pods share `~/.kettle` and `~/.pentaho` directory as PersistentVolumeClaim (PVC).
If you want to deploy these PVCs to a Kubernetes cluster which only supports `ReadWriteOnce`, you can configure YAML files.

Edit `kettle-pvc.yaml` and `pentaho-pvc.yaml`.

```yaml
  # - ReadWriteMany # Comment out
  - ReadWriteOnce # Uncomment
```

# Customize

File locations by default

| File | Mount target in webSpoon pod |
|-|-|
| `web.xml` | `/usr/local/tomcat/webapps/spoon/WEB-INF/web.xml` |
| `catalina.policy` | `/usr/local/tomcat/conf/catalina.policy` |
| `security.xml` | `/usr/local/tomcat/webapps/spoon/WEB-INF/spring/security.xml`|

# Tear down

```sh
$ kubectl delete -f .
# If you created ConfigMap
$ kubectl delete configmap webspoon-config-cm
```