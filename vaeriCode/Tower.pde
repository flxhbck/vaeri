class Tower
{
  PVector pos;
  float radius;
  int r,g,b;
  String tColor;
  
  int id;
  
  PImage sprite_c, sprite_m, sprite_y, sprite_r, sprite_g, sprite_b;
  
  boolean activated = false;
  boolean isRGB;
  
  
  Tower(PVector _pos, int _r, int _g, int _b, boolean isRGB, int _id, String _tColor)
  {
    this.pos = new PVector(_pos.x, _pos.y);
      
    this.r = _r;
    this.g = _g;
    this.b = _b;
    this.isRGB = isRGB;
    
    this.radius = 40;
    this.id = _id;
    
    this.tColor = _tColor;
    
    
    sprite_c = loadImage("data/tower_c.png");
    sprite_m = loadImage("data/tower_m.png");
    sprite_y = loadImage("data/tower_y.png");
    
    sprite_r = loadImage("data/tower_r.png");
    sprite_g = loadImage("data/tower_g.png");
    sprite_b = loadImage("data/tower_b.png");
    
  }
  
  void update()
  {
    
  }
  
  void draw()
  { 
    if (!isRGB){
      if (r == 255 && g == 0 && b == 0){
        image(sprite_c, (int)pos.x, (int)pos.y, sprite_c.width, sprite_c.height);
      } else if (r == 0 && g == 255 && b == 0){
        image(sprite_m, (int)pos.x, (int)pos.y, sprite_m.width, sprite_m.height);
      } else if (r == 0 && g == 0 && b == 255){
        image(sprite_y, (int)pos.x, (int)pos.y, sprite_y.width, sprite_y.height);
      }
    } else {
      if (r == 255 && g == 0 && b == 0){
        image(sprite_r, (int)pos.x, (int)pos.y, sprite_r.width, sprite_r.height);
      } else if (r == 0 && g == 255 && b == 0){
        image(sprite_g, (int)pos.x, (int)pos.y, sprite_g.width, sprite_g.height);
      } else if (r == 0 && g == 0 && b == 255){
        image(sprite_b, (int)pos.x, (int)pos.y, sprite_b.width, sprite_b.height);
      }
    }
    
    
    /*
    if (activated) {
      fill(255,255,255);
    } else {
      fill(RGBtoCMY(r,g,b, 1));
    }
    noStroke();

    //image(sprite, pos.x, pos.y, sprite.width, sprite.height);
    rect(pos.x, pos.y, radius, radius);
    */
  }
  
  
  void drawRadius(){
    blendMode(MULTIPLY);
    strokeWeight(2);
    if (!isRGB){
      stroke(RGBtoCMY(r,g,b, Config.ping_transparency));
    } else {
      stroke(r,g,b, Config.ping_transparency);
    }
    noFill();
    ellipse(pos.x, pos.y, Config.tower_range*2, Config.tower_range*2);
    blendMode(BLEND);
  }
  
  
  void checkColor()
  {
    //checkBackgroundColor
    color c = pixels[(int)pos.y*width + (int)pos.x];
    
    if (!isRGB){ 
    
      // this.r -> 255 = cyan
      if ( (this.r == 255) && ( (green(c) != 255) && (blue(c) != 255) ) ) {
        activated = true;
      } else if ( (this.g == 255) && ( (red(c) != 255) && (blue(c) != 255) ) ) {
        activated = true;
      } else if ( (this.b == 255) && ( (red(c) != 255) && (green(c) != 255) ) ) {
        activated = true;
      } else {
        activated = false;
      }
      
    } else {
      if ( (this.r == 255) && ( red(c) != 0 ) ) {
        activated = true;
      } else if ( (this.g == 255) && ( green(c) != 0 ) ) {
        activated = true;
      } else if ( (this.b == 255) && ( blue(c) != 0 ) ) {
        activated = true;
      } else {
        activated = false;
      }
    }
    
  }
  
  void checkTargets()
  {
    if (!activated) return;
    for (int i = 0; i <= vehicles.size()-1; i++) {
      Vehicle v = (Vehicle) vehicles.get(i);
      
      if ( v.sc != this.tColor  ){
        // println(v.sc + " " + tColor);
        continue;
      }
      
      if (this.pos.dist(v.pos) <= Config.tower_range){
        
        PVector dir = new PVector();
        dir.x = v.pos.x - pos.x;
        dir.y = v.pos.y - pos.y;
        Projectile tempProj = new Projectile(this.pos, dir, color(r,g,b), isRGB );
        tempProj.sColor = tColor;

        projectiles.add(tempProj );
        break;
        
        /*
        
        PVector dir = new PVector(v.pos.x - pos.x, v.pos.y - pos.y);
        projectiles.add( new Projectile(pos, dir, color(r,g,b) ) );
        */
      }
    }
  }
  
  void changeColor(String _c){
   tColor = _c;
  } 
  
  void changeColor(int _r, int _g, int _b, boolean _isRGB){
    r = _r;
    g = _g;
    b = _b;
    isRGB = _isRGB;
  }
  
}
  
