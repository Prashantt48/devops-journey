i# Redis DBA / Engineer Interview Preparation

## Q1. What is Redis?

### Answer

Redis is an in-memory data store used as a database, cache, message broker, and streaming platform.

It stores data primarily in RAM, which provides very low latency and high throughput.

### Key Capabilities

- Key-value data model
- Strings
- Lists
- Sets
- Sorted Sets
- Hashes
- Streams
- Pub/Sub
- Transactions
- Lua scripting
- Persistence using RDB/AOF
- Replication
- Clustering and sharding
- High availability
- TLS and ACL-based security


---

# Q2. Explain Redis Architecture for a Banking Application

### Architecture

```text
                    +----------------------+
                    |     Banking Apps     |
                    |   Mobile / Web / API |
                    +----------+-----------+
                               |
                               |
                        +------v-------+
                        | Load Balancer|
                        +------+-------+
                               |
                               |
                     +---------v----------+
                     |  Application Layer |
                     +---------+----------+
                               |
                               |
                     +---------v----------+
                     | Redis Enterprise   |
                     |      Cluster       |
                     +---------+----------+
                               |
                 +-------------+-------------+
                 |                           |
          +------v------+             +------v------+
          |   Shard 1   |             |   Shard 2   |
          |   Primary   |             |   Primary   |
          |   Replica   |             |   Replica   |
          +-------------+             +-------------+
                 |                           |
                 +-------------+-------------+
                               |
                      +--------v---------+
                      | Persistent       |
                      | Storage          |
                      +--------+---------+
                               |
                      +--------v---------+
                      | Backup / DR      |
                      +------------------+
