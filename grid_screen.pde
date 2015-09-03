import ketai.ui.*;
import ketai.sensors.*;
import android.view.MotionEvent;

int grid_size = 16;
int board_w = displayWidth;
int board_h = displayHeight;
int x, y, t_height, t_width;
color bg = color(200, 200, 200);
color pen = color(75);
ArrayList<Grid> squares;
Palette p = new Palette(board_w * grid_size + 15, 15, 90, 180, true);
Swatch swatch = new Swatch(board_w * grid_size + 15, 448, 32, 32);
Eraser e = new Eraser(board_w * grid_size + 64, 400, 32, 32);
//PImage pencil, eraser;
KetaiGesture gesture;
KetaiSensor sensor;
PVector accelerometer = new PVector();
PVector pAccelerometer = new PVector();
String lastEventText = "";

void setup() 
{
  size(displayWidth, displayHeight, P2D);
  orientation(LANDSCAPE);
  gesture = new KetaiGesture(this);
  sensor = new KetaiSensor(this);
  sensor.start();
  background(bg);
  fill(bg);
  //pencil = loadImage("pencil.png");
  //eraser = loadImage("eraser.png");
  // Create an empty ArrayList
  squares = new ArrayList<Grid>();
  for (int i = 0; i < board_w; i++)
  {
    for (int j = 0; j < board_h; j++)
    {
      squares.add(new Grid(i, j, 1, 1, pen));
    }
  }
  squares.add(new Grid(80, 60, 1, 1, pen));
  p.display();
  //swatch.display();
  t_height = height/15;
  t_width = width/2;
}

void draw() {
  //pushMatrix();
  for (int j = 0; j < squares.size() - 1; j++)
  {
    Grid square = squares.get(j);
    square.update(pen);
  } 
  p.display();
  //swatch.display();
  //e.display();
  //popMatrix();
  
  text(lastEventText, t_width, t_height);
}

void onTap(float x, float y) {
  p.rollover(mouseX, mouseY);
  if(p.over == true)
  {
    pen = get(mouseX, mouseY);
    swatch.c = pen;
  }
  e.rollover(mouseX, mouseY);
  if(e.over == true)
  {
    pen = bg;  
  }
  
  lastEventText = "SINGLE_TAP@" + x + "," + y;                // print events at top left of screen
  println(lastEventText);
}

/*
void mouseClicked() {
  p.rollover(mouseX, mouseY);
  if(p.over == true)
  {
    pen = get(mouseX, mouseY);
    swatch.c = pen;
  }
  e.rollover(mouseX, mouseY);
  if(e.over == true)
  {
    pen = bg;  
  }
}
*/

void keyPressed()
{
  println(keyCode);  
  if (keyCode == 83)
  {
    save("output.png");
  }
}

public boolean surfaceTouchEvent(MotionEvent event) {
  // call to keep mouseX and mouseY constants updated
  super.surfaceTouchEvent(event);
  // forward events
  return gesture.surfaceTouchEvent(event);
}