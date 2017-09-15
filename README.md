
## STEP 1 - Create Dockerfile and push it on Docker Hub
In a folder I create a file named Dockerfile and an another named requirements.txt

Dockerfile
```
FROM python:2.7
LABEL maintainer "Pierangelo Orizio <pierangelo1982@gmail.com>"

RUN apt-get update -qq && apt-get install build-essential g++ flex bison gperf ruby perl \
  mysql-client \ 
  libsqlite3-dev libmysqlclient-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
  postgresql-client \
  libpng-dev libjpeg-dev python libx11-dev libxext-dev -y
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
COPY . /code
RUN pip install -r requirements.txt
#ADD . /code/
RUN django-admin.py startproject djangoproject
RUN mkdir /code/djangoproject/media && mkdir /code/djangoproject/static
VOLUME /code
WORKDIR /code/djangoproject
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

```

requirements.txt
```
Django==1.9.8
django-filer==1.2.5
django-filter==1.0.0
django-image-cropping==1.0.4
django-mptt==0.8.6

```

from terminal inside the folder, I build the local image:
```
docker build -t django .
```

tag the local image:
```
docker tag django pierangelo1982/django
```

sign in to your docker account:
```
docker login
```

push the image on your Docker Hub account:
```
docker push pierangelo1982/django
```

P.S: pierangelo1982 is my docker account username, change it with yours.



## STEP 2 - create and implement container

# pull the image:
```
docker pull pierangelo1982/django
```

For work and implement our project, we have need to share the project folders of the container on our local host.
For do that we have need to build a volume and copy the file.

create a volume:
```
docker volume create --name django-volume
```
connect the volume to the container for can copy the project folder
```
docker run --name django-test \
	-v django-volume:/code \
	-p 8000:8000 \
	-d pierangelo1982/django
```

copy project folders in your host
```
docker cp django-test:/code ~/my/local/path/myfolder
```

remove the container
```
docker rm -f django-test
```

recreate the container with the volume that point to our local folder where before we have copy the folders of the project.
```
docker run --name django-test \
	-v ~/my/local/path/myfolder:/code \
	-p 8000:8000 \
	-d pierangelo1982/django
```

# Using django and python commands:
```
docker exec django-test python manage.py
```

# how install new packages:
```
docker exec django-pierangelo pip install
```




