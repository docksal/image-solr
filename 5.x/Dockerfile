FROM openjdk:8-jre-alpine

ARG SOLR_VER

ENV SOLR_HEAP="1024m" \
    SOLR_VER="${SOLR_VER}" \
    SOLR_MIRROR="http://archive.apache.org/dist/lucene/solr" \
    PATH="/opt/solr/bin:/opt/docker-solr/scripts:$PATH" \
    SOLR_DEFAULT_CONFIG_SET="search_api_solr_8.x-1.2" \
    SOLR_HOME="/opt/solr/server/solr"

USER root

COPY bin /usr/local/bin
COPY scripts /opt/docker-solr/scripts
COPY entrypoint.sh /
COPY configsets /opt/docker-solr/configsets

# Download and install solr
RUN set -xe && \
    \
    apk add --no-cache \
        bash \
        curl \
        make \
        sudo; \
    mkdir -p /opt/solr /opt/solr/server/logs /docker-entrypoint-initdb.d; \
    curl -sSL $SOLR_MIRROR/$SOLR_VER/solr-$SOLR_VER.tgz -o /tmp/solr.tgz; \
    tar -C /opt/solr --extract --file /tmp/solr.tgz --strip-components=1; \
    rm /tmp/solr.tgz; \
    rm -Rf /opt/solr/docs/; \
    addgroup -g 8983 -S solr; \
    adduser -u 8983 -S -G solr solr; \
    echo 'solr ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/solr; \
    rm -rf /opt/solr/server/solr/configsets/*; \
    mv /opt/solr/server/solr/solr.xml /opt/docker-solr/solr.xml; \
    ln -s /opt/solr/dist /opt/dist; \
    ln -s /opt/solr/contrib /opt/contrib; \
    chown -R solr:solr /opt; \
    echo 'chown -R solr:solr /opt/solr' >/usr/local/bin/init_volumes; \
    chmod +x /usr/local/bin/init_volumes; \
    rm -rf /var/cache/apk/*

USER solr

VOLUME /opt/solr/server/solr
WORKDIR /opt/solr/server/solr

EXPOSE 8983

ENTRYPOINT ["/entrypoint.sh"]
CMD ["solr-foreground"]

# Health check script
HEALTHCHECK --interval=5s --timeout=1s --retries=12 CMD ["healthcheck.sh"]
