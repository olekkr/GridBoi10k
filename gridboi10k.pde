import java.util.Iterator;

color CellTC = #10ff10; // color of cell while true
color CellFC = #ff1010; // color of cell while false
color SeperatorC = #0000FF;

int[] dims = {800, 800};
int gridDimX = 4;
int gridDimY = 4;

float[] CellSize = {(dims[0])/(gridDimX), (dims[1])/(gridDimY)};

boolean active = true;
boolean fuzzyEdge = false;

Grid grid;

void setup() {
  size(800, 800);
  frameRate(60);
  grid = new Grid();
}
void draw() {
  if (frameCount % 5 == 0) {
    grid.drawAll();
  }
  if (active){
    grid.live();
  }
  if (mousePressed) {
    grid.click(mouseX, mouseY);
  }
}

void keyPressed() {
  switch (key) {
  case ' ':
    grid = new Grid();
    return;

  case 'r':
    grid.randomize();
    println("randomized");
    return;

  case 's':
    grid.saveF("out.txt");
    println("saved");
    return;

  case 'l':
    grid.load("out.txt");
    println("loaded");
    return;

  case '1':
    active = !active;
    println("active mode set", active);
    return;
  
  case '2':
    fuzzyEdge = !fuzzyEdge;
    println("fuzzy edge mode", fuzzyEdge);
    return;
  }
}

void mouseReleased() {
  grid.unlock();
}
