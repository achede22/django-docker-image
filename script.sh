#!/bin/bash
# a script that create a docker container
MYPATH=$1

echo "USAGE: script.sh [local_path]"

# check input parameters
if [ -z "$MYPATH" ]; then
    echo "Error: local path is not set"
    exit
fi

# create the path
echo "Insert the path of your volume: $MYPATH"

# pull the image
docker pull pierangelo1982/django

# create a volume
docker volume create --name django-test

# connect the volume to the container for can copy the project folder
docker run --name django-test \
	-v django-test:/code \
	-p 8001:8000 \
	-d pierangelo1982/django

# copy project folders in your host
docker cp django-test:/code $MYPATH

# remove the container
docker rm -f django-test

# recreate the container with the volume that point to our local folder where before we have copy the folders of the project.
docker run --name django-test \
	-v $MYPATH:/code \
	-p 8001:8000 \
	-d pierangelo1982/django
