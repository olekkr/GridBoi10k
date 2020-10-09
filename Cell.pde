class Cell {
  boolean value;
  int[] gridPos = new int[2];
  PVector pos = new PVector();
  Grid grid;

  boolean locked = false;
  boolean debugMode = false;


  Cell(float x, float y, int gx, int gy, boolean val, Grid gridd) {
    gridPos[0] = gx;
    gridPos[1] = gy;
    pos.set(x, y);
    value = val;
    grid = gridd;
  }

  Cell() {
    gridPos[0] = 0;
    gridPos[1] = 0;
    pos.set(width/2, height/2);
    value = false;
  }

  void flip() {
    if (!locked) {
      value = !value;
    }
    locked = true;
  }

  void render() {
    if (!debugMode) {
      stroke(SeperatorC);
      if (value) {
        fill(CellTC);
      } else {
        fill(CellFC);
      }
      rect(pos.x, pos.y, CellSize[0], CellSize[1]);
    } else {
      stroke(SeperatorC);
      fill(DCellC[fellows()]);
      rect(pos.x, pos.y, CellSize[0], CellSize[1]);
    }
  }

  int fellows() {
    int acc = 0;
    for (int dy = -1; dy <= 1; dy += 1) {
      for (int dx = -1; dx <= 1; dx += 1) { 
        if (dy == 0 && dx == 0) { // skips self
          continue;
        }
        if (dx + gridPos[0] >= gridDimX  || dx + gridPos[0] < 0) { // if x out of bounds ->
          if (fuzzyEdge) {
            acc += random(0, 1.5) > 1.0 ? 1 : 0;
          }
          continue;
        }
        if (dy + gridPos[1] >= gridDimY  || dy + gridPos[1] < 0 ) { // if y out of bounds
          if (fuzzyEdge) {
            acc += random(0, 1.5) > 1.0 ? 1 : 0;
          }
          continue;
        }
        //println(gridPos[1]+dx,gridPos[0]+dy);
        acc += grid.content[gridPos[0]+dx][gridPos[1]+dy].value ? 1 : 0;
      }
    }
    return acc;
  }

  void live(Boolean[][] gridBuff) {
    if (value) {
      if (!(fellows() == 3 || fellows() == 2)) { // overcrowded - dies
        gridBuff[gridPos[0]][gridPos[1]] = false;
      }
    } else if (fellows() == 3) { // make baby 
      gridBuff[gridPos[0]][gridPos[1]] = true;
    }
  }
}
