#Becomes: ${REGISTRY_NAME}baseimages/microsoft/aspnetcore-runtime:linux-2.1
FROM microsoft/dotnet:2.1-aspnetcore-runtime
# switch the base image to simulate a valid docker build
#   but a broken runtime the cluster will catch
#FROM node:9-alpine

# Change to simulate an obvious change in the base image
# View on the about page
ENV BACKGROUND_COLOR=White
