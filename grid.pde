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
      if (mousePressed) // && (mouseButton == LEFT))
      {
        active = true;
        stroke(c);
        fill(c);
        rect(x, y, w, h);
      } 
      /*
      else if (mousePressed && (mouseButton == RIGHT))
      {
        active = false;
        stroke(c);
        fill(bg);
        rect(x, y, w, h);        
      }
      */
    }
  }
}