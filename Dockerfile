FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Port 7860 is required by Hugging Face Spaces
ENV N8N_PORT=7860
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV NODE_ENV=production

# HF handles SSL at proxy level — n8n itself runs on plain HTTP internally
# N8N_PROTOCOL=https would cause redirect loops, so we leave it as http
ENV N8N_PROTOCOL=http

# Disable secure cookie so login works behind HF's proxy
ENV N8N_SECURE_COOKIE=false

# Skip the first-time setup wizard so n8n starts directly
ENV N8N_USER_MANAGEMENT_DISABLED=true

# Supabase Postgres — actual values are injected via HF Secrets at runtime
ENV DB_TYPE=postgresdb

# Allow n8n to write to its home directory in Hugging Face
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

USER node
EXPOSE 7860

CMD ["n8n", "start"]
