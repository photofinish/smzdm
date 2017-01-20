FROM daocloud.io/rails:5.0.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 3000

ADD . /usr/src/app