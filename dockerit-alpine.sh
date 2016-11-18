#!/bin/sh -ex

# add all our dependencies
apk update

apk add python py-pip make python-dev jpeg-dev graphviz build-base zlib-dev

LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pip install --no-cache-dir -r /projects/project/requirements.txt"

# build the content and put it where nginx expects
make html

mv build/html/* /usr/share/nginx/html/

make clean

# remove unnecessary dependencies
pip freeze | xargs pip uninstall -y

apk --purge del -r py-pip make python

rm -rf /var/cache/apk/*
