FROM python:3.7-alpine
MAINTAINER Viresh Kumar

ENV PYTHONUNBUFFERED 1

# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .temp-build-deps gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .temp-build-deps

# Setup directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app

RUN adduser -D user
USER user