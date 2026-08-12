# Linux Networking Commands

## 1. IP Address

ip addr

ip a

## 2. Routing

ip route

route -n

## 3. Hostname

hostname

hostname -f

hostnamectl

## 4. DNS

### Resolve hostname
nslookup google.com

### DNS lookup
dig google.com

### Reverse DNS
dig -x 8.8.8.8

### Check specific DNS server
dig @8.8.8.8 google.com

## 5. Connectivity

### Ping
ping 8.8.8.8

ping google.com

## 6. Test Port

### Using nc
nc -zv 10.10.10.10 6379

### Using telnet
telnet 10.10.10.10 6379

### Using curl
curl -v http://localhost:8080

## 7. Listening Ports

ss -tulnp

ss -lntp

### Check specific port
ss -lntp | grep 6379

## 8. Network Connections

ss -ant

ss -s

## 9. Download / HTTP Testing

curl http://example.com

curl -I http://example.com

curl -v https://example.com

curl -k https://example.com

## 10. HTTP Status

curl -I https://example.com

Example:

HTTP/1.1 200 OK

## 11. Network Interface

ip link

ip link show

## 12. ARP

ip neigh

arp -n

## 13. Trace Network Path

traceroute google.com

tracepath google.com

## 14. DNS Configuration

cat /etc/resolv.conf

## 15. Hosts File

cat /etc/hosts

### Add local hostname mapping

sudo vi /etc/hosts

Example:

10.10.10.20 redis01.example.com

## 16. Firewall

### Check firewall
sudo firewall-cmd --state

### List firewall rules
sudo firewall-cmd --list-all

### Ubuntu
sudo ufw status

## 17. Packet Capture

sudo tcpdump -i any port 6379

sudo tcpdump -i eth0 host 10.10.10.20

## 18. Redis Connectivity Troubleshooting

### Check DNS
dig redis.example.com

### Check IP connectivity
ping redis.example.com

### Check Redis port
nc -zv redis.example.com 6379

### Check TLS Redis port
nc -zv redis.example.com 6380

### Check listening port
ss -lntp | grep 6379

### Test Redis
redis-cli -h redis.example.com -p 6379 PING

Expected:

PONG

## Network Troubleshooting Flow

Application
    |
    v
DNS resolution
    |
    v
IP connectivity
    |
    v
Routing
    |
    v
Firewall
    |
    v
Port connectivity
    |
    v
Application/service
    |
    v
Logs

## Important Commands

ip
ping
ss
nc
telnet
curl
dig
nslookup
traceroute
tcpdump
