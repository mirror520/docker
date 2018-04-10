FROM alpine

RUN apk add --update \
    nodejs \
    yarn \
    git

RUN npm install -g @angular/cli

RUN mkdir /app
WORKDIR /app

EXPOSE 4200

CMD ng serve --host 0.0.0.0 --public-host www.linyc.idv.tw:4200
