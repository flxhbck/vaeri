class Sidebar {

  PImage sidebarImageBack, sidebarImageFront;
  
  int x,y;
  int scoreX,scoreY;
  
  int hue;
  float money;
  
  final int h = 500;
  final int w = 82;
  
  Ani colorTimer;
  color colorForCosts;
  float costsInFloat;
   
  public Sidebar(int _x, int _y) {
      x = _x;
      y = _y;
      
      scoreX = 12;
      scoreY = 610;
    
      sidebarImageBack = loadImage("data/images/menu/sidebar2.png");
      sidebarImageFront = loadImage("data/images/menu/sidebar1.png");
      
      hue = 0;
      colorForCosts = color(255,255,255, 128);
      
      money = float(Config.costs_start) / Config.costs_maximum;
      
      costsInFloat = 0.0;
      
      initColorAnimation();
  }
  
  void setCostsOfSelectedItem ( int costs ) {
    costsInFloat = float(costs) / Config.costs_maximum;
  }
  
  void addToMoney ( int points ) {
      money += float(points) / Config.costs_maximum;
      
      if ( money >= 1.0 ) { money = 1.0; }
  }
  
  void payCostsOfSelectedItem ( int costs ) {
    costsInFloat = float(costs) / Config.costs_maximum;
    money -= costsInFloat;
    if (money <= 0){
      gameOver = true;
    }
  }
  
  boolean canAffortSelectedItem() {
    return ( money - costsInFloat >= 0 );
  }
  
  void initColorAnimation() {
    colorTimer = new Ani(this, 3.0, "hue", 255, Ani.SINE_IN_OUT);
    colorTimer.setCallback("onEnd:colorTimerEnd");
  }
  
  void colorTimerEnd() {
    hue = 0;
    colorTimer.start();
  }
  
  void draw() {
    noStroke();
    
    image(sidebarImageBack, x,y, w,h);
    
    rectMode(CORNERS);
    colorMode(HSB);
    
    fill(hue, 255,255);
    rect( scoreX, scoreY - (420*money), scoreX + 75, scoreY );
  
    if ( canAffortSelectedItem() ) {
      colorMode(RGB);
      fill( 255, 128 );
      rect( scoreX, scoreY - (420*money) + (420*costsInFloat), scoreX + 75, scoreY - (420*money) );
    }
    
    rectMode(CENTER);
    colorMode(RGB);
    
    image(sidebarImageFront, x,y, w,h);
  }
}
