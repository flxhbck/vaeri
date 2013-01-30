void keyTyped()
{
  if (key == '1' )
  {
    gui.checkCyan();
  }
  
  if (key == '2' )
  {
    gui.checkMagenta();
  }  
    
  if (key == '3' )
  {
    gui.checkYellow();
  }
  
  if (key == '4' )
  {
    gui.checkRed();
  }
  
  if (key == '5' )
  {
    gui.checkGreen();
  }
  
  if (key == '6' )
  {
    gui.checkBlue();
  }
  
  
  if (key == 't' || key == 'T')
  {
    gui.chooseTower();
  } 
  
  if (key == 'e' || key == 'E')
  {
    gui.chooseEmitter();
  } 
    
}

void mouseMoved() {
  if (gui.hasTempTower){
    gui.tempTower.pos.x = mouseX;
    gui.tempTower.pos.y = mouseY;
  }
  
  if (gui.hasTempEmitter){
    gui.tempEmitter.pos.x = mouseX;
    gui.tempEmitter.pos.y = mouseY;
  }
}


void mouseReleased()
{
  if (hasTempTower){
    towers.add(tempTower);
    hasTempTower = false;
  }
  
  if (hasTempEmitter){
    emitters.add(tempEmitter);
    hasTempEmitter = false;
  }
}

void mouseClicked()
{
  gui.checkHitbox(new PVector(mouseX, mouseY));
}
