# =========================
# Build stage
# =========================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy only project file first (for caching)
COPY DotNetCoreAPI/*.csproj ./DotNetCoreAPI/
RUN dotnet restore ./DotNetCoreAPI/SampleApi.csproj

# Copy the rest of the source
COPY DotNetCoreAPI/. ./DotNetCoreAPI/
WORKDIR /src/DotNetCoreAPI
RUN dotnet publish -c Release -o /app/publish

# =========================
# Runtime stage
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app

# Force ASP.NET to listen on 8080 (CRITICAL for AKS)
ENV ASPNETCORE_URLS=http://+:8080

COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "SampleApi.dll"]