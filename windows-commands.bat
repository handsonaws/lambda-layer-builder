@REM Launch Docker Desktop if required
@REM Docker Login if required
docker build -t layer-builder-image .
docker run -td --name=layer-builder layer-builder-image
docker cp .\requirements.txt layer-builder:/
docker exec -i layer-builder /bin/bash < ./install.sh
docker cp layer-builder:/python.zip python.zip
docker stop layer-builder
docker rm layer-builder