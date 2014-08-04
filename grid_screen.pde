int grid_size = 8;
int board_w = 80;
int board_h = 60;
color bg = color(68, 68, 68);
color pen = color(225);
ArrayList<Grid> squares;
Palette p = new Palette(board_w * grid_size + 15, 15, 90, 180, true);

void setup() 
{
  frameRate(60);
  size(board_w * grid_size + 120, board_h * grid_size + 40);
  background(bg);
  fill(bg);
  rect(grid_size * 2 - 1, grid_size * 2 - 1, board_w * grid_size -  grid_size * 2 + 2, board_h * grid_size -  grid_size * 2 + 2);
  squares = new ArrayList<Grid>();  // Create an empty ArrayList
  for (int i = 2; i < board_w; i++)
  {
    for (int j = 2; j < board_h; j++)
    {
      squares.add(new Grid(i, j, 1, 1, pen));
    }
  }
  p.display();
}

void draw()
{
  for (int j = 0; j < squares.size() - 1; j++)
  {
    Grid square = squares.get(j);
    square.update(pen);
  } 
  p.display();
}


void mouseClicked() {
  p.rollover(mouseX, mouseY);
  if(p.over == true)
  {
    pen = get(mouseX, mouseY);
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
  int x, y, w, h, offX, offY;
  boolean visible, dragging, over;
 
  Palette(int _x, int _y, int _w, int _h, boolean _v)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    visible = _v;
    offX = 0;
    offY = 0;
    dragging = false;
    over = false;
  }
  
  // Method to display
  void display() {
    stroke(0);
    //if (dragging) fill (50);
    //else if (rollover) fill(100);
    //if (rollover) fill(100);
    //else fill(200);
    fill(255, 0, 0);
    rect(x, y, grid_size * 2, grid_size * 2);
    fill(0, 255, 0);
    rect(x + grid_size * 2, y, grid_size * 2, grid_size * 2);
    fill(0, 0, 255);
    rect(x + grid_size * 4, y, grid_size * 2, grid_size * 2);
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
