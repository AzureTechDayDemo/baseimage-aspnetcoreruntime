# Building the dotnet runtime
The repository defines a reference to the public version of the dotnet runtime. 
The purpose of this reference enables demos of base image updates without having to change the public image
It also represents what most enterprises do, keeping their staged version of base images. Just as they control rollouts of windows updates, enterprises prefer more control and stability. 

## build/push w/Docker

```powsershell
$Env:REGISTRY_NAME="demo42.azurecr.io"
docker build -t $Env:REGISTRY_NAME/baseimages/microsoft/aspnetcore/runtime:linux-2.1  .
docker push $Env:REGISTRY_NAME/baseimages/microsoft/aspnetcore/runtime:linux-2.1
```
```sh
REGISTRY_NAME=demo42.azurecr.io
docker build -t ${REGISTRY_NAME}/baseimages/microsoft/aspnetcore/runtime:linux-2.1  .
docker push ${REGISTRY_NAME}/baseimages/microsoft/aspnetcore/runtime:linux-2.1
```

## build/push with ACR Build

### Manual Run
```sh
az acr build -t ${REGISTRY_NAME}/baseimages/microsoft/aspnetcore/runtime:linux-2.1  .
```

### Maintained as a Task
```sh
az acr task create \
  -n baseimage-aspnetcore-runtime \
  -f ./acr-task.yaml \
  --context https://github.com/demo42/baseimage-aspnetcoreruntime.git \
  --git-access-token $PAT \
  --registry $ACR_NAME
```

### Manually trigger the task, as triggers are intentionally disabled

```sh
az acr task run -n baseimage-aspnetcore-runtime
```
