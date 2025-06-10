FROM node:latest

RUN npm i -g pnpm

COPY package.json ./
COPY pnpm-lock.yaml ./
COPY build/ ./build/

RUN pnpm install --frozen-lockfile --prod

ENV PORT=3000
ENV ORIGIN=https://iism25.sports.iith.ac.in
ENV BODY_SIZE_LIMIT=6M

EXPOSE 3000

CMD ["node",  "build"]


