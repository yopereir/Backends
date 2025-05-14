FROM metabase/metabase:v0.53.15 as base

# Vulnerability scan of final image
FROM base AS vulnerabilityscan
ARG TRIVY_FAIL=0
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy /usr/local/bin/trivy
RUN [[ $TRIVY_FAIL == 0 ]] || trivy filesystem --no-progress --severity CRITICAL --ignore-unfixed /
RUN echo scancompleted > /scancompleted

FROM base