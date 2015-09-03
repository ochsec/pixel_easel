class Eraser {
  int x, y, w, h;
  boolean over;
  
  Eraser(int _x, int _y, int _w, int _h)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    over = false;
  }
  
  void display()
  {
    //image(eraser, x, y, w, h);
  }
  
  void rollover(int mx, int my)
  {
    if (mx > x && mx < x + w && my > y && my < y + h) {
      over = true;
    } else {
      over = false;
    }
  }
}