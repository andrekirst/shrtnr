# Web API Service

RESTful API service for URL management and user operations built with C# and ASP.NET Core.

## Responsibilities

- **URL CRUD**: Create, read, update, delete short URLs
- **User Management**: Authentication and authorization
- **Analytics API**: Statistics and reporting endpoints
- **Event Publishing**: Kafka integration for CQRS

## Technology Stack

- **Runtime**: .NET 9 with Native AOT
- **Framework**: ASP.NET Core Minimal APIs
- **Database**: PostgreSQL (Entity Framework Core 9)
- **Cache**: Redis (StackExchange.Redis)
- **Message Queue**: Kafka (Confluent.Kafka)
- **Authentication**: JWT Bearer tokens
- **Serialization**: System.Text.Json with Source Generation
- **Performance**: Native AOT compilation for fast startup and low memory usage

## .NET 9 AOT and Source Generation Features

### Native AOT Benefits
- **Ultra-Fast Startup**: < 50ms cold start time
- **Minimal Memory Usage**: Significantly reduced memory footprint
- **Self-Contained**: Zero .NET runtime dependency
- **Optimized Size**: Heavily trimmed deployment packages
- **Better Performance**: Ahead-of-time optimizations

### Source Generation
- **JSON Serialization**: Compile-time JSON serializers with JsonSourceGenerator
- **Entity Framework Core 9**: Compiled LINQ queries and model generation
- **Minimal APIs**: Source-generated route handlers and validators
- **Reflection-Free**: Fully AOT-compatible code generation
- **Configuration Binding**: Source-generated configuration options

## API Endpoints

### URLs

- `POST /api/urls` - Create short URL
- `GET /api/urls/{id}` - Get URL details
- `PUT /api/urls/{id}` - Update URL
- `DELETE /api/urls/{id}` - Delete URL
- `GET /api/urls` - List user's URLs

### Analytics

- `GET /api/analytics/urls/{id}` - URL statistics
- `GET /api/analytics/dashboard` - User dashboard

### Authentication

- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `POST /api/auth/refresh` - Token refresh
