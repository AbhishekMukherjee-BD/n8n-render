FROM n8nio/n8n:latest

USER root

# Port 10000 is default for Render
ENV N8N_PORT=10000
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV NODE_ENV=production

# Render handles SSL at proxy level — n8n itself runs on plain HTTP internally
# N8N_PROTOCOL=https would cause redirect loops, so we leave it as http
ENV N8N_PROTOCOL=http

# Disable secure cookie so login works behind Render's proxy
ENV N8N_SECURE_COOKIE=false

# Skip the first-time setup wizard so n8n starts directly
ENV N8N_USER_MANAGEMENT_DISABLED=true

# Supabase Postgres — actual values are injected via Render Env Vars at runtime
ENV DB_TYPE=postgresdb

# Allow n8n to write to its home directory
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

USER node
EXPOSE 10000

CMD ["n8n", "start"]
