class Grid {
  float[] pos = {0, 0};
  Boolean[][] gridBuff;


  Cell[][] content = new Cell[gridDimX][gridDimY];


  Grid () {
    for (int i = 0; i < gridDimY; i++) {
      for (int j = 0; j < gridDimX; j++) {
        content[j][i] = new Cell(pos[0] + CellSize[0] * i, pos[1] + CellSize[1] * j, i, j, false, this);
      }
    }
    gridBuff = new Boolean[gridDimX][gridDimY];
  }

  boolean click(float x, float y) {
    for (int i = 0; i < gridDimX; i++) {
      for (int j = 0; j < gridDimY; j++) {
        if (content[i][j].pos.x < x && x < content[i][j].pos.x + CellSize[0] &&
          content[i][j].pos.y < y && y < content[i][j].pos.y + CellSize[1]) {
          content[i][j].flip();

          return true;
        }
      }
    }
    return false;
  }

  void unlock() {
    for (int i = 0; i < gridDimX; i++) {
      for (int j = 0; j < gridDimY; j++) {
        content[i][j].locked = false;
      }
    }
  }

  void randomize () {
    for (int i = 0; i < gridDimX; i++) {
      for (int j = 0; j < gridDimY; j++) {
        content[i][j] = new Cell(pos[0] + CellSize[0] * i, pos[1] + CellSize[1] * j, i, j, random(1, 2)>1.8, this);
      }
    }
  }


  void drawAll() {
    for (int i = 0; i < gridDimX; i++) {
      for (int j = 0; j < gridDimX; j++) {
        content[i][j].render();
      }
    }
  }

  void saveF(String path) { //
    String[] sArr = new String[gridDimY];
    String temp = "";
    for (int y = 0; y < gridDimY; y ++) {
      temp = "";
      for (int x = 0; x < gridDimX; x ++) {
        if (content[x][y].value == true) {
          temp += "1";
        } else {
          temp += "0";
        }
      }
      sArr[y] = temp;
    }
    saveStrings(path, sArr);
  }

  void load(String path) {
    String[] sArr = loadStrings(path);
    for (int y = 0; y < gridDimY; y ++) {
      for (int x = 0; x < gridDimX; x ++) {
        if (sArr[y].charAt(x) == '1') {
          content[x][y].value = true;
        } else {
          content[x][y].value = false;
        }
      }
    }
    saveStrings(path, sArr);
  }

  Boolean[][] to2DBool() {
    for (int y = 0; y < gridDimY; y ++) {
      for (int x = 0; x < gridDimX; x ++) {
        gridBuff[x][y] = content[x][y].value;
      }
    }
    return gridBuff;
  }
  void update(){ // updates from buffer
    for (int y = 0; y < gridDimY; y ++) {
      for (int x = 0; x < gridDimX; x ++) {
        content[x][y].value = gridBuff[x][y];
      }
    }
  }

  void live() {
    gridBuff = to2DBool();
    for (int i = 0; i < gridDimX; i++) {
      for (int j = 0; j < gridDimY; j++) {
        content[i][j].live(gridBuff);
      }
    }
    update();
  }
}
