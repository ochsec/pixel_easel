var http = require('http');
var url = require('url');
var path = require('path');
var fs = require('fs');
var PORT = require('port.js');
var server = process.env.PORT || 3000;
server.listen(PORT);

console.log('Server started on port +' + PORT);

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

   socket.on('background', function (data) {
    console.log("Received r: " + data.r + ", g: " + data.g + ", b: " + data.b + ", alpha: " + data.a);
    socket.broadcast.emit('background', data);
   });

   socket.on('clear', function (data) {
    console.log("Received r: " + data.r + ", g: " + data.g + ", b: " + data.b + ", alpha: " + data.a);
    socket.broadcast.emit('clear', data);
   });

   socket.on('disconnect', function () {
       console.log("Client has disconnected");
   });
});
