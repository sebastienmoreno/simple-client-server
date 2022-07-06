# simple-client-server
Simple Client Server example in NodeJS

- A server listening port 8080, print data if available, send data to client.
- A client calling server on port 8080, print data of the server and pushing data to the server.

Available at: https://hub.docker.com/u/smoreno

## Build / Push

To just build the images:
```sh
make build
```

To push fresh images:
```sh
make clean push
```

## Test locally

Run `make` will build and run 2 docker containers to test the connectivity.