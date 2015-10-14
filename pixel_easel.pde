import ketai.ui.*;
import ketai.sensors.*;
import android.view.MotionEvent;

KetaiSensor sensor;
KetaiGesture gesture;
boolean solid;
int grid_size, board_w, board_h;
float x, y;
color bg, pen;
PVector accelerometer = new PVector();
PVector pAccelerometer = new PVector();
ArrayList<Grid> squares;

void setup() {
  orientation(LANDSCAPE); 
  size(displayWidth, displayHeight);
  gesture = new KetaiGesture(this);
  sensor = new KetaiSensor(this);
  sensor.start();
  
  bg = color(200);
  pen = color(80);
  background(bg); 
  solid = true;
  grid_size = 64;
  board_w = 80;
  board_h = 60;
  squares = new ArrayList<Grid>();  // Create an empty ArrayList
  for (int i = 0; i < board_w; i++) {
    for (int j = 0; j < board_h; j++) {
      squares.add(new Grid(i, j, 1, 1, bg));  
    }
  }
}

void draw() {
  for (int i = 0; i < squares.size() - 1; i++) {
    Grid square = squares.get(i);
    square.update(pen);
  }
  float delta = PVector.angleBetween(accelerometer, pAccelerometer);
  if (degrees(delta) > 45) {
    for (int i = 0; i < squares.size() - 1; i++) {
      Grid square = squares.get(i);
      square.shake(bg); 
    }  
  }
  // storing a reference vector
  pAccelerometer.set(accelerometer);
}

void onDoubleTap(float x, float y) {
  if (solid == true) {
    solid = false;
  }
  else {
    solid = true;  
  }
}

void onLongPress(float x, float y) {
  pen = color(random(255), random(255), random(255));
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometer.x = x;
  accelerometer.y = y;
  accelerometer.z = z;
}

public boolean surfaceTouchEvent(MotionEvent event) {
  // call to keep mouseX and mouseY constants updated
  super.surfaceTouchEvent(event);
  // forward events
  return gesture.surfaceTouchEvent(event);
}