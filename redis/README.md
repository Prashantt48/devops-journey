# Redis

Redis is an in-memory data store commonly used for caching, session management,
real-time applications, messaging, and high-performance data processing.

## Key Features

- In-memory data storage
- Key-value data model
- High performance and low latency
- Persistence using RDB and AOF
- Replication
- Redis Sentinel
- Redis Cluster
- Pub/Sub
- Streams
- Transactions
- TTL and expiration
- Multiple eviction policies

## Configuration

The main Redis configuration file in this directory is:

```text
redis.conf

Persistence

Redis supports two primary persistence mechanisms:

RDB

Point-in-time snapshots of the Redis dataset.

AOF

Logs write operations so the dataset can be reconstructed.

Memory Management

Redis provides several eviction policies:

noeviction
allkeys-lru
volatile-lru
allkeys-lfu
volatile-lfu
allkeys-random
volatile-random
volatile-ttl

Example:

maxmemory 512mb
maxmemory-policy allkeys-lru
High Availability

Redis high availability can be implemented using:

Redis Replication
       |
       +-- Primary
       |
       +-- Replica

For automated failover:

Redis Sentinel
      |
      +-- Primary
      +-- Replica
      +-- Replica

For horizontal scaling:

Redis Cluster
   |
   +-- Shard 1
   +-- Shard 2
   +-- Shard 3
Monitoring

Redis can be monitored using tools such as:

Prometheus
Grafana
Redis exporter
Dynatrace
ELK
DevOps Integration

Redis can be deployed and managed using:

Docker
Kubernetes
OpenShift
Git
Jenkins
Argo CD
GitOps
Learning Topics

Recommended Redis learning path:

Redis fundamentals
Redis CLI commands
Configuration
Persistence
Memory management
Replication
Sentinel
Redis Cluster
Backup and restore
Monitoring
Performance tuning
Docker deployment
Kubernetes deployment
High availability
Disaster recovery

