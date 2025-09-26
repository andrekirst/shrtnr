# Claude Code Configuration for shrtnr

## Project Overview

shrtnr is a high-performance URL shortener built with modern technologies targeting 1M+ requests per second. This project uses specialized sub-agents to ensure code quality and performance across different technology stacks.

## Commands

### Build Commands

```bash
# Build entire project
npm run build

# Build specific services
cd services/webapi && dotnet build --configuration Release
cd services/redirecter-cpp && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j$(nproc)
cd frontend && npm run build

# Run tests
npm test
```

### Development Commands

```bash
# Start infrastructure
cd infrastructure && docker-compose up -d

# Start services in development
cd services/webapi && dotnet run --environment Development
cd services/redirecter-cpp/build && ./redirecter
cd frontend && npm run dev
```

## Sub-Agents Configuration

The shrtnr project uses 6 specialized sub-agents located in `.claude/agents/` that automatically activate based on file patterns and task context. Each agent is an expert in their respective technology stack and follows the official Claude Code SDK specification.

### Available Sub-Agents

### 1. cpp-performance-agent 🔥

**Location:** `.claude/agents/cpp-performance-agent.md`
**Purpose:** Ultra-high-performance C++23 code optimization for million RPS capability

**Triggers:**

- Files: `services/redirecter-cpp/**/*.{cpp,h,hpp,cmake}`
- Keywords: "performance", "optimization", "benchmark", "million rps", "c++", "redirecter"
- Tasks: C++ code review, performance optimization, memory management

**Specializations:**

- C++23 modern features (std::expected, coroutines, SIMD)
- Kernel-level optimizations (DPDK, io_uring)
- Lock-free data structures, NUMA-aware programming
- Zero-copy networking, memory pools
- Profiling and benchmarking (perf, Valgrind, Intel VTune)

**Quality Standards:**

- Exception-safe RAII code
- Template metaprogramming best practices
- Cache-friendly data structures
- Sub-microsecond latency optimizations

**Code Examples:**

```cpp
// Preferred patterns for this agent
std::expected<std::string, RedisError> lookup_url(const std::string& short_code);
constexpr auto build_redirect_template() -> std::string_view;
[[likely]] if (cache_hit) { /* fast path */ }
```

### 2. dotnet-aot-agent ⚡

**Location:** `.claude/agents/dotnet-aot-agent.md`
**Purpose:** .NET 9 Native AOT optimization with source generation

**Automatic Activation:**

- Working with files in `services/webapi/`
- .NET/C# code files (`.cs`, `.csproj`)
- Keywords: "aot", "source generation", "minimal apis", ".net"

**Specializations:**

- ASP.NET Core Minimal APIs with source generation
- Entity Framework Core 9 optimizations
- System.Text.Json source generators
- Native AOT trimming and reflection-free code
- Performance monitoring (dotnet-counters, PerfView)

**Quality Standards:**

- SOLID principles and clean architecture
- AOT-compatible code patterns
- Proper dependency injection usage
- Source generator implementations

**Code Examples:**

```csharp
// Preferred patterns for this agent
[JsonSerializable(typeof(CreateUrlRequest))]
public partial class ShrtnrJsonContext : JsonSerializerContext { }

app.MapPost("/api/urls", async (CreateUrlRequest request) => { });
```

### 3. qwik-frontend-agent 🖥️

**Location:** `.claude/agents/qwik-frontend-agent.md`
**Purpose:** Modern frontend development with Qwik and optimal web performance

**Automatic Activation:**

- Working with files in `frontend/`
- Frontend files (`.tsx`, `.ts`, `.css`, package.json)
- Keywords: "frontend", "ui", "components", "qwik", "performance"

**Specializations:**

- Qwik + Qwik City SSR/SSG optimizations
- TypeScript strict mode and advanced types
- Tailwind CSS, responsive design, accessibility
- Web performance (Core Web Vitals, Lighthouse)
- PWA features and service workers

**Quality Standards:**

- Component design best practices
- Type safety and error handling
- Accessible UI (WCAG 2.1 AA)
- Performance-first development

**Code Examples:**

```typescript
// Preferred patterns for this agent
export const UrlShortener = component$<UrlShortenerProps>(({ onSubmit }) => {
  const url = useSignal("");
  return <form onSubmit$={handleSubmit}>...</form>;
});
```

### 4. infrastructure-agent 🐳

**Location:** `.claude/agents/infrastructure-agent.md`
**Purpose:** DevOps, containerization, and infrastructure management

**Automatic Activation:**

- Working with files in `infrastructure/`
- Docker and K8s files (`docker-compose.yml`, `Dockerfile`, `*.yaml`)
- Keywords: "docker", "kafka", "redis", "postgres", "deployment"

**Specializations:**

- Docker multi-stage builds and optimized images
- Kafka event streaming and CQRS patterns
- Redis clustering and performance tuning
- PostgreSQL optimizations and index design
- Kubernetes, Helm charts, monitoring solutions

**Quality Standards:**

- Infrastructure as Code principles
- Security best practices
- Production-ready scalability
- Comprehensive monitoring

**Code Examples:**

```yaml
# Preferred patterns for this agent
services:
  redis:
    image: redis:8.2-alpine
    command: redis-server --appendonly yes
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
```

### 5. testing-agent 🧪

**Location:** `.claude/agents/testing-agent.md`
**Purpose:** Comprehensive testing strategy and quality assurance

**Automatic Activation:**

- Working with test files (`*test*`, `*spec*`, `tests/`)
- CI/CD files (`.github/workflows/`)
- Keywords: "test", "benchmark", "ci/cd", "quality", "coverage"

**Specializations:**

- Unit testing (xUnit, Google Test, Vitest)
- Integration and E2E testing (Playwright)
- Load testing (k6, Artillery) and performance benchmarks
- Code coverage and static analysis
- CI/CD pipelines (GitHub Actions)

**Quality Standards:**

- Test-driven development
- Comprehensive coverage (>90%)
- Performance regression testing
- Automated quality gates

**Code Examples:**

```typescript
// Preferred patterns for this agent
test("should create short URL successfully", async ({ page }) => {
  await page.fill('[data-testid="url-input"]', "https://example.com");
  await page.click('[data-testid="shorten-btn"]');
  await expect(page.locator('[data-testid="result"]')).toBeVisible();
});
```

### 6. architecture-agent 🏗️

**Location:** `.claude/agents/architecture-agent.md`
**Purpose:** System architecture, CQRS patterns, and microservices design

**Automatic Activation:**

- Working with architecture documentation
- Service interfaces and API definitions
- Keywords: "architecture", "design", "cqrs", "integration", "microservices"

**Specializations:**

- CQRS/Event Sourcing patterns
- Microservices communication patterns
- API design and OpenAPI specifications
- Security architecture (authentication, authorization)
- Monitoring, observability, distributed tracing

**Quality Standards:**

- Clean architecture principles
- Domain-driven design
- Scalable and resilient systems
- Well-documented APIs

**Code Examples:**

```csharp
// Preferred patterns for this agent
public record UrlCreatedEvent(Guid UrlId, string ShortCode, DateTime CreatedAt) : IEvent;

public interface IEventPublisher
{
    Task PublishAsync<T>(T @event) where T : IEvent;
}
```

## How Sub-Agents Work

### Automatic Activation

Sub-agents are automatically activated by the Claude Code SDK when:

1. **File Pattern Matching**: Working with files that match agent-specific patterns
2. **Contextual Relevance**: Task context indicates need for specialized expertise
3. **Keyword Detection**: Relevant keywords in code comments or discussions
4. **Tool Usage**: Specific development tools that align with agent expertise

### SDK Integration

The sub-agents follow the official Claude Code SDK specification:

- Located in `.claude/agents/` directory
- Defined using Markdown with YAML frontmatter
- Include `name`, `description`, and optional `tools` fields
- Automatically inherited by the main Claude Code session

### Agent Collaboration

Multiple agents can work together on cross-cutting concerns:

- **Full-stack features**: All agents collaborate for end-to-end development
- **Performance optimization**: cpp-performance-agent + dotnet-aot-agent
- **Deployment**: infrastructure-agent + testing-agent
- **API integration**: dotnet-aot-agent + architecture-agent + qwik-frontend-agent

## Performance Targets by Agent

### cpp-performance-agent

- **Response Time**: < 100μs (p99) for Redis cache hits
- **Throughput**: 1,000,000+ requests/sec per instance
- **Memory Usage**: < 1GB at peak load
- **Build Time**: < 2 minutes clean build

### dotnet-aot-agent

- **Startup Time**: < 50ms cold start
- **Memory Footprint**: 70% reduction vs. JIT
- **API Response**: < 50ms for all endpoints
- **Binary Size**: < 50MB (trimmed)

### qwik-frontend-agent

- **Bundle Size**: < 200KB initial load
- **Lighthouse Score**: > 95 for Performance, SEO, Accessibility
- **Time to Interactive**: < 3 seconds
- **Build Time**: < 30 seconds

### infrastructure-agent

- **Container Startup**: < 30 seconds for all services
- **Health Check Response**: < 1 second
- **Resource Usage**: Optimized memory and CPU
- **Deployment Time**: < 5 minutes end-to-end

### testing-agent

- **Test Coverage**: > 90% for critical paths
- **E2E Test Success**: 100% pass rate
- **Load Test Results**: Meet performance targets
- **CI/CD Pipeline**: < 10 minutes total

### architecture-agent

- **API Design**: Complete OpenAPI specs
- **Event Processing**: < 10ms event publishing latency
- **Service Integration**: > 99.9% success rate
- **Documentation**: 100% API coverage

## Usage Guidelines

### When to Use Which Agent

1. **Starting a new C++ feature?** → `@cpp-performance-agent`
2. **Adding .NET API endpoints?** → `@dotnet-aot-agent`
3. **Building UI components?** → `@qwik-frontend-agent`
4. **Configuring services?** → `@infrastructure-agent`
5. **Writing tests?** → `@testing-agent`
6. **Designing system integration?** → `@architecture-agent`

### Multi-Agent Collaboration

For cross-cutting concerns, multiple agents may collaborate:

- **Performance optimization**: cpp-performance-agent + dotnet-aot-agent
- **End-to-end features**: All agents for full-stack development
- **Deployment**: infrastructure-agent + testing-agent
- **API integration**: dotnet-aot-agent + architecture-agent + qwik-frontend-agent

## Quality Assurance

Each agent ensures:

- **Code Standards**: Technology-specific best practices
- **Performance**: Meets or exceeds performance targets
- **Security**: Security best practices for each stack
- **Documentation**: Comprehensive and up-to-date docs
- **Testing**: Appropriate test coverage and strategies

This configuration ensures that shrtnr maintains the highest quality standards across all technology stacks while achieving its ambitious performance goals.
