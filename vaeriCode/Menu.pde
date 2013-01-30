Ani menuAniMiddle, menuAniEnd;

PImage menuTitle, menuGameJam, menuName;

Ani menuTitleAniMiddle,menuTitleAniEnd;
int menuTitleY = -200;
int menuTitleYMiddle = 120;
int menuTitleYEnd = 1000;

Ani menuGameJamAniMiddle,menuGameJamAniEnd;
int menuGameJamY = -200;
int menuGameJamYMiddle = 700;
int menuGameJamYEnd = 1000;

Ani menuNameAniMiddle, menuNameAniEnd;
int menuNameY = -200;
int menuNameYMiddle = 400;
int menuNameYEnd = 1000;

Ani menuHeartAniMiddle, menuHeartAniEnd;
int menuHeartY = -1000;
int menuHeartYMiddle = 400;
int menuHeartYEnd = 1600;

float menu_bg_opcaity = 1.0;

float startDelay = 1.0;

void menuIntro() {
    menuTitle = loadImage("data/images/menu/title.png");
    menuGameJam = loadImage("data/images/menu/gamejam.png");
    menuName = loadImage("data/images/menu/namen.png");
  
    menuHeartAniMiddle = new Ani(this, 4.0, startDelay, "menuHeartY", menuHeartYMiddle, Ani.ELASTIC_OUT);
    menuTitleAniMiddle = new Ani(this, 2.6, startDelay + 0.5, "menuTitleY", menuTitleYMiddle, Ani.EXPO_IN_OUT);
    menuGameJamAniMiddle = new Ani(this, 2.6, startDelay + 2.0, "menuGameJamY", menuGameJamYMiddle, Ani.EXPO_IN_OUT, "onEnd:tweenToEnd");
}

void tweenToEnd() {
  menuHeartAniEnd = new Ani(this, 1.4, 0.5, "menuHeartY", menuHeartYEnd, Ani.EXPO_IN_OUT);
  menuTitleAniEnd = new Ani(this, 1.4, 0.5, "menuTitleY", menuTitleYEnd, Ani.EXPO_IN_OUT); 
  menuGameJamAniEnd = new Ani(this, 1.4, 0.5, "menuGameJamY", menuGameJamYEnd, Ani.EXPO_IN_OUT, "onEnd:startGame"); 
}

void startGame() {
  gameRunning = true;
  
  initPeriodicallySpawn();
}

void menuDraw() {
  spritePulseMenu.draw(300, menuHeartY);  
  spriteHeart.draw(300, menuHeartY);
  
  image(menuTitle, 300, menuTitleY);
  image(menuGameJam, 300, menuGameJamY);  
}

