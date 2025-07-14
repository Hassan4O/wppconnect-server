FROM node:22.17.0-alpine

WORKDIR /app

ENV NODE_ENV=production \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

RUN apk update && apk add --no-cache \
    vips-dev \
    fftw-dev \
    gcc \
    g++ \
    make \
    libc6-compat \
    chromium

COPY package.json yarn.lock ./
RUN yarn install --production=false --pure-lockfile && yarn add sharp --ignore-engines

COPY . .
RUN yarn build

EXPOSE 21465

CMD ["node", "dist/server.js"]
