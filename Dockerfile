FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

COPY /root/jenkins_agent/workspace/netcore_multi_master/*.csproj ./
RUN dotnet restore

COPY /root/jenkins_agent/workspace/netcore_multi_master/* ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app /app/out .
EXPOSE 80
ENTRYPOINT ["dotnet", ".\api\bin\Debug\netcoreapp2.1\netcore-api.dll"]