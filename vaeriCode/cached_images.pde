PImage[] vehicleAnimationRedLeft;
PImage[] vehicleAnimationGreenLeft;
PImage[] vehicleAnimationBlueLeft;
PImage[] vehicleAnimationCyanLeft;
PImage[] vehicleAnimationMagentaLeft;
PImage[] vehicleAnimationYellowLeft;

PImage[] vehicleAnimationRedRight;
PImage[] vehicleAnimationGreenRight;
PImage[] vehicleAnimationBlueRight;
PImage[] vehicleAnimationCyanRight;
PImage[] vehicleAnimationMagentaRight;
PImage[] vehicleAnimationYellowRight;

PImage[] vehicleDeadAnimationRedLeft;
PImage[] vehicleDeadAnimationGreenLeft;
PImage[] vehicleDeadAnimationBlueLeft;
PImage[] vehicleDeadAnimationCyanLeft;
PImage[] vehicleDeadAnimationMagentaLeft;
PImage[] vehicleDeadAnimationYellowLeft;

PImage[] vehicleDeadAnimationRedRight;
PImage[] vehicleDeadAnimationGreenRight;
PImage[] vehicleDeadAnimationBlueRight;
PImage[] vehicleDeadAnimationCyanRight;
PImage[] vehicleDeadAnimationMagentaRight;
PImage[] vehicleDeadAnimationYellowRight;

void loadCachedImages() {
  vehicleAnimationRedLeft = loadSpriteAnimation("mob_l_", "r", 4);
  vehicleAnimationGreenLeft = loadSpriteAnimation("mob_l_", "g", 4);
  vehicleAnimationBlueLeft = loadSpriteAnimation("mob_l_", "b", 4);
  vehicleAnimationCyanLeft = loadSpriteAnimation("mob_l_", "c", 4);
  vehicleAnimationMagentaLeft = loadSpriteAnimation("mob_l_", "m", 4);
  vehicleAnimationYellowLeft = loadSpriteAnimation("mob_l_", "y", 4);
  
  vehicleDeadAnimationRedLeft = loadSpriteAnimation("death_l_", "r", 3);
  vehicleDeadAnimationGreenLeft = loadSpriteAnimation("death_l_", "g", 3);
  vehicleDeadAnimationBlueLeft = loadSpriteAnimation("death_l_", "b", 3);
  vehicleDeadAnimationCyanLeft = loadSpriteAnimation("death_l_", "c", 3);
  vehicleDeadAnimationMagentaLeft = loadSpriteAnimation("death_l_", "m", 3);
  vehicleDeadAnimationYellowLeft = loadSpriteAnimation("death_l_", "y", 3);  

  vehicleAnimationRedRight = loadSpriteAnimation("mob_r_", "r", 4);
  vehicleAnimationGreenRight = loadSpriteAnimation("mob_r_", "g", 4);
  vehicleAnimationBlueRight = loadSpriteAnimation("mob_r_", "b", 4);
  vehicleAnimationCyanRight = loadSpriteAnimation("mob_r_", "c", 4);
  vehicleAnimationMagentaRight = loadSpriteAnimation("mob_r_", "m", 4);
  vehicleAnimationYellowRight = loadSpriteAnimation("mob_r_", "y", 4);
  
  vehicleDeadAnimationRedRight = loadSpriteAnimation("death_r_", "r", 3);
  vehicleDeadAnimationGreenRight = loadSpriteAnimation("death_r_", "g", 3);
  vehicleDeadAnimationBlueRight = loadSpriteAnimation("death_r_", "b", 3);
  vehicleDeadAnimationCyanRight = loadSpriteAnimation("death_r_", "c", 3);
  vehicleDeadAnimationMagentaRight = loadSpriteAnimation("death_r_", "m", 3);
  vehicleDeadAnimationYellowRight = loadSpriteAnimation("death_r_", "y", 3);
}

PImage[] loadSpriteAnimation(String imagePrefix, String imagePostfix, int imageCount) {
  PImage[] images = new PImage[imageCount];

  for (int i = 1; i <= imageCount; i++) {
    String filename = imagePrefix + i + "_" + imagePostfix + ".png";
    images[i-1] = loadImage("data/images/animations/enemy/" + filename);
  }
  
  return images; 
}


