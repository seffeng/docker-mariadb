#!/bin/sh

init_database_dir() {
    if [ ! -d ${BASE_DIR}/data/mariadb/mysql ]; then
        mkdir -p ${BASE_DIR}/data/mariadb
        chown -R mysql:mysql ${BASE_DIR}/data/mariadb ${BASE_DIR}/logs ${BASE_DIR}/tmp
        mariadb-install-db --user=mysql --datadir=${BASE_DIR}/data/mariadb --skip-test-db
    fi
}

init_database_dir

exec "$@"