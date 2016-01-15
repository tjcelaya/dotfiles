case $1 in
*init*)
  docker pull progrium/consul
  ;;
*start*)
  JOIN_IP="$(docker inspect -f '{{.NetworkSettings.IPAddress}}' node1)"
  docker run -d --name node2 -h node2 progrium/consul -server -join $JOIN_IP
  docker run -d --name node3 -h node3 progrium/consul -server -join $JOIN_IP
  docker run -d -p 8400:8400 -p 8500:8500 -p 8600:53/udp --name node4 -h node4 progrium/consul -join $JOIN_IP
  docker ps -a
  ;;
*stop*)
  docker stop $(docker ps -a -q)
  ;;
*status*)
  docker ps -a
  ;;
*)
  echo "Usage: consul_cluster.sh {init|start|stop|status}
