
int howmanybricks = 30;
float [][] brickcoordinates;
float randomcoordinatex = 0.0;
float randomcoordinatey = 0.0;
float brickwidth = 100.0;
float brickheight = 30.0;
float paddlewidth = 150.0;
float paddleheight = 30.0;
float paddleX = mouseX;
float ballx = 500;
float bally = 1500;
float ballspeedx = -10;
float ballspeedy = -10;
float balldiameter = 30;
float dummy = 0;
float counter = 0;
boolean canusecoordinates;

void setup(){
  size(1000,2000);
  background(255);
  
  brickcoordinates = new float[2][howmanybricks];
  
  for (int i=0;i<2;i++){
    for (int j=0;j<howmanybricks;j++){
      brickcoordinates[i][j] = 0.0;
    }
  }
 
  
  for(int j=0;j<howmanybricks;j++){
    canusecoordinates=false;
    while(canusecoordinates==false){
      
      counter = 0;
      randomcoordinatex = random(brickwidth, 1000-brickwidth);
      randomcoordinatey = random(brickheight, 1000-brickheight);
      canusecoordinates = true;
     
      
      for (int z=0;z<howmanybricks;z++){
        if ((randomcoordinatex > (brickcoordinates[0][z]-2*brickwidth))&&(randomcoordinatex < (brickcoordinates[0][z]+2*brickwidth))){
          if ((randomcoordinatey > (brickcoordinates[1][z]-2*brickheight))&&(randomcoordinatey < (brickcoordinates[1][z]+2*brickheight))){
           canusecoordinates = false;
          }
        }

      }
      
      if (canusecoordinates==true){
        brickcoordinates[0][j] = randomcoordinatex;
        brickcoordinates[1][j] = randomcoordinatey;
        break;
      }
      
      if (counter==100){
        break;
      }
      counter++;
    }
  }
  


}

void draw(){
  background(255);
  ballMove();
  rectMode(CENTER);
  fill(100);
  for(int j=0;j<howmanybricks;j++){
    ballhitbrick(j, brickcoordinates[0][j], brickcoordinates[1][j],brickwidth,brickheight);
    rect(brickcoordinates[0][j], brickcoordinates[1][j], brickwidth, brickheight);
  }
  ellipse(ballx,bally,balldiameter,balldiameter);
  rect(paddleX, 1950, paddlewidth, paddleheight);
  
}

void ballMove(){
  
  ballhit();
  ballx = ballx + ballspeedx;
  bally = bally + ballspeedy;
  
}


void ballhit(){
   
  if (bally < balldiameter/2){
    bally = balldiameter/2;
  }
  
  if (bally == balldiameter/2){
    ballspeedy = -(ballspeedy);
  }
  
  
  if (ballx < balldiameter/2){
    ballx = balldiameter/2;
  }
  
  if (ballx == balldiameter/2){
    ballspeedx = -(ballspeedx);
  }
  
  if (ballx > (1000-balldiameter/2)){
    ballx = 1000-balldiameter/2;
  }
  
  if (ballx == (1000-balldiameter/2)){
    ballspeedx = -(ballspeedx);
  }
  
  
  if (ballx<(paddleX+paddlewidth) && ballx>(paddleX-paddlewidth) && bally>(1950-paddleheight-balldiameter/2)){
    ballspeedy = -(ballspeedy);
    ballspeedx = ballspeedx*(((ballx-paddleX)/sqrt((ballx-paddleX)*(ballx-paddleX)))+random(5)/1000);
  }
 

  
}

void ballhitbrick(int j, float brickx, float bricky, float brickwidth, float brickheight){
  
  if ((bally+(balldiameter/2)>bricky-brickheight) && (bally-(balldiameter/2)<bricky+brickheight) && (ballx+(balldiameter/2)>brickx-brickwidth) && (ballx < brickx)  && (ballx>brickx-brickwidth) && ballspeedx > 0){
    ballspeedx = -(ballspeedx);
    brickcoordinates[0][j] = -100000;
    brickcoordinates[1][j] = -100000;
    return;
  }
  
  if ((bally+(balldiameter/2)>bricky-brickheight) && (bally-(balldiameter/2)<bricky+brickheight) && (ballx-(balldiameter/2)<brickx+brickwidth) && (ballx > brickx) && (ballx<brickx+brickwidth) && ballspeedx < 0){
    ballspeedx = -(ballspeedx);
    brickcoordinates[0][j] = -100000;
    brickcoordinates[1][j] = -100000;
    return;
  }
  
  if ((ballx+(balldiameter/2)>brickx-brickwidth) && (ballx-(balldiameter/2)<brickx+brickwidth) && (bally+(balldiameter/2)>bricky-brickheight) && (bally > bricky) && (bally<bricky+brickheight) && ballspeedy > 0){
    ballspeedy = -(ballspeedy);
    brickcoordinates[0][j] = -100000;
    brickcoordinates[1][j] = -100000;
    return;
  }
  
    if ((ballx+(balldiameter/2)>brickx-brickwidth) && (ballx-(balldiameter/2)<brickx+brickwidth) && (bally-(balldiameter/2)<bricky+brickheight) && (bally < bricky) && (bally>bricky-brickheight) && ballspeedy < 0){
    ballspeedy = -(ballspeedy);
    brickcoordinates[0][j] = -100000;
    brickcoordinates[1][j] = -100000;
    return;
  }

  
  
  
  
}


void mouseMoved(){

   rectMode(CENTER);
   paddleX = mouseX;
   rect(paddleX, 1950, paddlewidth, paddleheight);

}