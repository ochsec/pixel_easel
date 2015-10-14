class Grid {
  
  int x, y, w, h;
  color c;
  boolean active;
  
  Grid(int _x, int _y, int _w, int _h, color _c) {
    x = _x * grid_size;
    y = _y * grid_size;
    w = _w * grid_size;
    h = _h * grid_size;
    c = _c;
  }
  
  void display() {
    if (active == true) {
        stroke(pen);
        fill(pen);
    }
    else {
      stroke(pen);
      fill(bg);
    }
    rect(x, y, w, h);
  }
  
  void update(color _c) {
    c = _c;
    if ( ( (mouseX >= x) && (mouseX < x + w) ) && ( (mouseY >= y) && (mouseY < y + h) ) ) {
      if (mousePressed && (solid == true)) {
        active = true;
        stroke(pen);
        fill(pen);
        rect(x, y, w, h);
      }
      else if (mousePressed && (solid == false)) {
        active = false;
        stroke(pen);
        fill(bg);
        rect(x, y, w, h);
      }    
    }
  }
  
  void shake(color _c) {
    c = _c;
    stroke(c);
    fill(c);
    rect(x, y, w, h);
  }
}