FROM node:latest

COPY package.json ./
COPY yarn.lock ./
COPY build/ ./build/

RUN yarn install --frozen-lockfile --non-interactive --production

ENV PORT=3000
ENV ORIGIN=https://iism25.sports.iith.ac.in
ENV NODE_ENV='production'

EXPOSE 3000

CMD ["node",  "build"]

