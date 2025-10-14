FROM seffeng/alpine:3.22

LABEL author="zxf <seffeng@live.com>"

ENV BASE_DIR="/opt/websrv"

ENV CONFIG_DIR="${BASE_DIR}/config/mariadb"

WORKDIR /tmp
COPY    conf ./conf
COPY    docker-entrypoint.sh /usr/local/bin/

RUN apk add --update --no-cache mariadb mariadb-client &&\
 mkdir -p ${BASE_DIR}/logs ${BASE_DIR}/tmp ${CONFIG_DIR} ${BASE_DIR}/data/mariadb &&\
 rm -f /etc/my.cnf &&\
 cp -Rf /tmp/conf/* ${CONFIG_DIR} &&\
 ln -s ${CONFIG_DIR}/my.cnf /etc/my.cnf &&\
 rm -rf /var/cache/apk/* &&\
 rm -rf /tmp/*

VOLUME ["${BASE_DIR}/tmp", "${BASE_DIR}/data/mariadb", "${BASE_DIR}/logs"]

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306

CMD ["mariadbd-safe"]