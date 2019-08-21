#!/bin/bash

GSSAPI_KEYTAB="${GSSAPI_KEYTAB:-/etc/mysql/gssapi.keytab}"

if [ -f "${GSSAPI_KEYTAB}" -a -n "${GSSAPI_PRINCIPAL}" ]
then
	chown mysql:root ${GSSAPI_KEYTAB}
	chmod 600 ${GSSAPI_KEYTAB}
	cat > /etc/mysql/mariadb.conf.d/auth_gssapi.cnf <<-EOF
[mariadb]
plugin-load-add=auth_gssapi.so
gssapi-keytab-path = ${GSSAPI_KEYTAB}
gssapi-principal-name = ${GSSAPI_PRINCIPAL}
	EOF
else
	rm -f /etc/mysql/mariadb.conf.d/auth_gssapi.cnf
fi

exec "/docker-entrypoint.sh" "$@"
