FROM grafana/grafana:latest as base
ARG STACK_ENV=dev
COPY configs/grafana.ini /etc/grafana/grafana.ini
COPY plugins/ /var/lib/grafana/plugins/



# Vulnerability scan of final image
FROM base AS vulnerabilityscan
ARG TRIVY_FAIL=0
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy /usr/local/bin/trivy
RUN [[ $TRIVY_FAIL == 0 ]] || trivy filesystem --no-progress --severity CRITICAL --ignore-unfixed /
RUN echo scancompleted > /scancompleted

FROM base