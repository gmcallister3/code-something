int w = 1000;
int h = 800;

//Mouse Functionality
boolean mouseLock = false;
float xOffset = 0.0; 
float yOffset = 0.0; 

//Handle & Saber functionality
float hx = 500;
float hy = 500;
int handleLength = 80;
int handleWidth = 20;
int saberLength = 300;
boolean saberOn = false;

//Button functionality
float bx = 510;
float by = 515;
int buttonSize = 8;

//Space functionality
boolean lightSpeed = false;
int lsx = w - 20;
int lsy = h - 20;
int lssize = 20;


void settings() {
  size(w, h);
}

void setup() {
  background(0);
  
}

void draw() {
  background(0);
  
  drawLightSpeedButton();
  
  if(overLightSpeed()){
    drawStars();
  }
  
  bx = hx+10;
  by = hy+15;
 
  fill(100);
  rect(hx, hy, handleWidth, handleLength);
  
  fill(0, 255, 0);
  ellipse(bx, by, buttonSize, buttonSize);
  if(overButton()){
    fill(255);
    ellipse(bx, by, buttonSize, buttonSize);
  }
  drawLightsaber();
}

void mousePressed() {
  if(overHandle()){
    mouseLock = true;
  }
  if(overButton()) { 
    saberOn = !saberOn; 
  }
  else if(!overHandle()){
    mouseLock = false;
  }
  xOffset = mouseX-bx; 
  yOffset = mouseY-by;
}

void mouseDragged() {
  if(mouseLock) {
    hx = mouseX-xOffset; 
    hy = mouseY-yOffset; 
  }
}

void mouseReleased() {
  mouseLock = false;
}

void drawLightsaber(){
   if(saberOn){
     fill(0, 255, 0);
     rect(hx, hy-saberLength, handleWidth, saberLength);
   } 
}

boolean overButton(){
  if (mouseX > bx-buttonSize && mouseX < bx+buttonSize && 
      mouseY > by-buttonSize && mouseY < by+buttonSize) {
    return true;
  }
  return false;
}

boolean overLightSpeed(){
  if (mouseX > lsx-lssize && mouseX < lsx+lssize && 
      mouseY > lsy-lssize && mouseY < lsy+lssize) {
    return true;
  }
  return false;
}

boolean overHandle(){
    if (mouseX > hx-handleWidth && mouseX < hx+handleWidth && 
      mouseY > hy-handleLength && mouseY < hy+handleLength) {
    return true;
  }
  return false;
}

void drawLightSpeedButton(){
  fill(255,0,0);
  ellipse(lsx, lsy, lssize, lssize);
}


void drawStars(){
  fill(255);
  for(int i = 0; i < 100; i++){
    float m = random(2);
    if(m!=0){
      float f = random(w);
      float y = random(h);
      ellipse(f, y, 5,5);
    }
  }
}