FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.sln .
COPY src/ src/
RUN dotnet restore && dotnet build --no-restore -c Release && dotnet publish --no-build -c Release -o ./publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT [ "dotnet", "API.Gateway.dll" ]