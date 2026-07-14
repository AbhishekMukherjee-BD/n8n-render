FROM n8nio/n8n:latest

USER root

# Render requires port 10000
ENV N8N_PORT=10000
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV NODE_ENV=production

# Limit Node.js heap to fit within Render's 512MB free tier RAM
ENV NODE_OPTIONS="--max-old-space-size=400"

# Reduce memory footprint by disabling non-essential features
ENV EXECUTIONS_DATA_SAVE_ON_ERROR=none
ENV EXECUTIONS_DATA_SAVE_ON_SUCCESS=none
ENV EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=false
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false

# Disable task runner — Render free tier only allows one process
ENV N8N_RUNNERS_ENABLED=false
ENV EXECUTIONS_PROCESS=main
ENV N8N_PROTOCOL=http
ENV N8N_SECURE_COOKIE=false
ENV N8N_USER_MANAGEMENT_DISABLED=true
ENV DB_TYPE=postgresdb

# Allow n8n to write to its home directory
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

USER node
