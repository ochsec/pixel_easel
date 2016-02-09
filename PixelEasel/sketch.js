var socket;

var gridSize = 10;
var boardWidth = 60;
var boardHeight = 30;
var bgColor;
var penColor;
var Grid = [];
var Swatches = [];
var cBtn;
var colors;

function setup() {
  createCanvas(boardWidth * gridSize + 1, (boardHeight + 5) * gridSize + 1);
  colors = {
    "setOne": {
      bg: color('#2e4272'),
      pen: color('#2bcc2b')
    },
    "setTwo": {
      bg: color('#c6f333'),
      pen: color('#fff436')
    },
    "setThree": {
      bg: color(225),
      pen: color(50)
    },
    "setFour": {
      bg: color(255),
      pen: color('#ff5536')
    },
    "setFive": {
      bg: color('#7d2baa'),
      pen: color('#cd2b86')
    }
  };  
  bgColor = color('white');
  penColor = colors.setTwo.pen;
  background(bgColor);
  for (var i = 0; i < boardWidth; i++) {
    for (var j = 0; j < boardHeight; j++) {
      Grid.push(new cell(i, j, 1, 1, bgColor));
    }
  }
  var spacing = 0;
  for (var c in colors) {
    Swatches.push(new swatch(spacing, 300, 100, 50, colors[c].bg, colors[c].pen));  
    spacing += 100;
  }
  cBtn = new clearBtn(500, 300, 100, 50);
  for (var i = 0; i < Grid.length; i++) {
    Grid[i].update();
    Grid[i].display();
  }  
  socket = io.connect('http://localhost:8080');
  socket.on('mouse', function (data) {
    for (var i = 0; i < Grid.length; i++) {
      Grid[i].updateFromServer(data.x, data.y, data.r, data.g, data.b, data.a);
    }
  });
  socket.on('background', function (data) {
    bgColor = color(data.r, data.g, data.b, data.a);
    for (var i = 0; i < Grid.length; i++) {
      //Grid[i].updateBackground(data.r, data.g, data.b, data.a);
      if (!Grid[i].changed) {
        Grid[i].c = bgColor;              
      }       
    }
  });
  socket.on('clear', function (data) {
    bgColor = color(data.r, data.g, data.b, data.a);
    for (var i = 0; i < Grid.length; i++) {
      Grid[i].c = bgColor;
      Grid[i].changed = false;
    }
  });
}

function draw() {
  for (var i = 0; i < Grid.length; i++) {
    Grid[i].update();
    Grid[i].display();
  }
  for (var j = 0; j < Swatches.length; j++) {
    Swatches[j].update();
    Swatches[j].display();
  } 
  cBtn.update();
  cBtn.display();
}

function cell (_x, _y, _w, _h, _c) {
  this.x = _x * gridSize;
  this.y = _y * gridSize;
  this.w = _w * gridSize;
  this.h = _h * gridSize;
  this.c = _c;
  this.highlighted = color(127, 100);
  this.changed = false;
  
  this.display = function () {
    stroke(0);
    if ( ( (mouseX > this.x) && (mouseX < this.x + this.w) ) && ( (mouseY > this.y) && (mouseY < this.y + this.h) ) ) {
      fill(this.highlighted);
    }
    else {
      fill(this.c);
    }
    rect(this.x, this.y, this.w, this.h);
  };
  
  this.update = function () {
      if ( ( (mouseX > this.x) && (mouseX < this.x + this.w) ) && ( (mouseY > this.y) && (mouseY < this.y + this.h) ) ) {
        if (mouseIsPressed && mouseButton == LEFT) {
          this.c = penColor;
          this.changed = true;
          var data = {
            x: mouseX,
            y: mouseY,
            r: red(penColor),
            g: green(penColor),            
            b: blue(penColor),            
            a: alpha(penColor)
          };
          socket.emit('mouse', data);
        }
      }
  };
  
  this.updateFromServer = function (_x, _y, _r, _g, _b, _a) {
    if ( ( (_x > this.x) && (_x < this.x + this.w) ) && ( (_y > this.y) && (_y < this.y + this.h) ) ) {
      this.c = color(_r, _g, _b, _a); 
      this.changed = true;      
      stroke(0);
      fill(this.c);
      rect(this.x, this.y, this.w, this.h);
    }
  };
}

function swatch (_x, _y, _w, _h, _bg, _pen) {
  this.x= _x;
  this.y = _y;
  this.w = _w;
  this.h = _h;
  this.bg = _bg;
  this.pen = _pen;
  
  this.display = function () {
    stroke(0);
    fill(this.bg);
    rect(this.x, this.y, this.w, this.h);
    fill(this.pen);
    rect(this.x + 40, this.y + 10, this.w - 80, this.h - 20);
  };
  
  this.update = function () {
    if ( ( (mouseX > this.x) && (mouseX < this.x + this.w) ) && ( (mouseY > this.y) && (mouseY < this.y + this.h) ) ) {
      if (mouseIsPressed && mouseButton == LEFT) {
        bgColor = this.bg;
        penColor = this.pen;
        var data = {
          r: red(bgColor),
          g: green(bgColor),            
          b: blue(bgColor),            
          a: alpha(bgColor)          
        };
        socket.emit('background', data);
      }
      else if (mouseIsPressed && mouseButton == RIGHT) {
        bgColor = this.pen;
        penColor = this.bg;
        var data = {
          r: red(bgColor),
          g: green(bgColor),            
          b: blue(bgColor),            
          a: alpha(bgColor)          
        };
        socket.emit('background', data);        
      }
      for (var i = 0; i < Grid.length; i++) {
        if (!Grid[i].changed) {
          Grid[i].c = bgColor;
        }        
      }  
    }
  };
}

function clearBtn (_x, _y, _w, _h) {
  this.x= _x;
  this.y = _y;
  this.w = _w;
  this.h = _h;
  
  this.display = function () {
    stroke(50);
    fill(255);
    rect(this.x, this.y, this.w, this.h);
    textSize(36);
    strokeWeight(2);
    text("clear", this.x + 10, this.y + this.h / 2 + 10);
    strokeWeight(1);
  };
  
  this.update = function () {
    if ( ( (mouseX > this.x) && (mouseX < this.x + this.w) ) && ( (mouseY > this.y) && (mouseY < this.y + this.h) ) ) {
      if (mouseIsPressed && mouseButton == LEFT) {
        for (var i = 0; i < Grid.length; i++) {
          Grid[i].c = bgColor;
          Grid[i].changed = false;
        }
        var data = {
          r: red(bgColor),
          g: green(bgColor),
          b: blue(bgColor),
          a: alpha(bgColor)
        };
        socket.emit('clear', data);
      }
    }
  };
}

function mouseDragged() {
  for (var i = 0; i < Grid.length; i++) {
    Grid[i].update();
  }  
}

function mouseClicked() {
  for (var i = 0; i < Swatches.length; i++) {
    Swatches[i].update();
  }
}