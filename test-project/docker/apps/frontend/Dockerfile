# Dockerfile para Frontend React Application
# Multi-stage build para optimizar tamaño

# =============================================================================
# Stage 1: Build
# =============================================================================
FROM node:18-alpine AS builder

LABEL maintainer="devops@company.com" \
      description="Frontend build stage"

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production && \
    npm cache clean --force

# Copy source code
COPY . .

# Build argument for environment
ARG BUILD_ENV=production
ARG API_URL=https://api.example.com

ENV REACT_APP_ENV=${BUILD_ENV}
ENV REACT_APP_API_URL=${API_URL}

# Build application
RUN npm run build

# =============================================================================
# Stage 2: Production
# =============================================================================
FROM nginx:alpine

LABEL maintainer="devops@company.com" \
      description="Frontend production runtime" \
      version="1.0.0"

# Copy built assets from builder
COPY --from=builder /app/build /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 101 -S nginx && \
    adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx && \
    chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chmod -R 755 /usr/share/nginx/html

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1

# Switch to non-root user
USER nginx

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
