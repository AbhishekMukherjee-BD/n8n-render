FROM n8nio/n8n:latest

USER root

# Render requires port 10000
ENV N8N_PORT=10000
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV NODE_ENV=production
ENV N8N_PROTOCOL=http
ENV N8N_SECURE_COOKIE=false
ENV N8N_USER_MANAGEMENT_DISABLED=true
ENV DB_TYPE=postgresdb

# Allow n8n to write to its home directory
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

USER node
