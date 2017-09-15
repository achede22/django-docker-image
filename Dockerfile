#docker run --name django-pierangelo \
#	-v ~/my/local/path/myfolder:/code \
#	-p 8000:8000 \
#	-d pierangelo1982/django



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


