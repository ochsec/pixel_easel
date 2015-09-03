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
    //image(pencil, x, y - 48, w, h);
    stroke(255);
    fill(c);  
    rect(x, y, w, h);
  }
}