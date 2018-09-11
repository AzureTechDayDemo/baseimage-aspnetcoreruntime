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
** preview syntax **
```sh
az acr build-task create \
  -n demo42aspnetcoreruntime \
  --context https://github.com/demo42/baseimage-aspnetcoreruntime \
  -t baseimages/microsoft/aspnetcore/runtime:linux-2.1 \
  --build-arg REGISTRY_NAME=$REGISTRY_NAME \
  --git-access-token $(az keyvault secret show \
                         --vault-name $AKV_NAME \
                         --name $GIT_TOKEN_NAME \
                         --query value -o tsv) \
  --commit-trigger-enabled false \
  --base-image-trigger none \
  --registry $ACR_NAME 
```
** GA syntax **
```sh
az acr task create \
  -n demo42-aspnetcore-runtime \
  --context https://github.com/demo42/baseimage-aspnetcoreruntime \
  --file Dockerfile \
  -t baseimages/microsoft/aspnetcore/runtime:linux-2.1 \
  --git-access-token $GIT_TOKEN \
  --commit-trigger-enabled true \
  --base-image-trigger-enabled false \
  --registry $ACR_NAME 
```

### Manually trigger the task, as triggers are intentionally disabled
** Preview Syntax **
```sh
az acr build-task run -n demo42aspnetcoreruntime
```

** GA Syntax **
```sh
az acr task run -n demo42-aspnetcore-runtime
```
