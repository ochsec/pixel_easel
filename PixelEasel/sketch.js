var gridSize = 8;
var boardWidth = 80;
var boardHeight = 40;
var bgColor;
var penColor;
var Grid = [];

function setup() {
  createCanvas(boardWidth * gridSize, boardHeight * gridSize);
  bgColor = color(0);
  penColor = color(255);
  background(bgColor);
  for (var i = 0; i < boardWidth; i++) {
    for (var j = 0; j < boardHeight; j++) {
      Grid.push(new cell(i, j, 1, 1, penColor));
    }
  }
  console.log(Grid.length);
}

function draw() {
  for (var i = 0; i < Grid.length; i++) {
    Grid[i].display();
    //console.log(Grid[i].x);
  }
}

function cell (_x, _y, _w, _h, _c) {
  this.x = _x * gridSize;
  this.y = _y * gridSize;
  this.w = _w * gridSize;
  this.h = _h * gridSize;
  this.c = _c;
  
  this.display = function () {
    stroke(bgColor);
    fill(this.c);
    rect(this.x, this.y, this.w, this.h);
  };
}