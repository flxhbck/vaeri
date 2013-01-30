import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

PImage bgImage;
PImage bgBitmap;

// IO Stuff
Tower tempTower;
boolean hasTempTower;
Emitter tempEmitter;
boolean hasTempEmitter;

boolean gameRunning;
boolean gameOver = false;
boolean gameWin = false;

// GameStuff
int collisionIndex = 1;  // 0 is reserved for the heart

ArrayList<Ping> pings;
ArrayList<Tower> towers;
ArrayList<Emitter> emitters;
ArrayList<Vehicle> vehicles;
ArrayList<Projectile> projectiles;

Heart heart;

color redCyan;
color greenMagenta;
color blueYellow;
color cyanRed;
color magentaGreen;
color yellowBlue;

//Vehicles
PVector target;
Ani spawnTimer, heartTimer, pulseTimer, pulseTimerMenu, backgroundTimer, spawnDelayTimer, vehiclesTimer;
int timer, timerHeart, timerPulse, timerBackground, timerPulseMenu, timerSpawnDelay, timerVehicles;
boolean spawnTimerInitialised = false;


AnimatedSprite spriteHeart;
AnimatedSprite spritePulse;
AnimatedSprite spritePulseMenu;
AnimatedSprite background;


GUI gui;
Sidebar sidebar;

int waveLength = 15;
int waveAmount = 7;
VehicleContainer[] spawnList = new VehicleContainer[waveLength*waveAmount];
int vehicleIndex = 0;

PImage imageGameWin;
PImage imageGameOver;


void setup()
{
  size(600, 800);
  // smooth();
  ellipseMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  
  
  color redCyan =  color(255,0,0);
  color greenMagenta = color(0,255,0);
  color blueYellow = color(0,0,255);
  color cyanRed = color(0,255,255);
  color magentaGreen = color(255,0,255);
  color yellowBlue = color(255,255,0);
  
  
  // wave1
  for(int i = 0; i < waveLength; i++){
    spawnList[i] = new VehicleContainer("cyan", false);
  }
  
  // wave2
  for(int i = 0; i < waveLength; i++){
    spawnList[i + waveLength] = new VehicleContainer("magenta", false);
  }
  
  //wave3
  for(int i = 0; i < waveLength; i++){
    spawnList[i + 2*waveLength] = new VehicleContainer("yellow", false);
  }
  
  //wave4
  for(int i = 0; i < waveLength; i++){
    if ( (i%3) == 0){
      spawnList[i + 3*waveLength] = new VehicleContainer("blue", false);
    } else {
      spawnList[i + 3*waveLength] = new VehicleContainer("yellow", false);
    }
  }
  
  //wave5
  for(int i = 0; i < waveLength; i++){
    if ( (i%3) == 0){
      spawnList[i + 4*waveLength] = new VehicleContainer("green", true);
    } else {
      spawnList[i + 4*waveLength] = new VehicleContainer("magenta", false);
    }
  }
  
    //wave6
  for(int i = 0; i < waveLength; i++){
    if ( (i%3) == 0){
      spawnList[i + 5*waveLength] = new VehicleContainer("red", true);
    } else {
      spawnList[i + 5*waveLength] = new VehicleContainer("cyan", false);
    }
  }
  
  //wave7
  for(int i = 0; i < waveLength; i++){
    if ( (i%3) == 0){
      spawnList[i + 6*waveLength] = new VehicleContainer("red", false);
    } else  if ( (i%3) == 1 ) {
      spawnList[i + 6*waveLength] = new VehicleContainer("green", false);
    } else  {
      spawnList[i + 6*waveLength] = new VehicleContainer("blue", false);
    }
  }
  
  
  
  
  bgImage = loadImage("data/h3_rand.png");
  bgBitmap = loadImage("data/lvl1.png");

  imageGameWin = loadImage("data/images/gamewin.png");
  imageGameOver = loadImage("data/images/gameover.png");  
  
  
  Ani.init(this);
  Ani.setDefaultEasing(Ani.LINEAR);

  gui = new GUI();
  sidebar = new Sidebar(50, 400);

  pings = new ArrayList<Ping>();
  towers = new ArrayList<Tower>();
  emitters = new ArrayList<Emitter>();
  vehicles = new ArrayList<Vehicle>();
  projectiles = new ArrayList<Projectile>();

  heart = new Heart(new PVector(width/2, height), 0, 0, 0);
  target = heart.pos;
  
  // ANimation
  spriteHeart = new AnimatedSprite("herz/herz_", 10, 4); 
  spritePulse = new AnimatedSprite("pulse/pulse_", 10, 3);
  spritePulseMenu = new AnimatedSprite("menu_pulse/pulse_", 10, 3);
  background = new AnimatedSprite("bg/map1_", 10, 3);
  
    initAnimationTimer();

  
  gameRunning = false;
  menuIntro();
  
  loadCachedImages();
}

void update()
{
  for (int i = pings.size()-1; i >= 0; i--) {
    Ping ping = (Ping) pings.get(i);
    ping.update();

    if (ping.dead) {
      pings.remove(i);
    }
  }

  /*
    for (int i = towers.size()-1; i >= 0; i--) {
   Tower tower = (Tower) towers.get(i);
   tower.checkCollision();
   }
   */

  for (int i = emitters.size()-1; i >= 0; i--) {
    Emitter emitter = (Emitter) emitters.get(i);
    emitter.checkCollision();
  }
  
  for (int i = vehicles.size()-1; i >= 0; i--) {
    Vehicle v = (Vehicle) vehicles.get(i);
    v.update();
  }

  
}


void draw(){
  if (gameRunning){
    gameDraw();
  } else {
    background(255);
    menuDraw();
  }
  
  if (gameOver) {
    gameOverDraw(); 
  }
  
  if (gameWin) {
    gameWinDraw(); 
  }
}

void gameDraw()
{ 
  update();
  
  background(255);
  blendMode(MULTIPLY);
  
  for (int i = pings.size()-1; i >= 0; i--) {
    Ping ping = (Ping) pings.get(i);
    ping.draw(true);
  }
  
  loadPixels();
  for (int i = towers.size()-1; i >= 0; i--) {
    Tower tower = (Tower) towers.get(i);
    // muss hier aufgerufen werden um die farben checken zu können
    //tower.checkCollision();
    tower.checkColor();
  }

  
  blendMode(BLEND);
  //ADERN
  background.draw(300, 400);
  image(bgImage, width/2, height/2, width, height);
  
  spritePulse.draw(300, height-50);


  blendMode(MULTIPLY);

  for (int i = pings.size()-1; i >= 0; i--) {
    Ping ping = (Ping) pings.get(i);
    ping.draw();
  }

  blendMode(BLEND);
  
  for (int i = projectiles.size()-1; i >= 0; i--) { 
    Projectile p = (Projectile) projectiles.get(i);
    p.update();
    p.checkBounds();
    if (p.isDead) {
      projectiles.remove(i);
    } else {
      p.detectCollision();
      p.draw();
    }
  }
    
  
  for (int i = towers.size()-1; i >= 0; i--) {
    Tower tower = (Tower) towers.get(i);
    // muss hier aufgerufen werden um die farben checken zu können
    tower.checkTargets();
    tower.draw();
  }

  for (int i = emitters.size()-1; i >= 0; i--) {
    Emitter emitter = (Emitter) emitters.get(i);
    emitter.draw();
  }
  
  for (int i = vehicles.size()-1; i >= 0; i--) {
    Vehicle v = (Vehicle) vehicles.get(i);
    v.draw();
  }
  
  //HERZ
  heart.draw();
  spriteHeart.draw(300, height-90);


  gui.draw();
  sidebar.draw();
}

void gameOverDraw() {
  fill(0,200);
  rect( width/2.0, height/2.0, width, height );
  image( imageGameOver, width/2.0, height/2.0 );
}

void gameWinDraw() {
  fill(0,200);
  rect( width/2.0, height/2.0, width, height );
  image( imageGameWin, width/2.0, height/2.0 );
}

color RGBtoCMY(int r, int g, int b, float alpha){
  if (r == g && g == b && b == 255){
    return color(150);
  } else if (r == g && g == b && b == 0){
    return color(200);
  }
  return color((255-r)*alpha, (255-g)*alpha, (255-b)*alpha);
}




