var express = require('express');
var app = express();
var server = require('http').Server(app);
var PORT = process.env.PORT || 3000;

app.use(express.static(__dirname));
server.listen(PORT);

console.log('Server started on port ' + PORT);

app.get('/', function (req, res) {
    res.sendFile(__dirname + '/index.html');
});

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
