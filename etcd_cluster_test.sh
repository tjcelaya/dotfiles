--name etcd quay.io/coreos/etcd="--name etcd quay.io/coreos/etcd"
PEER_PORT="2380"
INITIAL_CLUSTER_FLAG="-initial-cluster etcd0=http://192.168.12.50:$PEER_PORT,etcd1=http://192.168.12.51:$PEER_PORT,etcd2=http://192.168.12.52:$PEER_PORT"
COMMON_CLUSTER_FLAGS="-initial-cluster-state new -initial-cluster-token etcd-cluster-1"
PORT_FWD_FLAGS="-p 4001:4001 -p $PEER_PORT:$PEER_PORT -p 2379:2379"

docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs $PORT_FWD_FLAGS \
 --name etcd0 quay.io/coreos/etcd \
 -name etcd0 \
 -advertise-client-urls http://192.168.12.50:2379,http://192.168.12.50:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://192.168.12.50:$PEER_PORT \
 -listen-peer-urls http://0.0.0.0:$PEER_PORT \
 $COMMON_CLUSTER_FLAGS \
 $INITIAL_CLUSTER_FLAG

docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs $PORT_FWD_FLAGS \
 --name etcd1 quay.io/coreos/etcd \
 -name etcd1 \
 -advertise-client-urls http://192.168.12.51:2379,http://192.168.12.51:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://192.168.12.51:$PEER_PORT \
 -listen-peer-urls http://0.0.0.0:$PEER_PORT \
 $COMMON_CLUSTER_FLAGS \
 $INITIAL_CLUSTER_FLAG

docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs $PORT_FWD_FLAGS \
 --name etcd2 quay.io/coreos/etcd \
 -name etcd2 \
 -advertise-client-urls http://192.168.12.52:2379,http://192.168.12.52:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://192.168.12.52:$PEER_PORT \
 -listen-peer-urls http://0.0.0.0:$PEER_PORT \
 $COMMON_CLUSTER_FLAGS \
 $INITIAL_CLUSTER_FLAG
