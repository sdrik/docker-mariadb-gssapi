FROM library/mariadb

RUN \
	sed -i -e '/invoke restart/d' /var/lib/dpkg/info/mariadb-server-*.postinst && \
	apt-get update && apt-get install -y \
		mariadb-plugin-gssapi-server \
		mariadb-plugin-gssapi-client \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint-gssapi.sh /usr/local/bin/

ENTRYPOINT [ "docker-entrypoint-gssapi.sh" ]
CMD [ "mysqld" ]
