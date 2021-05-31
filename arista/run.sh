docker build -t srikns/ceosimage:4.22.0F .

sleep 5

docker run -d --privileged  --name=ceos1 srikns/ceosimage:4.22.0F
