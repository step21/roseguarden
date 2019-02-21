FROM debian:stretch

LABEL maintainer="step21 <step21@devtal.de>"
ENV LANG C.UTF-8

RUN mkdir /web;mkdir /web/roseguarden
WORKDIR /web/roseguarden

RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y python apache2 libapache2-mod-wsgi python-pip python-setuptools python-wheel sqlite3 libffi-dev libjpeg-dev libpython-dev curl zlib1g-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./server /web/roseguarden

RUN pip install -r /web/roseguarden/requirements.txt

# Apache conf
RUN a2enmod wsgi rewrite

COPY roseguarden-wsgi.conf /etc/apache2/sites-available/

RUN a2ensite roseguarden-wsgi

#RUN curl --output /web/roseguarden/poerelief/teidb_dev.sqlite https://chaostal.de/~step21/teidb_dev.sqlite

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND", "-e", "info"]
