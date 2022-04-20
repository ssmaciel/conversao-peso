# image build
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY [ "ConversaoPeso.Web/ConversaoPeso.Web.csproj", "ConversaoPeso.Web/" ]
RUN dotnet restore "ConversaoPeso.Web/ConversaoPeso.Web.csproj"

COPY ConversaoPeso.Web/. ./ConversaoPeso.Web/
WORKDIR /src/ConversaoPeso.Web
RUN dotnet publish -c release -o /app --no-restore

# image production
FROM mcr.microsoft.com/dotnet/aspnet:5.0 as production
WORKDIR /app
COPY --from=build /app ./
EXPOSE 80
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]