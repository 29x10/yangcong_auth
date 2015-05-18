FROM python:2.7.9


RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


COPY . /usr/src/app/
RUN python bootstrap.py
RUN bin/buildout


CMD ["bin/gunicorn", "--paste", "production.ini"]