FROM cloudforet/python-core:1.12
ARG PACKAGE_VERSION
ENV PYTHONUNBUFFERED 1
ENV SPACEONE_PORT 50051
ENV SRC_DIR /tmp/src
ENV CONF_DIR /etc/spaceone
ENV LOG_DIR /var/log/spaceone
ENV PACKAGE_VERSION=$PACKAGE_VERSION

COPY pkg/pip_requirements.txt pip_requirements.txt

RUN pip install --upgrade -r pip_requirements.txt

COPY src ${SRC_DIR}
WORKDIR ${SRC_DIR}

RUN python3 setup.py install && rm -rf /tmp/*

RUN pip install --upgrade spaceone-api

EXPOSE ${SPACEONE_PORT}

ENTRYPOINT ["spaceone"]
CMD ["grpc", "spaceone.console_api_v2", "-m", "/opt"]
