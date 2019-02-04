ARG VERSION
FROM solr:${VERSION}-alpine

ARG VERSION
ARG SOLR_DEFAULT_CONFIG_SET

ENV VERSION=${VERSION}
ENV SOLR_DEFAULT_CONFIG_SET=${SOLR_DEFAULT_CONFIG_SET}
ENV SOLR_HEAP="1024m"
ENV SOLR_HOME="/opt/solr/server/solr"

USER root
COPY configsets /opt/docker-solr/configsets
COPY scripts/healthcheck.sh /opt/docker-solr/scripts/healthcheck.sh
COPY scripts/docksal-preinit /opt/docker-solr/scripts/docksal-preinit
RUN \
  ln -s /opt/solr/dist /opt/dist; \
  ln -s /opt/solr/contrib /opt/contrib; \
  sed -i '/exec "$@"/i . docksal-preinit' /opt/docker-solr/scripts/docker-entrypoint.sh; \
  chown -R solr:solr /opt/docker-solr

USER solr

VOLUME /opt/solr/server/solr
WORKDIR /opt/solr/server/solr

# Health check script
HEALTHCHECK --interval=5s --timeout=1s --retries=12 CMD ["healthcheck.sh"]

