// Include Nodejs' net module.
const Net = require('net');
var os = require("os");

// The port number and hostname of the server.
const port = 8080;
const host = 'server';

function sendData(){
  console.log('---------------');
  // Create a new TCP client.
  const client = new Net.Socket();
  // Send a connection request to the server.
  client.connect({ port: port, host: host }), function() {
      // If there is no error, the server has accepted the request and created a new 
      // socket dedicated to us.
      console.log('TCP connection established with the server.');
  };

  client.on('connect',function() {
    // The client can now send data to the server by writing to its socket.
    client.write('Hello, server from '+ os.hostname());
  });

  // The client can also receive data from the server by reading from its socket.
  client.on('data', function(chunk) {
      console.log("Data received from the server:" + chunk.toString());
      
      // Request an end to the connection after the data has been received.
      client.end();
  });

  client.on('end', function() {
      console.log('Requested an end to the TCP connection');
  });
}

function sleep(ms) {
  return new Promise((resolve) => {
    console.log('Waiting...' + ms + ' ms');
    setTimeout(resolve, ms);
  });
}

async function run() {
  do {
    sendData();
    await sleep(3000);
  } while (true);
}

run()
