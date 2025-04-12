FROM node:23-bookworm-slim AS base

RUN npm install -g npm@latest
RUN apt-get update && apt-get install -y bash

WORKDIR /usr/app
COPY ./package.json \
     ./package-lock.json \
     ./next.config.mjs \
     ./tsconfig.json \
     ./reset.d.ts \
     ./tailwind.config.js \
     ./postcss.config.js ./
COPY ./scripts ./scripts
COPY ./prisma ./prisma

RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/* && \
    npm ci --ignore-scripts && \
    npx prisma generate

COPY ./src ./src

COPY ./messages ./messages

ENV NEXT_TELEMETRY_DISABLED=1

COPY scripts/build.env .env
RUN npm run build

RUN rm -r .next/cache

FROM node:23-bookworm-slim AS runtime-deps

RUN npm install -g npm@latest
RUN apt-get update && apt-get install -y bash

WORKDIR /usr/app
COPY --from=base /usr/app/package.json /usr/app/package-lock.json /usr/app/next.config.mjs ./
COPY --from=base /usr/app/prisma ./prisma

RUN npm ci --omit=dev --omit=optional --ignore-scripts && \
    npx prisma generate

FROM node:23-bookworm-slim AS runner

RUN npm install -g npm@latest
RUN apt-get update && apt-get install -y bash

EXPOSE 3000/tcp
WORKDIR /usr/app

COPY --from=base /usr/app/package.json /usr/app/package-lock.json /usr/app/next.config.mjs ./
COPY --from=runtime-deps /usr/app/node_modules ./node_modules
COPY ./public ./public
COPY ./scripts ./scripts
COPY --from=base /usr/app/prisma ./prisma
COPY --from=base /usr/app/.next ./.next

RUN chmod +x /usr/app/scripts/container-entrypoint.sh

ENTRYPOINT ["/bin/sh", "/usr/app/scripts/container-entrypoint.sh"]
