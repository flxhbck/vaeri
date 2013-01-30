class Emitter
{
  
  PVector pos;
  float radius;
  int r,g,b;
  
  int id;
  
  PImage sprite_c, sprite_m, sprite_y;
  
  
  Emitter(PVector pos, int _r, int _g, int _b, int _id)
  {
    this.pos = pos;
      
    this.r = _r;
    this.g = _g;
    this.b = _b;
    
    this.radius = 10;
    
    this.id = _id;
    
    sprite_c = loadImage("data/emitter_c.png");
    sprite_m = loadImage("data/emitter_m.png");
    sprite_y = loadImage("data/emitter_y.png");
  }
  
  void update()
  {
       
  }
  
  void draw()
  {  
    
    //noStroke();
    //fill(RGBtoCMY(r,g,b,Config.ping_transparency));
    //ellipse(pos.x, pos.y, 2*radius,2*radius);
    if (r == 255 && g == 0 && b == 0){
      image(sprite_c, (int)pos.x, (int)pos.y, sprite_c.width, sprite_c.height);
    } else if (r == 0 && g == 255 && b == 0){
      image(sprite_m, (int)pos.x, (int)pos.y, sprite_m.width, sprite_m.height);
    } else if (r == 0 && g == 0 && b == 255){
      image(sprite_y, (int)pos.x, (int)pos.y, sprite_y.width, sprite_y.height);
    }
  }
  
  void drawRadius(){
    blendMode(MULTIPLY);
    strokeWeight(1);
    fill(RGBtoCMY(r,g,b, Config.ping_transparency));
    ellipse(pos.x, pos.y, Config.ping_maxRadius*2, Config.ping_maxRadius*2);
    blendMode(BLEND);
  }
  
  
  void setPosition(PVector pos)
  {
    this.pos = pos;
  }
  
  Ping createPing(ArrayList<Integer> fIDs)
  {
    Ping newPing = new Ping(pos, r,g,b, false, this.id);
    // dont allow "feedback problem"
    for (int i = fIDs.size()-1; i >= 0; i--) {
      int sourceID = (int)fIDs.get(i);
      newPing.notifyCollision(sourceID);
    }
    pings.add(newPing);
    return newPing;
  }

    
  
  void checkCollision()
  {
  
    for (int i = pings.size()-1; i >= 0; i--) {
      //collision check
      Ping ping = (Ping) pings.get(i);
      
      if ( (this.pos.dist(ping.pos) < (ping.radius + this.radius)) && !ping.alreadyCollided( this.id ) ) {
        
        ping.notifyCollision(this.id);
        
        //checkColorMatch
        if (this.r <= ping.r && this.g <= ping.g && this.b <= ping.b){         
          if (!checkFatherhood(ping)){
            createPing(ping.fatherIDs).notifyCollision(this.id);
          }
        }
      }
      
    }
  }
  
  boolean checkFatherhood(Ping p)
  {
    for (int i = p.fatherIDs.size()-1; i >= 0; i--) {
      int sourceID = (int)p.fatherIDs.get(i);
      if (id == sourceID) return true;
    }
    return false;
  }
  
  void changeColor(int _r, int _g, int _b){
    r = _r;
    g = _g;
    b = _b;
  } 
  
}
