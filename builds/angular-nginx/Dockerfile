FROM nginx:alpine

RUN apk add --update \
    nodejs \
    yarn \
    git

RUN npm install --unsafe-perm -g @angular/cli

RUN mkdir /app
WORKDIR /app

EXPOSE 4200
