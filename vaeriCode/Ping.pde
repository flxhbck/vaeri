class Ping
{
  Ani animation;

  PVector pos;
  float radius;
  int r, g, b;

  boolean isHeart;
  boolean dead = false;

  /*
  fatherID muss eine ArrayList sein, alle fatherIDs müssen weitergeleitet werden
   */
  ArrayList<Integer> fatherIDs;

  ArrayList<Integer> collidedObjects;

  Ping(PVector pos, int _r, int _g, int _b, boolean _isHeart, int _fatherID)
  {
    this.pos = pos;

    this.r = _r;
    this.g = _g;
    this.b = _b;

    this.radius = 0;
    this.isHeart = _isHeart;
    
    if (isHeart) {
      radius = Config.heart_startRadius;
      animation = new Ani(this, Config.ping_animationDuration, "radius", Config.heart_maxRadius, Ani.LINEAR);
    } else {
      radius = 0;
      animation = new Ani(this, Config.ping_animationDuration, "radius", Config.ping_maxRadius, Ani.LINEAR);
    }
    
    fatherIDs = new ArrayList<Integer>();
    fatherIDs.add(_fatherID);

    collidedObjects = new ArrayList<Integer>();
  }

  void update()
  {
    if (!isHeart) {
      if ( (radius == Config.ping_maxRadius)) dead = true;
    } else {
      // isHeart
      if ( (radius == Config.heart_maxRadius)) dead = true;
    }
  }


  void draw()
  {

    float sizePercentage = 1;
    if (!isHeart) {
      sizePercentage = (Config.ping_maxRadius - radius)/Config.ping_maxRadius;
    }
    strokeWeight(sizePercentage*4 + 1);

    stroke(RGBtoCMY(r,g,b, Config.ping_transparency));
    if (!isHeart) fill(RGBtoCMY(r,g,b, Config.ping_transparency));
    if (isHeart) noFill();

    //fill((r*tMult), (g*tMult), (b*tMult));

    ellipse(pos.x, pos.y, 2*radius, 2*radius);
  }
  
  void draw(boolean fill){
    fill(RGBtoCMY(r,g,b, 1));
    ellipse(pos.x, pos.y, 2*radius, 2*radius);
  }

  void endCycle()
  {
    animation.start();

    for (int i = collidedObjects.size()-1; i >= 0; i--) {
      collidedObjects.remove(i);
    }
  }

  void notifyCollision( int id )
  {
    collidedObjects.add(id);
  }

  boolean alreadyCollided( int id ) {
    for (int i = collidedObjects.size()-1; i >= 0; i--) {
      int listID = (int) collidedObjects.get(i);
      if ( listID == id) return true;
    }
    return false;
  }
}

