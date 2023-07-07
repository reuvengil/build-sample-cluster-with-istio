first install helm
then run the commands: 
```
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm search repo istio/base
```
take the version that outputed:
```
helm show values istio/base --version {version that outputed} >istio-base-default.yaml
```