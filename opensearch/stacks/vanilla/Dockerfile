FROM opensearchproject/opensearch as base
#COPY ./config.yml /usr/share/opensearch/config/opensearch.yml

# Vulnerability Scan
FROM base as vulnerabilityscan
ARG TRIVY_FAIL=0
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy /usr/local/bin/trivy
RUN [[ $TRIVY_FAIL == 0 ]] || trivy filesystem --no-progress --severity CRITICAL --ignore-unfixed --skip-dirs app/public/web/app/plugins/wp-graphql --skip-dirs app/public/web/app/plugins/google-address-autocomplete / 
RUN echo scancompleted > /scancompleted

FROM base