class AnimatedSprite {
  PImage[] images;
  int imageCount;
  int imageCount2;
  int frame;
  float animationDelay;
  
  AnimatedSprite(String imagePrefix, int count, float newAnimationDelay ) {
    imageCount = count;
    imageCount2 = 2 * count;
  
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage("data/images/animations/" + filename);
    }
    
    animationDelay = newAnimationDelay;
  }

  void update() {
    frame = (frame+1) % imageCount2;
  }

  void draw(float xpos, float ypos) {
    image(images[frame % imageCount], xpos, ypos);
  }
  
  void draw(float xpos, float ypos, float iWidth, float iHeight) {
    image(images[frame % imageCount], xpos, ypos, 
          images[frame % imageCount].width*iWidth, 
          images[frame % imageCount].height*iHeight);
  }
  
  int getWidth() {
    return images[0].width;
  }
}

