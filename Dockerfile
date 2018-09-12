#Becomes: ${REGISTRY_NAME}/baseimages/microsoft/aspnetcore/runtime:linux-2.1
FROM microsoft/dotnet:2.1-aspnetcore-runtime

# Change to simulate an obvious change in the base image
# View on the about page
ENV BACKGROUND_COLOR=Green
