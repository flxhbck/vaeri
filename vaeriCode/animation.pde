void initAnimationTimer() {
    timerHeart = 0;
    heartTimer = new Ani(this, 0.1, "timerHeart", 666, Ani.LINEAR);
    heartTimer.setCallback("onEnd:animateHeart");

    timerPulse = 0;
    pulseTimer = new Ani(this, 0.1, "timerPulse", 666, Ani.LINEAR);
    pulseTimer.setCallback("onEnd:animatePulse");
    
    timerPulseMenu = 0;
    pulseTimerMenu = new Ani(this, 0.1, "timerPulseMenu", 666, Ani.LINEAR);
    pulseTimer.setCallback("onEnd:animatePulseMenu"); 

    timerBackground = 0;
    backgroundTimer = new Ani(this, 0.1, "timerBackground", 666, Ani.LINEAR);
    backgroundTimer.setCallback("onEnd:animateBackground");
    
    timerVehicles = 0;
    vehiclesTimer = new Ani(this, 0.1, "timerVehicles", 666, Ani.LINEAR);
    vehiclesTimer.setCallback("onEnd:animateVehicles");
}

void animateVehicles() {
  //spritePulse.update(); 
  
  for (int i = vehicles.size()-1; i >= 0; i--) {
    Vehicle v = (Vehicle) vehicles.get(i);
    v.animationUpdate();
  }
  
  vehiclesTimer.start();
}

void animateHeart() { 
  spriteHeart.update(); 
  
  if (spriteHeart.frame == 6) pings.add(new Ping(heart.pos, 255, 255, 255, true, 0));
  if (spriteHeart.frame == 10) pings.add(new Ping(heart.pos, 255, 255, 255, true, 0));
  
  heartTimer.start(); 

}
void animatePulse() { spritePulse.update(); pulseTimer.start(); }
void animatePulseMenu() { spritePulseMenu.update(); pulseTimerMenu.start(); }
void animateBackground() { background.update(); backgroundTimer.start(); }


// SPAWN

void initPeriodicallySpawn() {
    timer = 0; 
    
    spawnTimer = new Ani(this, 1, "timer", 666, Ani.LINEAR);
    spawnTimer.setCallback("onEnd:periodicallySpawn");
}

void periodicallySpawn() {
  
  
  
  if (spawnList[vehicleIndex].vC == "cyan"){
    vehicles.add( new Vehicle( new PVector( randomStartPosition(), 5), target, randomOffsetToEdge(), "cyan", false,vehicleAnimationCyanLeft, vehicleDeadAnimationCyanLeft, vehicleAnimationCyanRight, vehicleDeadAnimationCyanRight ) );
  } else if (spawnList[vehicleIndex].vC == "magenta"){
    vehicles.add( new Vehicle( new PVector( randomStartPosition(), 5), target, randomOffsetToEdge(), "magenta", false,vehicleAnimationMagentaLeft, vehicleDeadAnimationMagentaLeft, vehicleAnimationMagentaRight, vehicleDeadAnimationMagentaRight ) );
  } else if (spawnList[vehicleIndex].vC == "yellow"){
    vehicles.add( new Vehicle( new PVector( randomStartPosition(), 5), target, randomOffsetToEdge(), "yellow", false,  vehicleAnimationYellowLeft, vehicleDeadAnimationYellowLeft, vehicleAnimationYellowRight, vehicleDeadAnimationYellowRight ) );
  } else if (spawnList[vehicleIndex].vC == "red"){
    vehicles.add( new Vehicle( new PVector( randomStartPosition(), 5), target, randomOffsetToEdge(), "red", true,  vehicleAnimationRedLeft, vehicleDeadAnimationRedLeft, vehicleAnimationRedRight, vehicleDeadAnimationRedRight ) );
  } else if (spawnList[vehicleIndex].vC == "green"){
    vehicles.add( new Vehicle( new PVector( randomStartPosition(), 5), target, randomOffsetToEdge(),"green", true,vehicleAnimationGreenLeft, vehicleDeadAnimationGreenLeft, vehicleAnimationGreenRight, vehicleDeadAnimationGreenRight ) );
  } else if (spawnList[vehicleIndex].vC == "blue"){
    vehicles.add( new Vehicle( new PVector( randomStartPosition(), 5), target, randomOffsetToEdge(),"blue", true,vehicleAnimationBlueLeft, vehicleDeadAnimationBlueLeft, vehicleAnimationBlueRight, vehicleDeadAnimationBlueRight ) );
  }
  
  //vehicles.add( new Vehicle( new PVector( randomStartPosition(), 5), target, randomOffsetToEdge(), spawnList[vehicleIndex].vC, spawnList[vehicleIndex].isRGB ) );
  
  
  //println(spawnList[vehicleIndex].vC);
  vehicleIndex++;

  
  if (vehicleIndex % waveLength == 0){
    if ( !spawnTimerInitialised ){
      spawnDelayTimer = new Ani(this, 15, "timerSpawnDelay", 666, Ani.LINEAR);
      spawnDelayTimer.setCallback("onEnd:spawnDelay");
      spawnTimerInitialised = true;
    } else {
      timerSpawnDelay = 0;
      spawnDelayTimer.start();
    }
  } else {
    timer = 0;
    spawnTimer.start();
  }
}

void spawnDelay() {
  timer = 0;
  //println("CHECK");
  spawnTimer.start();
  
}

// HELPER

float randomStartPosition() {
  return random(230, 310);
}

int randomOffsetToEdge() {
  return (int)random(3, 30);
}


