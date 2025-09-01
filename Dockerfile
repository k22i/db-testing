# Bun official image
FROM oven/bun:latest AS build

WORKDIR /app

# Copy package and lock files
COPY package.json bun.lock ./

# Install dependencies
RUN bun install --production

# Copy source code
COPY src ./src
COPY tsconfig.json ./

# Build the app
RUN bun build src/index.ts --outdir ./dist --target bun

# --- Production image ---
FROM oven/bun:latest AS prod
WORKDIR /app

# Copy only necessary files
COPY --from=build /app/package.json ./
COPY --from=build /app/bun.lock ./
COPY --from=build /app/dist ./dist

# Install only production dependencies
RUN bun install --production

EXPOSE 8889
CMD ["bun", "run", "dist/index.js"]
