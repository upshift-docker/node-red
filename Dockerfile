FROM node:8-alpine

LABEL maintainer="docker@upshift.fr"

ENV NODE_PATH=/usr/src/node-red/node_modules:/data/node_modules

RUN set -eux; \
	# Home directory for application source code
	mkdir -p /usr/src/node-red \
	; \
	# User data directory, contains flows, config and nodes
	mkdir /data

WORKDIR /usr/src/node-red

COPY src/package.json /usr/src/node-red/

RUN set -eux; \
	# install needed packages
	apk add --no-cache \
		iputils \
	; \
	apk add --no-cache --virtual .build-deps \
		python \
		make \
		g++ \
	; \
	npm install \
	; \
	apk del .build-deps \
	; \
	# Add node-red user so we aren't running as root
	adduser -h /usr/src/node-red -D -H node-red \
	; \
	chown -R node-red:node-red /usr/src/node-red /data

USER node-red

VOLUME /data

EXPOSE 1880

CMD ["npm", "start"]
