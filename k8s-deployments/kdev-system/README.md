# Apply

```
kubectl apply -f namespaces/kdev-system.yaml
kubectl apply -f namespaces/cert-manager.yaml
helm install -n kdev-system prometheus -f prometheus/config.yaml prometheus-com/prometheus
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.0.1 --set installCRDs=true
```

## build lvmd for arm64

```
git clone https://github.com/topolvm/topolvm
cd topolvm
GOARCH=arm64 GOOS=linux make build/lvmd
sudo mv lvmd /usr/local/bin
```
