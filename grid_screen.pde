int grid_size = 8;
int board_w = 80;
int board_h = 60;
color bg = color(68, 68, 68);
ArrayList<Grid> squares;

void setup() 
{
  frameRate(60);
  size(board_w * grid_size, board_h * grid_size);
  background(bg);
  squares = new ArrayList<Grid>();  // Create an empty ArrayList
  for (int i = 0; i < board_w; i++)
  {
    for (int j = 0; j < board_h; j++)
    {
      squares.add(new Grid(i, j, 1, 1, color(225, 225, 225)));
    }
  }
}

void draw()
{
  background(bg);
  for (int i = 0; i < squares.size() - 1; i++)
  {
    Grid square = squares.get(i);
    square.display();
  }
  for (int j = 0; j < squares.size() - 1; j++)
  {
    Grid square = squares.get(j);
    square.update();
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

  void update()
  {
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
