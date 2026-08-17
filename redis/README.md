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

## Common Redis Commands

Check Redis connectivity:
```text
redis-cli ping

Expected output:
```text
PONG

Check Redis server information:
```text
redis-cli info

Check memory usage:
```text
redis-cli info memory

Check connected clients:
```text
redis-cli client list

Set a key:
```text
redis-cli SET name "Redis"

Get a key:
```text
redis-cli GET name

Delete a key:
```text
redis-cli DEL name

Check key expiration:
```text
redis-cli TTL name
