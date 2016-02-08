var http = require('http');
var url = require('url');
var path = require('path');
var fs = require('fs');

var server = http.createServer(handleRequest);
server.listen(8080);

console.log('Server started on port 8080');

function handleRequest(req, res) {
  var pathname = req.url;
  
  if (pathname == '/') {
    pathname = '/index.html';
  }
  
  var ext = path.extname(pathname);

  var typeExt = {
    '.html': 'text/html',
    '.js':   'text/javascript',
    '.css':  'text/css'
  };

  var contentType = typeExt[ext] || 'text/plain';

  fs.readFile(__dirname + pathname,
    function (err, data) {
      if (err) {
        res.writeHead(500);
        return res.end('Error loading ' + pathname);
      }
      res.writeHead(200,{ 'Content-Type': contentType });
      res.end(data);
    }
  );
}

var io = require('socket.io').listen(server);
io.sockets.on('connection', function (socket) {
   socket.on('mouse', function (data) {
     console.log("Received x: " + data.x + ", y: " + data.y + ", red: " + data.r +
        ", blue: " + data.b + ", green: " + data.g + ", alpha: " + data.a);
     socket.broadcast.emit('mouse', data); 
   });
   
   socket.on('disconnect', function () {
       console.log("Client has disconnected");
   })
});