container_name=layer-builder
docker_image=alayer-builder-image
docker run -td--name=$container_name $docker_image
docker cp ./requirements.txt $container_name:/

docker exec -i $container_name /bin/bash < ./install.sh 
docker cp $container_name:/python.zip python.zip 
docker stop $container_name 
docker rm $container_name