FROM nginx
# Copy website files
COPY public/ /usr/share/nginx/html/
# Copy main nginx config without env var substitutions
COPY config/nginx.conf /etc/nginx/nginx.conf
# Copy multiple nginx configs with env var substitutions
COPY config/templates/ /etc/nginx/templates/

# Load ENV vars within container
## Copy the .env file into the container
COPY .env /tmp/.env
## Read the .env file and set environment variables
RUN while read -r line; do \
  if [[ $line =~ ^[a-zA-Z_][a-zA-Z0-9_]*=.* ]]; then \
    export "$line"; \
  fi; \
done < /tmp/.env && env | grep -E '^[a-zA-Z_][a-zA-Z0-9_]*=.*$' | xargs -I {} sh -c 'echo ENV {} >> /etc/environment'
## Clean up the temporary .env file
RUN rm /tmp/.env

# Start nginx server with daemon off so that it runs on main process and container does not stop
CMD ["nginx", "-g", "daemon off;"]