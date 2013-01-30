class GUI {

  color tempC;
  String tempColor;
  boolean isRGB;

  PImage navbar;

  boolean hasTempTower = false;
  boolean hasTempEmitter = false;

  Tower tempTower;
  Emitter tempEmitter;

  Rect sEmitter, sTower;
  Rect sCyan, sMagenta, sYellow, sRed, sGreen, sBlue;

  /*
  TODO add rgb fields
   */


  GUI() {
    navbar = loadImage("data/gui_navbar.png");

    PVector temp = new PVector(190, 763);
    sEmitter = new Rect((int)temp.x, (int)temp.y, (int)temp.x+32, (int)temp.y+32, false );

    temp.x = 227;
    sTower = new Rect((int)temp.x, (int)temp.y, (int)temp.x+32, (int)temp.y+32, false );

    temp = new PVector(330, 767);
    sCyan = new Rect((int)temp.x, (int)temp.y, (int)temp.x+24, (int)temp.y+24, color(255, 0, 0), false );

    temp.x = 357;
    sMagenta = new Rect((int)temp.x, (int)temp.y, (int)temp.x+24, (int)temp.y+24, color(0, 255, 0), false );

    temp.x = 384;
    sYellow = new Rect((int)temp.x, (int)temp.y, (int)temp.x+24, (int)temp.y+24, color(0, 0, 255), false );

    temp.x = 411;
    sRed = new Rect((int)temp.x, (int)temp.y, (int)temp.x+24, (int)temp.y+24, color(0, 0, 255), true );

    temp.x = 438;
    sGreen = new Rect((int)temp.x, (int)temp.y, (int)temp.x+24, (int)temp.y+24, color(0, 255, 0), true );

    temp.x = 465;
    sBlue = new Rect((int)temp.x, (int)temp.y, (int)temp.x+24, (int)temp.y+24, color(255, 0, 0), true );

    checkCyan();
  }

  void draw()
  {
    rectMode(CORNER);
    image(navbar, width/2, height - navbar.height/2 );
    sCyan.draw();
    sMagenta.draw();
    sYellow.draw();

    sEmitter.draw();
    sTower.draw();

    rectMode(CENTER);

    blendMode(BLEND);
    if (hasTempTower) showTempTower();
    if (hasTempEmitter) showTempEmitter();
  }

  void checkHitbox(PVector mousePos)
  {
    if (sCyan.isInside(mousePos) ) {
      checkCyan();
      //println("cyan");
    } 
    else if (sMagenta.isInside(mousePos) ) {
      checkMagenta();
      //println("magenta");
    } 
    else if (sYellow.isInside(mousePos) ) {
      checkYellow();
      //println("yellow");
    } 
    else if (sRed.isInside(mousePos) ) {
      checkRed();
      //println("red");
    } 
    else if (sGreen.isInside(mousePos) ) {
      checkGreen();
      //println("green");
    } 
    else if (sBlue.isInside(mousePos) ) {
      checkBlue();
      //println("blue");
    }  
    else if (sEmitter.isInside(mousePos) ) { 
      if (!isRGB) chooseEmitter();
    } 
    else if (sTower.isInside(mousePos) ) {
      chooseTower();
    } 
    else if (hasTempEmitter) {
      placeEmitter();
    } 
    else if (hasTempTower) {
      placeTower();
    }
  }

  void chooseTower() {
    tempTower = new Tower(new PVector(mouseX, mouseY), (int)red(tempC), (int)green(tempC), (int)blue(tempC), isRGB, collisionIndex++, tempColor);
    hasTempTower = true;
    hasTempEmitter = false;

    if (!isRGB) {
      sidebar.setCostsOfSelectedItem( Config.costs_tower_cmy );
    } 
    else {
      sidebar.setCostsOfSelectedItem( Config.costs_tower_rgb );
    }
  }

  void chooseEmitter() {
    tempEmitter = new Emitter(new PVector(mouseX, mouseY), (int)red(tempC), (int)green(tempC), (int)blue(tempC), collisionIndex++);
    hasTempEmitter = true;
    hasTempTower = false;

    sidebar.setCostsOfSelectedItem( Config.costs_emitter );
  }

  void placeTower() {
    if ( !sidebar.canAffortSelectedItem() ) { 
      return;
    }
    tempTower.tColor = tempColor;
    towers.add(tempTower);
    tempTower = new Tower(new PVector(mouseX, mouseY), (int)red(tempC), (int)green(tempC), (int)blue(tempC), isRGB, collisionIndex++, tempColor);

    if (!isRGB) {
      sidebar.payCostsOfSelectedItem( Config.costs_tower_cmy );
    } 
    else {
      sidebar.payCostsOfSelectedItem( Config.costs_tower_rgb );
    }
  }

  void placeEmitter() {
    if ( !sidebar.canAffortSelectedItem() ) { 
      return;
    }

    emitters.add(tempEmitter);
    tempEmitter = new Emitter(new PVector(mouseX, mouseY), (int)red(tempC), (int)green(tempC), (int)blue(tempC), collisionIndex++);

    sidebar.payCostsOfSelectedItem( Config.costs_emitter );
  }

  void checkCyan() {
    setRGB(false);
    color cyan = color(255, 0, 0);
    tempC = cyan;
    tempColor = "cyan";

    if (hasTempTower) { 
      tempTower.changeColor(255, 0, 0, isRGB);
      sidebar.setCostsOfSelectedItem( Config.costs_tower_cmy );
    }
    if (hasTempEmitter) { 
      tempEmitter.changeColor(255, 0, 0);
      sidebar.setCostsOfSelectedItem( Config.costs_emitter );
    }
    sEmitter.setColor(cyan);
    sTower.setColor(cyan);
  }

  void checkMagenta() {
    setRGB(false);
    color magenta = color(0, 255, 0);
    tempC = magenta;

    tempColor = "magenta";

    if (hasTempTower) { 
      tempTower.changeColor(0, 255, 0, isRGB);
      sidebar.setCostsOfSelectedItem( Config.costs_tower_cmy );
    }
    if (hasTempEmitter) { 
      tempEmitter.changeColor(0, 255, 0);
      sidebar.setCostsOfSelectedItem( Config.costs_emitter );
    }

    sEmitter.setColor(magenta);
    sTower.setColor(magenta);
  }

  void checkYellow() {
    setRGB(false);

    color yellow = color(0, 0, 255);
    tempC = yellow;

    tempColor = "yellow";
    if (hasTempTower) { 
      tempTower.changeColor(0, 0, 255, isRGB);
      sidebar.setCostsOfSelectedItem( Config.costs_tower_cmy );
    }
    if (hasTempEmitter) { 
      tempEmitter.changeColor(0, 0, 255);
      sidebar.setCostsOfSelectedItem( Config.costs_emitter );
    }
    sEmitter.setColor(yellow);
    sTower.setColor(yellow);
  }

  void checkRed() {    
    setRGB(true);
    chooseTower();

    color red = color(255, 0, 0);
    tempC = red;

    tempColor = "red";

    if (hasTempTower) { 
      tempTower.changeColor(255, 0, 0, isRGB);
      sidebar.setCostsOfSelectedItem( Config.costs_tower_rgb );
    }

    sEmitter.setColor(color(100) );
    sTower.setColor(red);
  }

  void checkGreen() {    
    setRGB(true);

    color red = color(0, 255, 0);
    tempC = red;

    tempColor = "green";

    if (hasTempTower) { 
      tempTower.changeColor(0, 255, 0, isRGB);
      sidebar.setCostsOfSelectedItem( Config.costs_tower_rgb );
    }    
    sEmitter.setColor(color(100) );
    sTower.setColor(red);
  }

  void checkBlue() {    
    setRGB(true);
    chooseTower();

    tempColor = "blue";

    color blue = color(0, 0, 255);
    tempC = blue;

    if (hasTempTower) { 
      tempTower.changeColor(0, 0, 255, isRGB);
      sidebar.setCostsOfSelectedItem( Config.costs_tower_rgb );
    }

    sEmitter.setColor(color(100) );
    sTower.setColor(blue);
  }

  void showTempTower()
  {
    tempTower.update();
    tempTower.drawRadius();
    tempTower.draw();
  }


  void showTempEmitter()
  {
    tempEmitter.update();
    tempEmitter.drawRadius();
    tempEmitter.draw();
  }

  void setRGB(boolean _isRGB) {
    isRGB = _isRGB;
    sTower.isRGB = _isRGB;
    sEmitter.isRGB = _isRGB;
  }
}

class Rect {
  PVector leftUpper;
  PVector rightDown;

  color c;
  boolean doDraw;
  boolean isRGB;

  Rect(int x1, int y1, int x2, int y2, boolean isRGB) {
    leftUpper = new PVector(x1, y1);
    rightDown = new PVector(x2, y2);
    doDraw = false;
    isRGB = isRGB;
  }

  Rect(int x1, int y1, int x2, int y2, color _c, boolean isRGB) {
    leftUpper = new PVector(x1, y1);
    rightDown = new PVector(x2, y2);
    doDraw = true;
    c = _c;
    isRGB = isRGB;
  }

  boolean isInside(PVector p) {
    if (  (p.x >= leftUpper.x) && (p.x <= rightDown.x) &&
      (p.y >= leftUpper.y) && (p.y <= rightDown.y) ) {
      return true;
    } 
    else {
      return false;
    }
  }

  void setColor(color _c) {
    doDraw = true;
    c = _c;
  }

  void draw() {
    if (doDraw) {
      if (isRGB) {
        fill(c);
      } 
      else {
        fill(RGBtoCMY((int)red(c), (int)green(c), (int)blue(c), 1));
      }

      blendMode(MULTIPLY);
      rect(leftUpper.x, leftUpper.y, rightDown.x - leftUpper.x, rightDown.y - leftUpper.y);
      blendMode(SCREEN);
    }
  }
}

