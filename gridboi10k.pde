import java.util.Iterator;

color CellTC = #ffffff; // color of cell while true
color CellFC = #030303; // color of cell while false
color SeperatorC = #2000F0;

color[] DCellC = {#000000, #fc0c0c, #fca80c, #fcf80c, #30fc0c, #0cfcd4 , #0c60fc, #d0d0d0, #ffffff };

int[] dims = {800, 800};
int gridDimX = 64;
int gridDimY = 64;

float[] CellSize = {(dims[0])/float(gridDimX), (dims[1])/float(gridDimY)};

boolean active = true;
boolean fuzzyEdge = false;

Grid grid;

void setup() {
  size(800, 800);
  frameRate(60);
  grid = new Grid();
}
void draw() {
  background(170);
  if (frameCount % 1 == 0) {
    grid.drawAll();
    if (active) {
      grid.live();
    }
    if (mousePressed) {
      grid.click(mouseX, mouseY);
    }
  }
}

void keyPressed() {
  switch (key) {
  case ' ':
    grid = new Grid();
    println("grid cleaned");
    return;

  case 'r':
    grid.randomize();
    println("grid randomized");
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
    println("freeze set", !active);
    return;

  case '2':
    fuzzyEdge = !fuzzyEdge;
    println("fuzzy edge mode", fuzzyEdge);
    return;
    
  case 'd':
    grid.toggleD();
    return;
    
    
  default :
  println(grid.content[8][2].fellows(), grid.content[0][2].value);
  }
}

void mouseReleased() {
  grid.unlock();
}
