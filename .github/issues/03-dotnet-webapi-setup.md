# Issue #3: .NET 9 AOT Web API - Basis Setup

**Labels:** `enhancement`, `backend`, `dotnet`, `mvp`, `priority-high`
**Milestone:** MVP Phase 2
**Estimated Time:** 1 day (8 hours)

## 📋 Description
Set up the foundational .NET 9 Web API project with Native AOT compilation, ASP.NET Core Minimal APIs, and all required dependencies for the shrtnr backend service.

## 🎯 Acceptance Criteria
- [ ] .NET 9 project created with AOT support
- [ ] ASP.NET Core Minimal APIs configured
- [ ] Entity Framework Core 9 integrated
- [ ] Dependency injection container configured
- [ ] Configuration system set up (appsettings.json, environment variables)
- [ ] Logging configured (structured logging with Serilog)
- [ ] Health checks implemented
- [ ] Swagger/OpenAPI documentation
- [ ] Project builds and runs with AOT

## 🛠️ Technical Requirements
- **.NET 9 SDK** with Native AOT support
- **ASP.NET Core Minimal APIs** for lightweight HTTP handling
- **Entity Framework Core 9** with PostgreSQL provider
- **System.Text.Json** with source generation
- **Serilog** for structured logging
- **Confluent.Kafka** for message publishing
- **StackExchange.Redis** for caching

## 📝 Implementation Tasks

### Project Setup
```bash
# Create new web API project
dotnet new web -n ShrtnrApi -o services/webapi
cd services/webapi

# Enable Native AOT
dotnet add package Microsoft.AspNetCore.App --version 9.0.0
```

### Package Dependencies
```xml
<PackageReference Include="Microsoft.EntityFrameworkCore" Version="9.0.0" />
<PackageReference Include="Npgsql.EntityFrameworkCore.PostgreSQL" Version="9.0.0" />
<PackageReference Include="StackExchange.Redis" Version="2.8.0" />
<PackageReference Include="Confluent.Kafka" Version="2.3.0" />
<PackageReference Include="Serilog.AspNetCore" Version="8.0.0" />
<PackageReference Include="Swashbuckle.AspNetCore" Version="6.8.0" />
```

### Project Configuration
- [ ] Enable Native AOT in `.csproj`
- [ ] Configure JSON source generation
- [ ] Set up PublishAot properties
- [ ] Configure trimming-safe code

### Service Registration
```csharp
var builder = WebApplication.CreateBuilder(args);

// Entity Framework
builder.Services.AddDbContext<ShrtnrDbContext>(options =>
    options.UseNpgsql(connectionString));

// Redis
builder.Services.AddSingleton<IConnectionMultiplexer>(provider =>
    ConnectionMultiplexer.Connect(redisConnectionString));

// Kafka
builder.Services.AddSingleton<IProducer<string, string>>(provider =>
    new ProducerBuilder<string, string>(kafkaConfig).Build());

// Health checks
builder.Services.AddHealthChecks()
    .AddNpgSql(connectionString)
    .AddRedis(redisConnectionString);
```

### Configuration System
- [ ] `appsettings.json` for default settings
- [ ] `appsettings.Development.json` for dev overrides
- [ ] Environment variable configuration
- [ ] Connection string configuration
- [ ] Kafka configuration
- [ ] Redis configuration

## 🔧 AOT-Specific Implementation

### JSON Source Generation
```csharp
[JsonSerializable(typeof(CreateUrlRequest))]
[JsonSerializable(typeof(CreateUrlResponse))]
[JsonSerializable(typeof(UrlDto))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase)]
public partial class ShrtnrJsonContext : JsonSerializerContext
{
}
```

### Trimming-Safe Configuration
- [ ] Suppress trimming warnings appropriately
- [ ] Use reflection-free configurations
- [ ] Configure source generators
- [ ] Test AOT compatibility

## 📊 Testing Strategy
- [ ] Application starts successfully
- [ ] Health checks return healthy status
- [ ] Database connection established
- [ ] Redis connection working
- [ ] Kafka producer initialized
- [ ] Swagger UI accessible
- [ ] AOT build succeeds
- [ ] AOT runtime testing

## ✅ Definition of Done
- [ ] .NET 9 project created and configured
- [ ] All dependencies installed and working
- [ ] Native AOT compilation successful
- [ ] Application runs with sub-50ms startup
- [ ] Health checks implemented and passing
- [ ] Configuration system working
- [ ] Logging outputs structured logs
- [ ] Swagger documentation accessible

## 📁 Affected Files
- `services/webapi/ShrtnrApi.csproj`
- `services/webapi/Program.cs`
- `services/webapi/appsettings.json`
- `services/webapi/appsettings.Development.json`
- `services/webapi/Data/ShrtnrDbContext.cs`
- `services/webapi/Models/JsonContext.cs`
- `services/webapi/README.md`

## 🚀 Success Metrics
- **Startup Time**: < 50ms (AOT)
- **Memory Usage**: < 100MB at startup
- **Build Time**: < 2 minutes for AOT build
- **Binary Size**: < 50MB (trimmed)
- **Health Check Response**: < 1ms for all checks