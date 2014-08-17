/* @pjs preload="pencil.png"; */

int grid_size = 8;
int board_w = 80;
int board_h = 60;
color bg = color(255, 255, 255);
color pen = color(225);
ArrayList<Grid> squares;
Palette p = new Palette(board_w * grid_size + 15, 15, 90, 180, true);
Swatch swatch = new Swatch(board_w * grid_size + 15, 448, 32, 32);
PImage pencil;

void setup() 
{
  frameRate(60);
  size(board_w * grid_size + 120, board_h * grid_size + 40);
  background(bg);
  fill(bg);
  pencil = loadImage("pencil.png");
  rect(grid_size * 2 - 1, grid_size * 2 - 1, board_w * grid_size -  grid_size * 2 + 2, board_h * grid_size -  grid_size * 2 + 2);
  squares = new ArrayList<Grid>();  // Create an empty ArrayList
  for (int i = 2; i < board_w; i++)
  {
    for (int j = 2; j < board_h; j++)
    {
      squares.add(new Grid(i, j, 1, 1, pen));
    }
  }
  squares.add(new Grid(80, 60, 1, 1, pen));
  p.display();
  swatch.display();
}

void draw()
{
  for (int j = 0; j < squares.size() - 1; j++)
  {
    Grid square = squares.get(j);
    square.update(pen);
  } 
  p.display();
  swatch.display();
}


void mouseClicked() {
  p.rollover(mouseX, mouseY);
  if(p.over == true)
  {
    pen = get(mouseX, mouseY);
    swatch.c = pen;
  }
}

void keyPressed()
{
  println(keyCode);  
  if (keyCode == 83)
  {
    save("output.png");
  }
}
class Grid {
  
  int x, y, w, h;
  color c;
  boolean active;
  
  Grid(int _x, int _y, int _w, int _h, color _c) 
  {
    x = _x * grid_size;
    y = _y * grid_size;
    w = _w * grid_size;
    h = _h * grid_size;
    c = _c;
  }
  
  void display()
  {
    if (active == true)
    {
      stroke(c);
      fill(c);
    }
    else
    {
      stroke(c);
      fill(bg);
    }
    rect(x, y, w, h);
  }

  void update(color _c)
  {
    c = _c;
    if ( ( (mouseX >= x) && (mouseX < x + w) ) 
    && ( (mouseY >= y) && (mouseY < y + h) ) )
    {
      if (mousePressed && (mouseButton == LEFT))
      {
        active = true;
        stroke(c);
        fill(c);
        rect(x, y, w, h);
      } 
      else if (mousePressed && (mouseButton == RIGHT))
      {
        active = false;
        stroke(c);
        fill(bg);
        rect(x, y, w, h);        
      }
    }
  }
}
class Palette {
  int x, y, w, h, alpha, beta, offX, offY;
  boolean visible, dragging, over;
 
  Palette(int _x, int _y, int _w, int _h, boolean _v)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    alpha = 255;
    beta = 0;
    visible = _v;
    offX = 0;
    offY = 0;
    dragging = false;
    over = false;
  }
  
  // Method to display
  void display() {
    int h = 2;
    stroke(0);
    //if (dragging) fill (50);
    //else if (rollover) fill(100);
    //if (rollover) fill(100);
    //else fill(200);
    fill(255, 0, 0);
    rect(x, y, grid_size, grid_size * 2);
    for (int red = 224; red > 31; red -= 32)
    {
      fill(red, 0, 0);
      rect(x, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;
    }
    h = 2;
    fill(0, 224, 0);
    rect(x + grid_size, y, grid_size, grid_size * 2);
    for (int green = 224; green > 31; green -= 32)
    {
      fill(0, green, 0);
      rect(x + grid_size, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;
    }
    h = 2;
    fill(0, 0, 255);
    rect(x + grid_size * 2, y, grid_size, grid_size * 2);
    for (int blue = 224; blue > 31; blue -= 32)
    {
      fill(0, 0, blue);
      rect(x + grid_size * 2, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;
    }
    h = 2;
    fill(255);
    rect(x + grid_size * 3, y, grid_size, grid_size * 2);
    for (int grey = 224; grey > 31; grey -= 32)
    {
      fill(grey);
      rect(x + grid_size * 3, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;
    }
    h = 2;
    fill(255, 255, 0);
    rect(x + grid_size * 4, y, grid_size, grid_size * 2);
    for (int yellow = 224; yellow > 31; yellow -= 32)
    {
      fill(yellow, yellow, 0);
      rect(x + grid_size * 4, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;  
    }
    h = 2;
    fill(255, 0, 255);
    rect(x + grid_size * 5, y, grid_size, grid_size * 2);
    for (int purple = 224; purple > 31; purple -= 32)
    {
      fill(purple, 0, purple);
      rect(x + grid_size * 5, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;  
    }    
    h = 2;
    fill(0, 255, 255);
    rect(x + grid_size * 6, y, grid_size, grid_size * 2);
    for (int cyan = 224; cyan > 31; cyan -= 32)
    {
      fill(0, cyan, cyan);
      rect(x + grid_size * 6, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;  
    }    
    h = 2;
    fill(255, 255, 128);
    rect(x + grid_size * 7, y, grid_size, grid_size * 2);
    for (int yellow = 224; yellow > 31; yellow -= 32)
    {
      fill(yellow, yellow, 128);
      rect(x + grid_size * 7, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;  
    }    
    h = 2;
    fill(255, 125, 255);
    rect(x + grid_size * 8, y, grid_size, grid_size * 2);
    for (int purple = 224; purple > 31; purple -= 32)
    {
      fill(purple, 128, purple);
      rect(x + grid_size * 8, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;  
    }        
    h = 2;
    fill(128, 255, 255);
    rect(x + grid_size * 8, y, grid_size, grid_size * 2);
    for (int cyan = 224; cyan > 31; cyan -= 32)
    {
      fill(128, cyan, cyan);
      rect(x + grid_size * 8, y + h * grid_size, grid_size, grid_size * 2);
      h += 2;  
    }    
  }

  // Is a point inside the rectangle (for click)?
  void clicked(int mx, int my) {
    if (mx > x && mx < x + w && my > y && my < y + h) {
      dragging = true;
      // If so, keep track of relative location of click to corner of rectangle
      offX = x-mx;
      offY = y-my;
    }
  }
  
  void getColor()
  {
    pen = get(mouseX, mouseY);  
  }
  
  // Is a point inside the rectangle (for rollover)
  void rollover(int mx, int my) {
    if (mx > x && mx < x + w && my > y && my < y + h) {
      over = true;
    } else {
      over = false;
    }
  }

  // Stop dragging
  void stopDragging() {
    dragging = false;
  }
  
  // Drag the rectangle
  void drag(int mx, int my) {
    if (dragging) {
      x = mx + offX;
      y = my + offY;
    }
  }
}
class Swatch {
  int x, y, w, h;
  color c, p;
  
  Swatch(int _x, int _y, int _w, int _h) 
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = color(225);
    p = color(255, 0, 0);
  }
  
  void display()
  {
    image(pencil, x, y - 48, 32,  32);
    stroke(255);
    fill(c);  
    rect(x, y, w, h);
  }
}

