#docker stop ceos1
#docker rm ceos1
#docker network rm net1
#docker network rm net2

sleep 10

docker create --name=ceos1 --privileged -e INTFTYPE=eth -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceosimage64:4.26.1F /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab

docker network create -o "com.docker.network.bridge.enable_ip_masquerade"="false" net1
docker network create -o "com.docker.network.bridge.enable_ip_masquerade"="false" net2

docker network connect net1 ceos1
docker network connect net2 ceos1

docker start ceos1

sleep 10

 echo " docker exec -it ceos1 Cli"
