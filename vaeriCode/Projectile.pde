class Projectile
{
  
  PVector pos, vel;
  PVector fatherPos;
  color c;
  int radius;
  boolean isDead = false;
  boolean isRGB; 
  String sColor;
  
  Projectile(PVector _pos, PVector _vel, color _c, boolean _isRGB)
  {
    this.pos = new PVector(_pos.x, _pos.y);
    this.vel = _vel;
    this.fatherPos = new PVector(_pos.x, _pos.y);
    this.isRGB = _isRGB;
    vel.normalize();
    vel.mult(Config.projectile_max_speed);
    this.c = _c;
    this.radius = 2;
    sColor = "";
  }
  
  void update(){
    checkBounds();
    
    pos.add(vel);
  }
  
  void draw(){
    noStroke();
    if(!isRGB){
      fill(RGBtoCMY((int)red(c),(int)green(c),(int)blue(c),1));
    } else {
      fill((int)red(c),(int)green(c),(int)blue(c));
    }
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
  
  void detectCollision()
  {
    for (int i = vehicles.size()-1; i >= 0; i--) {
      Vehicle v = (Vehicle) vehicles.get(i);
      if (v.c != this.c || v.isRGB != this.isRGB) break;
      if (v.sc != sColor) break;
      
      if (this.pos.dist(v.pos) < (this.radius + v.radius)*2 ){
        vehicles.get(i).killed();
        vehicles.remove(i);
      }
    }
  }
  
  void checkBounds()
  {
     if (pos.x > width || pos.x < 0){
       isDead = true;
     }
     if (pos.y > height || pos.y < 0){
       isDead = true;
     }
     
     if (this.pos.dist(this.fatherPos) >= Config.tower_range ){
       isDead = true;
     }
     
  }
  
  
  
}
