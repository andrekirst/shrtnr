# Sub-Agent Testing and Validation

## Test Scenarios

### 1. cpp-performance-agent Activation Test

**Trigger Test Files:**

- `services/redirecter-cpp/src/main.cpp`
- `services/redirecter-cpp/CMakeLists.txt`

**Expected Behavior:**

- Should activate when working with C++ files
- Should provide performance optimization suggestions
- Should recommend C++23 modern features
- Should suggest memory optimization patterns

**Test Keywords:**

- "performance optimization"
- "million rps"
- "benchmark"
- "c++ redirecter"

### 2. dotnet-aot-agent Activation Test

**Trigger Test Files:**

- `services/webapi/Program.cs`
- `services/webapi/ShrtnrApi.csproj`

**Expected Behavior:**

- Should activate when working with .NET files
- Should suggest AOT-compatible patterns
- Should recommend source generation
- Should validate Minimal APIs usage

**Test Keywords:**

- "aot compilation"
- "source generation"
- "minimal apis"
- ".net performance"

### 3. qwik-frontend-agent Activation Test

**Trigger Test Files:**

- `frontend/src/routes/index.tsx`
- `frontend/package.json`

**Expected Behavior:**

- Should activate when working with frontend files
- Should suggest Qwik best practices
- Should recommend performance optimizations
- Should validate accessibility patterns

**Test Keywords:**

- "frontend optimization"
- "qwik components"
- "web performance"
- "ui development"

### 4. infrastructure-agent Activation Test

**Trigger Test Files:**

- `infrastructure/docker-compose.yml`
- `infrastructure/Dockerfile`

**Expected Behavior:**

- Should activate when working with infrastructure files
- Should suggest Docker optimizations
- Should recommend Kafka configurations
- Should validate monitoring setup

**Test Keywords:**

- "docker optimization"
- "kafka configuration"
- "redis tuning"
- "deployment"

### 5. testing-agent Activation Test

**Trigger Test Files:**

- `services/webapi/tests/UrlServiceTests.cs`
- `frontend/src/components/tests/UrlShortener.spec.ts`

**Expected Behavior:**

- Should activate when working with test files
- Should suggest testing strategies
- Should recommend performance benchmarks
- Should validate test coverage

**Test Keywords:**

- "performance testing"
- "e2e tests"
- "benchmark"
- "test coverage"

### 6. architecture-agent Activation Test

**Trigger Test Files:**

- `docs/architecture.md`
- API design discussions

**Expected Behavior:**

- Should activate for architectural discussions
- Should suggest CQRS patterns
- Should recommend API designs
- Should validate service integration

**Test Keywords:**

- "cqrs pattern"
- "microservices"
- "api design"
- "system architecture"

## Validation Checklist

- [ ] All 6 agents defined in CLAUDE.md
- [ ] Trigger patterns correctly specified
- [ ] Performance targets documented
- [ ] Quality standards defined
- [ ] Code examples provided
- [ ] Manual activation commands documented
- [ ] Multi-agent collaboration scenarios covered
- [ ] Usage guidelines clear and comprehensive

## Expected Agent Behaviors

### Code Quality Focus

Each agent should enforce:

- Technology-specific best practices
- Performance optimization patterns
- Security considerations
- Documentation standards
- Testing strategies

### Performance Optimization

Each agent should suggest:

- Technology-specific optimizations
- Benchmark-driven improvements
- Resource usage optimizations
- Scalability enhancements

### Integration Awareness

Agents should understand:

- Cross-service communication patterns
- Event-driven architecture requirements
- API contract consistency
- End-to-end user workflows

## Success Criteria

✅ **Agent Activation**: Correct agent activates for relevant files/keywords
✅ **Specialized Knowledge**: Agent provides technology-specific expertise
✅ **Performance Focus**: Agent suggests performance optimizations
✅ **Quality Standards**: Agent enforces coding standards
✅ **Integration Awareness**: Agent understands cross-service implications
✅ **Documentation**: Agent suggests proper documentation patterns
