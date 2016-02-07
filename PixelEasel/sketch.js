var gridSize = 10;
var boardWidth = 60;
var boardHeight = 30;
var bgColor;
var penColor;
var Grid = [];
var Swatches = [];
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
    Swatches.push(new swatch(spacing, 300, 120, 50, colors[c].bg, colors[c].pen));  
    spacing += 120;
  }
  
  //Swatches.push(new swatch(0, 300, 120, 50, colors.setOne.bg, colors.setOne.pen));
  //Swatches.push(new swatch(120, 300, 120, 50, colors.setTwo.bg, colors.setTwo.pen));
  console.log(Grid.length);
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
        }
        else if (mouseIsPressed && mouseButton == RIGHT) {
          this.c = bgColor;
          this.changed= true;
       
        }

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
    rect(this.x + 10, this.y + 10, this.w - 20, this.h - 20);
  };
  
  this.update = function () {
    if ( ( (mouseX > this.x) && (mouseX < this.x + this.w) ) && ( (mouseY > this.y) && (mouseY < this.y + this.h) ) ) {
      if (mouseIsPressed && mouseButton == LEFT) {
        bgColor = this.bg;
        penColor = this.pen;
        console.log(penColor);
        for (var i = 0; i < Grid.length; i++) {
          if (Grid[i].changed === false) {
            Grid[i].c = bgColor;
          }
        }
      }
      else if (mouseIsPressed && mouseButton == RIGHT) {
        bgColor = this.pen;
        penColor = this.bg;
      }        
    }
  };
}
