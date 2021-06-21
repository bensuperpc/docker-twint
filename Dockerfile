ARG DOCKER_IMAGE=python:slim
FROM $DOCKER_IMAGE

RUN apt-get update \
   && apt-get install -y gcc g++ git lsb-release --no-install-recommends \
	&& git clone --depth=1 https://github.com/twintproject/twint.git \
	&& cd /twint \
	&& pip3 install . -r requirements.txt \
	&& rm -rf /twint \
	&& apt-get remove gcc g++ git -y \
	&& apt-get clean autoclean \
	&& apt-get autoremove --yes \
	&& rm -rf /var/lib/{apt,dpkg,cache,log}/ \
	&& twint -h

LABEL author="Bensuperpc <bensuperpc@gmail.com>"
LABEL mantainer="Bensuperpc <bensuperpc@gmail.com>"

ARG VERSION="1.0.0"
ENV VERSION=$VERSION

WORKDIR /usr/src/myapp

CMD ["twint", "-h"]

LABEL org.label-schema.schema-version="1.0" \
	  org.label-schema.build-date=$BUILD_DATE \
	  org.label-schema.name="bensuperpc/twint" \
	  org.label-schema.description="build twint compiler" \
	  org.label-schema.version=$VERSION \
	  org.label-schema.vendor="Bensuperpc" \
	  org.label-schema.url="http://bensuperpc.com/" \
	  org.label-schema.vcs-url="https://github.com/Bensuperpc/docker-twint" \
	  org.label-schema.vcs-ref=$VCS_REF \
	  org.label-schema.docker.cmd="docker build -t bensuperpc/twint -f Dockerfile ."
