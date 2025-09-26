# Redirecter Service (C++)

Ultra-high-performance URL redirect service engineered to handle 1,000,000+ requests per second with sub-microsecond latency.

## Features

- **Redis-first lookup**: Sub-millisecond response times
- **PostgreSQL fallback**: Ensures 100% availability
- **Kafka logging**: Event streaming for analytics
- **C++ performance**: Optimized for high throughput

## Architecture

- **Primary data source**: Redis cache
- **Fallback**: PostgreSQL database
- **Event publishing**: Kafka for redirect analytics
- **Protocol**: HTTP with 302 redirects

## Build Requirements

- **C++23** (GCC 14+, Clang 18+, or MSVC 2022 17.8+)
- **CMake 3.28+**
- **Dependencies**:
  - **libhiredis** (Redis client)
  - **libpq** (PostgreSQL client)
  - **librdkafka** (Kafka client)
  - **Crow** or **Beast** (HTTP framework)
  - **fmt** (C++23 formatting library)
  - **spdlog** (High-performance logging)

## C++23 Features Utilized

### Modern Language Features
- **std::expected**: Error handling without exceptions
- **std::print/std::format**: Type-safe formatted output
- **Ranges and Views**: Functional-style data processing
- **Coroutines**: Async/await patterns for I/O operations
- **std::span**: Safe array/vector views
- **Modules**: Faster compilation and better encapsulation

### Performance Optimizations
- **Concepts**: Compile-time interface validation
- **consteval**: Compile-time computations
- **likely/unlikely**: Branch prediction hints
- **std::simd**: Vectorized operations (when available)

## Performance Targets (1M+ RPS)

### Primary Goals
- **Throughput**: > 1,000,000 req/sec per instance
- **Response time**: < 100μs (p99, Redis hit)
- **Memory usage**: < 1GB resident memory at peak load
- **CPU efficiency**: < 80% CPU at 1M req/sec
- **Availability**: 99.999% (5-nines)

### Ultra-Performance Optimizations
- **Zero-copy networking**: Custom memory pools and buffer management
- **Lock-free data structures**: Concurrent hash maps for request routing
- **NUMA-aware threading**: Thread affinity and memory locality
- **Kernel bypass**: DPDK or io_uring for maximum network performance
- **CPU cache optimization**: Data structure alignment and prefetching
- **Vectorized string operations**: AVX-512 for URL processing

## Build Configuration

### CMake Setup
```bash
mkdir build && cd build
cmake -DCMAKE_CXX_STANDARD=23 \
      -DCMAKE_BUILD_TYPE=Release \
      -DENABLE_LTO=ON \
      -DENABLE_NATIVE_ARCH=ON \
      ..
make -j$(nproc)
```

### Compiler Requirements
- **GCC 14+**: Full C++23 support
- **Clang 18+**: Complete std::expected and ranges
- **Intel C++ 2024+**: Optimized for high-performance computing

### Runtime Dependencies
- **Redis 7+**: For optimal pipelining support
- **libhiredis 1.2+**: Async command support
- **Kafka 3.0+**: Modern protocol features

## Million RPS Architecture

### Network Layer Optimizations
```cpp
// Example: Zero-copy HTTP response with custom allocators
class ZeroCopyResponse {
    std::pmr::memory_resource* pool_;
    std::span<char> buffer_;
public:
    template<std::size_t N>
    consteval auto build_redirect_template() {
        return "HTTP/1.1 302 Found\r\nLocation: {}\r\nContent-Length: 0\r\n\r\n";
    }
};
```

### Threading Architecture
- **Thread Pool**: One thread per CPU core (NUMA-aware)
- **Event Loop**: io_uring or epoll for async I/O
- **Connection Pool**: Persistent Redis connections per thread
- **Memory Pools**: Thread-local allocators to avoid contention

### Hardware Requirements for 1M RPS

#### Minimum Production Setup
- **CPU**: 32+ cores (Intel Xeon Ice Lake or AMD EPYC 4th Gen)
- **Memory**: 64GB DDR4-3200 or DDR5-4800
- **Network**: 100Gbps NIC with SR-IOV support
- **Storage**: NVMe SSD for logs (Redis in memory)

#### Optimal Configuration
- **CPU**: 64+ cores with high single-thread performance
- **Memory**: 128GB+ with NUMA topology optimization
- **Network**: Dual 100Gbps or single 400Gbps with DPDK
- **Cores per Service**: Dedicated cores for network, processing, and I/O

### Advanced Optimizations

#### Kernel Bypass
```bash
# DPDK setup for kernel bypass networking
echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
modprobe vfio-pci
echo 8086 1572 > /sys/bus/pci/drivers/vfio-pci/new_id
```

#### CPU Optimizations
- **CPU Pinning**: Isolate cores for the application
- **IRQ Affinity**: Route interrupts to specific cores
- **Governor**: Set to 'performance' mode
- **Turbo Boost**: Enable for maximum single-thread performance

#### Memory Optimizations
- **Huge Pages**: 2MB pages for reduced TLB misses
- **Memory Prefetching**: `__builtin_prefetch()` for hot paths
- **Cache Line Alignment**: 64-byte aligned data structures
- **False Sharing**: Avoid by padding critical structures