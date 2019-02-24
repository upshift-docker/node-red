# Node-RED server

Node-RED is a programming tool for wiring together hardware devices, APIs and online services in new and interesting ways.

It provides a browser-based editor that makes it easy to wire together flows using the wide range of nodes in the palette that can be deployed to its runtime in a single-click.

## Usage

Start the container:

```console
# docker run -d --name node-red \
  -v nodered_data:/data \
  -p 1880:1880 \
  upshift/node-red
```

Now you can access Node-RED at http://localhost:1880/ from your host system.

