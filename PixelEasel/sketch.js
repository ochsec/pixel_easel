var gridSize = 10;
var boardWidth = 60;
var boardHeight = 40;
var bgColor;
var penColor;
var Grid = [];

function setup() {
  createCanvas(boardWidth * gridSize + 1, boardHeight * gridSize + 1);
  bgColor = color(225);
  penColor = color(50);
  background(bgColor);
  for (var i = 0; i < boardWidth; i++) {
    for (var j = 0; j < boardHeight; j++) {
      Grid.push(new cell(i, j, 1, 1, bgColor));
    }
  }
  console.log(Grid.length);
}

function draw() {
  for (var i = 0; i < Grid.length; i++) {
    Grid[i].update();
    Grid[i].display();
  }
}

function cell (_x, _y, _w, _h, _c) {
  this.x = _x * gridSize;
  this.y = _y * gridSize;
  this.w = _w * gridSize;
  this.h = _h * gridSize;
  this.c = _c;
  this.highlighted = color(127, 100);
  
  this.display = function () {
    stroke(penColor);
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
        console.log(this.x);
        if (mouseIsPressed && mouseButton == LEFT) {
          this.c = penColor;
        }
        else if (mouseIsPressed && mouseButton == RIGHT) {
          this.c = bgColor;
        }
      }
  }
}