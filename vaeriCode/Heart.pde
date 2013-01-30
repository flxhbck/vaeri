class Heart
{ 
  
  PVector pos;
  float radius;
  int r,g,b;
  
  Ping ping1;
  Ping ping2;
  
  float dummy_delay = 0;
  
  Heart(PVector pos, int _r, int _g, int _b)
  {
    this.pos = pos;
      
    this.r = _r;
    this.g = _g;
    this.b = _b;
    
    this.radius = 10;
    /*
    ping1 = new Ping(this.pos, 255, 255, 255, true, 0);
    pings.add(ping1);
    
    Ani.to(this, Config.heart_ping2_delay, "dummy_delay", 10, Ani.LINEAR, "onEnd:setDelayedPing");
    */
  }
  /*
  void setDelayedPing() {
    ping2 = new Ping(this.pos, 255, 255, 255, true, 0);
    pings.add(ping2);
  }
  */
  
  void update()
  {
    
  }
  
  void draw()
  {
    
    fill(RGBtoCMY(r,g,b, Config.ping_transparency));
    ellipse(pos.x, pos.y, 2*radius, 2*radius);
  }
  
  
  void setPosition(PVector pos){
    this.pos = pos;
  }
  
}
