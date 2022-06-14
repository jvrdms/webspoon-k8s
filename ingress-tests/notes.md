https://docs.ovh.com/sg/en/kubernetes/sticky-session-nginx-ingress/


# TESTS WITH DOCKER

## kind with nginx-ingress
https://kind.sigs.k8s.io/docs/user/ingress/

```
kind create cluster --config=kind-config.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl apply -f deploy.yaml -f svc.yaml -f ingress-session-affinity.yaml
```

- https://github.com/kubernetes/ingress-nginx/blob/main/docs/examples/affinity/cookie/ingress.yaml
- https://kubernetes.github.io/ingress-nginx/examples/affinity/cookie/
---

## k3d with traefik-ingress
https://k3d.io/v5.0.1/usage/exposing_services/

```
k3d cluster create --api-port 6550 -p "8081:80@loadbalancer" --agents 2

kubectl apply -f deploy.yaml -f traefik-svc.yaml -f traefik-ingress.yaml
```

- https://github.com/traefik/traefik/blob/v2.6/pkg/provider/kubernetes/ingress/fixtures/Ingress-with-annotations_service.yml
- https://doc.traefik.io/traefik/routing/providers/kubernetes-ingress/#on-service
---




## k3d with nginx-ingress
k3d cluster create notraefik --k3s-arg="--disable=traefik@server:0" -p "8081:80@loadbalancer" --agents 2 --api-port 6550

### install Nginx ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml

kubectl get pods --all-namespaces -w

https://k3d.io/v5.4.1/design/concepts/
https://k3d.io/v5.0.1/usage/exposing_services/


## Nginx ingress controller on K3s - or Kind
https://moonstreet.nl/post/k3s-with-ingress/