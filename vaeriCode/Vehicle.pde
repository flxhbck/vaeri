class Vehicle{
  
  PVector pos, vel;
  float maxSpeed = 1.0;
  PVector target;
  boolean isDead;
  float radius;
  color c;
  String sc;
  boolean isRGB;
  
  PImage[] left, deadLeft, right, deadRight;
  
  int offsetToEdge;
  int imageCount;
  int frame;
  
  Vehicle(PVector _pos, PVector _target, int _edge_offset, String _c, boolean _isRGB, PImage[] _left, PImage[] _deadLeft, PImage[] _right, PImage[] _deadRight ) {
    pos = _pos;
    target = _target;
    vel = new PVector(0,0);
    radius = 5;
    this.isRGB = _isRGB;
    this.sc = _c;

    
    left = _left;
    deadLeft = _deadLeft;
    right = _right; 
    deadRight = _deadRight;
    
    isDead = false;
    if( _c == "cyan" || _c == "red"){
      c = color(255,0,0);
    } else if (_c == "magenta" || _c == "green"){
      c = color(0, 255,0);
    } else if (_c == "yellow" || _c == "blue"){
      c = color(0,0,255);
    }
    
    offsetToEdge = _edge_offset;
    
    frame = 0;
  }
  
  void killed() {
    if (!isDead) sidebar.addToMoney( Config.points_kill );
    isDead = true;
    frame = 0;
  }
  
  void deadAnimationOver() {
    vehicles.remove(this);
  }
  
  boolean isAlive() {
    return !isDead;
  }
  
  boolean walkingLeft() {
    if ( vel == null ) { return true; }
    
    return vel.x < 0.0;
  }
  
  void update() {
    if (vel == null) {
      sidebar.payCostsOfSelectedItem(Config.vehicle_damage);
      this.isDead = true;
      // is on target
      //println("enemey arrived at heart");
      return;
    }
        
    vel.x = target.x - pos.x;
    vel.y = target.y - pos.y;
    vel.limit(maxSpeed);
    
    vel = checkNextStep(vel);
    
    if (vel != null) {
      vel.normalize();
      vel.limit(maxSpeed);
    
      pos.add(vel);
    }
  }
  
  void animationUpdate() {
    frame++;
  }
  
  void draw() {
    //fill(RGBtoCMY((int)red(c),(int)green(c),(int)blue(c), 1));
    //noStroke();
    //ellipse(pos.x, pos.y, radius*2, radius*2);
    
    if ( isAlive() ) {
      if ( walkingLeft() ) {
        image(left[frame % 4], pos.x, pos.y);
      } else {
        image(right[frame % 4], pos.x, pos.y);
      }  
    } else {
      if ( walkingLeft() ) {
        image(deadLeft[frame % 3], pos.x, pos.y);
      } else {
        image(deadRight[frame % 3], pos.x, pos.y);
      }
      
      if (frame >= 3) {
        deadAnimationOver();
      }
    }
  }
  
  PVector checkNextStep(PVector _vel)
  {  
      final int offsetBottom = 5;
      
      bgBitmap.loadPixels();

      PVector newPosLeft = new PVector(pos.x - offsetToEdge, pos.y + _vel.y*offsetBottom);
      if (!isPositionInBounds(newPosLeft) ) {
        return null;
      }
      color cLeft = bgBitmap.pixels[(int)newPosLeft.y*bgBitmap.width + (int)newPosLeft.x];
      
      PVector newPosRight = new PVector(pos.x + offsetToEdge, pos.y + _vel.y*offsetBottom);
      if (!isPositionInBounds(newPosRight) ) {
        return null;
      }
      color cRight = bgBitmap.pixels[(int)newPosRight.y*bgBitmap.width + (int)newPosRight.x];
              
      if ( brightness(cLeft) == 0 ){
        _vel = new PVector( (offsetBottom + 3), _vel.y);
      } else if ( brightness(cRight) == 0 ){
        _vel = new PVector( -(offsetBottom+ 3), _vel.y);
        return _vel;
      }
      
     /*
      PVector newPosDown = new PVector(pos.x + _vel.x, pos.y + _vel.y*offsetBottom);
      if (!isPositionInBounds(newPosDown) ) {
        return null;
      }
      color cDown = bgBitmap.pixels[(int)newPosDown.y*bgBitmap.width + (int)newPosDown.x];
          
      if ( brightness(cDown) == 0 ) {
       _vel.y = 0;
      }
      */
        
      return _vel;
  }
}

boolean isPositionInBounds(PVector vec) {
  if ( vec.x < 0 || vec.y < 0 || vec.x > width || vec.y > height ) {
    return false;
  }
  return true;
}


class VehicleContainer{
  boolean isRGB;
  String vC;
  PImage[] left;
  PImage[] deadLeft;
  PImage[] right;
  PImage[] deadRight;
  
  VehicleContainer(String _c, boolean _isRGB){
    boolean isRGB = _isRGB;
    vC = _c;
  }
  
}




