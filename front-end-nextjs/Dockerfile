# Use a multi-stage build to separate build and runtime environments
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy only package.json and lock files to leverage caching
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./

# Install dependencies based on the lock file
RUN \
  if [ -f yarn.lock ]; then \
    yarn install --frozen-lockfile; \
  elif [ -f package-lock.json ]; then \
    npm ci; \
  elif [ -f pnpm-lock.yaml ]; then \
    corepack enable pnpm && pnpm i --frozen-lockfile; \
  else \
    echo "No lock file found"; \
    exit 1; \
  fi

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]