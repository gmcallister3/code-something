int w = 1000;
int h = 750;

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
boolean lightSpeedOn = false;
boolean forceFieldActivated = false;

//Button functionality
float bx = 510;
float by = 515;
int buttonSize = 8;

//Space functionality
boolean lightSpeed = false;
int lsx = w - 20;
int lsy = h - 20;
int lssize = 20;

int numStars = 100;


void settings() {
  size(w, h);
}

/*
 * This method is run once by Processing.
 */
void setup() {
  background(0);
}

/*
 * This method is continuously run every frame.
 *
 * https://processing.org/examples/setupdraw.html
 */
void draw() {
  background(0);
  
  //Draws the corner button.
  drawLightSpeedButton();
  
  bx = hx+10;
  by = hy+15;
  
  drawStars(); 
  
  activateForceField();
  drawForceField();
  
  //set the handle color
  fill(100);
  stroke(0);
  //draw the handle
  rect(hx, hy, handleWidth, handleLength);
  
  //set the button color
  fill(0, 255, 0);
  stroke(0);
  //draw the green button
  ellipse(bx, by, buttonSize, buttonSize);
  //if you hover over the button, make it white to incicate clicability.
  if(overButton()){
    fill(255);
    stroke(0);
    ellipse(bx, by, buttonSize, buttonSize);
  }
  
  drawLightsaber();
  
}

/*
 * Built in function mousePressed is called whenever
 * the mouse is pressed. You can add actions based on when
 * this function is called.
 */
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
  
  if (overLightSpeed()) {
    lightSpeedOn = !lightSpeedOn;
  }
  xOffset = mouseX-bx; 
  yOffset = mouseY-by;
}

/*
 * Built in function mouseDragged is called whenever
 * the mouse is dragged. You can add actions based on when
 * this function is called.
 */
void mouseDragged() {
  //Mouse lock is to used to move the handle when dragged
  if(mouseLock) {
    hx = mouseX-xOffset; 
    hy = mouseY-yOffset; 
  }
  
}

/*
 * Built in function mousePressed is called whenever
 * the mouse is released. You can add actions based on when
 * this function is called.
 */
void mouseReleased() {
  //release the handle when button released from drag.
  mouseLock = false;
}

void drawLightsaber(){
   if(saberOn){
     fill(0, 255, 0);
     stroke(0);
     rect(hx, hy-saberLength, handleWidth, saberLength);
   } 
}

/*
 *  Return true if mouse position is above LS button
 */
boolean overButton(){
  if (mouseX > bx-buttonSize && mouseX < bx+buttonSize && 
      mouseY > by-buttonSize && mouseY < by+buttonSize) {
    return true;
  }
  return false;
}

/*
 * Return true if mouse position over Lightspeed button
 */ 
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

//Handles drawing lightSpeedOn (green) and Off (red)
void drawLightSpeedButton(){
  if (lightSpeedOn) {
    fill(0,255,0);
    stroke(0);
    ellipse(lsx, lsy, lssize, lssize);
  } else {
    fill(255,0,0);
    stroke(0);
    ellipse(lsx, lsy, lssize, lssize);
  }
  
}

/*
 * Draw random stars in space.
 */
void drawStars(){
  if (lightSpeedOn) {
    fill(255);
    stroke(0);
    for(int i = 0; i < numStars; i++){
      float m = random(2);
      if(m!=0){
        float f = random(w);
        float y = random(h);
        ellipse(f, y, 5,5);
      }
    }
  }
}

void activateForceField() {
  forceFieldActivated = saberOn && lightSpeedOn;
}

void drawForceField() {
  if (forceFieldActivated) {
     stroke(0, 255, 0);
     fill(0);
     float centerBeamX = hx + (handleWidth / 2);
     float centerBeamY = hy - (saberLength / 2);
     ellipse(centerBeamX, centerBeamY, 300, 500);
  }
}