#! /bin/sh

mkdir /srv/pgadmin/

docker ps -a | awk '{ print $1,$2 }' | grep projetoarcanjo/pgadmin | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi projetoarcanjo/pgadmin
docker build --tag=projetoarcanjo/pgadmin --rm=true .

docker run --name pgadmin --hostname=pgadmin  \
-e PGADMIN_DEFAULT_EMAIL=arcanjo@cmabreu.com.br \
-e PGADMIN_DEFAULT_PASSWORD=@rcanjo \
-v /etc/localtime:/etc/localtime:ro \
-p 36007:80 \
-v /srv/pgadmin/:/var/lib/pgadmin \
-d projetoarcanjo/pgadmin	

docker network connect arcanjo pgadmin