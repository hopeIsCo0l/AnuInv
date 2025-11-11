# Frontend Dockerfile for AnuInv Sys
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM node:20-alpine AS production

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies (Next.js needs all deps including devDependencies for runtime)
RUN npm ci

# Copy built application from builder
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.ts ./
COPY --from=builder /app/tsconfig.json ./
COPY --from=builder /app/package.json ./

# Copy node_modules from builder (Next.js needs runtime dependencies)
COPY --from=builder /app/node_modules ./node_modules

# Copy entrypoint script
COPY docker-entrypoint.sh ./
RUN chmod +x docker-entrypoint.sh

# Expose port (Railway will set PORT env variable)
EXPOSE 3001

# Set environment to production
ENV NODE_ENV=production
ENV PORT=3001

# Use entrypoint script
ENTRYPOINT ["./docker-entrypoint.sh"]

