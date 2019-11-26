FROM node:10-alpine

LABEL maintainer="docker-remove@upshift.fr"

# Environment variable holding file path for flows configuration
ENV USERDIR=/data
ENV FLOWS=flows.json
ENV NODE_PATH=/usr/src/node-red/node_modules:/data/node_modules
ENV NODE_ENV=production

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
	npm install --verbose --no-optional \
	; \
	# Add node-red user so we aren't running as root
	adduser -h /usr/src/node-red -D -H node-red \
	; \
	chown -R node-red:node-red /usr/src/node-red /data

USER node-red

VOLUME /data

EXPOSE 1880

CMD ["npm", "start"]
