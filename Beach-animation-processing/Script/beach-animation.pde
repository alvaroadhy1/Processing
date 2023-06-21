int mov = 1;
float skala = 0.0001;
int cols, rows;
int scl=20;
int  w=1050;
int h=2200;
float valueX, valueY, tangkapX, tangkapY;
float xKapal;
int iKapal;

float flying = 0;

float[][] terrain;

float vol;
int volume;
boolean play = true;
import processing.sound.*;
SoundFile file;

void setup() {
  // sound 
  file = new SoundFile(this, "./../Assets/ombak.mp3");
  file.play();
  
  size(1200, 600, P3D);
  valueX = 0;
  valueY = 0;
  cols = w / scl;
  rows = h / scl;
  xKapal = 0;
  iKapal = 0;
  terrain = new float[cols][rows];
  frameRate(70); //240
  
  vol = 0.5;
  volume = 5;
}

void draw() {
  file.amp(vol);
  if(xKapal >= 299){
      iKapal = 0;
      xKapal -= 2;
  }
  if(xKapal <= 1){
      iKapal = 0;
      xKapal += 2;
  }
  mov = mov +1;
  if (mov >= 2600) {
    mov = 1;
    skala = 0.0001;
  }
  int trns = -mouseX+600;
  
  translate(map(trns,-600,600,0,100),0,0);
  background(185 + mov/6, 230 - mov/7, 250 - mov/6);
  lights();
  
  langit();
  bumi();
  
  fill(0,255,0);
  textSize(32);
  text("Volume : "+volume,10,30);
}

void keyPressed(){
  if(keyCode == RIGHT && xKapal <= 300){
      iKapal = 2;
  }else if(keyCode == LEFT && xKapal >= 0){
      iKapal = -2;
  }
}

void keyTyped(){
  if (key == ' '){
    if (play == true){
      file.pause();
      play = false;
    }else{
      file.play();
      play = true;
    }
  }else if(key == '=' && vol<=1){
    vol += .1;
    volume += 1;
  }else if(key == '-' && vol>=0){
    vol -= .1;
    volume -= 1;
  }
}

void keyReleased(){
  if(keyCode == RIGHT){
    iKapal = 0;
  }else if(keyCode == LEFT){
    iKapal = 0;
  }
}

void awan(int x, int y, float scale){
  fill(255-mov/11);
  pushMatrix();
  scale(scale);
    ellipse (x+465-mov/10, y+100, 40, 40);
    ellipse (x+575-mov/10, y+90, 60, 60);
    ellipse (x+515-mov/10, y+80, 80, 80);
    rect (x+465-mov/10, y+100, 110, 20);
  popMatrix();
}

void langitMalam(){
  fill(0, 0, 0, mov/4-100);
  rect(-2500, -2000, 4200, 3500);
}

void matahari(){
  float skel = 1-skala;
  float rotasi = map(mov, 0, 360, 0, 10.3);
  if (mov >= 2600) {
    skala = 0.0001;
    skel = 1;
    rotasi=0;
  }
  skala += 0.00038;
  pushMatrix();
    rotate(radians(rotasi*-1));
    scale(skel);
    noStroke();
    fill(255, 255 - mov/8, 0);
    ellipse (-500, -2000, 500, 500);
  popMatrix();
}

void bulan(){
  pushMatrix();
    translate(-1900,-1900,0);
    scale(2.5);
    noStroke();
    fill(255, 255, 255, -50+mov/6);
    beginShape();
      vertex(250,60);
      bezierVertex(180,60, 180,150, 250,150);
      bezierVertex(130,190 ,130,20, 250,60);
    endShape();
  popMatrix();
}

void langit() {
  pushMatrix();
    translate(1000,1200,-1200);
    langitMalam();
    bulan();
    matahari();
    awan(-1000,-500, 3.8);
    awan(-800,-450, 4);
    awan(-700,-600, 2.5);
    awan(-500,-600, 2.7);
    awan(-300,-590, 3.6);
    awan(0,-600, 3);
    awan(200,-550, 3);
    
    
    //strokeWeight(10);
    //stroke(0,255,0);
    //point(0,0);
  popMatrix();
}

void kapal() {
  noStroke();
  xKapal += iKapal;
  pushMatrix();
    translate(0,-295,0);
    scale(2.0);
    fill(255);
    triangle(30+xKapal,311,  50+xKapal,310,  28+xKapal,275);
    triangle(27+xKapal,311,  10+xKapal,  242+70,  25+xKapal,280);
    fill(120, 90, 70);
    quad (8+xKapal,325,  50+xKapal,325,  58+xKapal,312,  0+xKapal,315);
  popMatrix();
}

void tengahKursi(){
  fill(#8B4513);
  quad(360,332, 400,374,  416,365 ,375,324);
  quad(375,324, 416,365,  435,360 ,393,317);
  quad(393,317, 435,360,  452,354 ,412,312);
  quad(412,312, 452,354,  470,350 ,432,309);
  quad(432,309, 470,350,  489,347 ,453,307);
  quad(453,307, 489,347,  512,345 ,474,304);
  quad(474,304, 512,345,  536,342 ,500,302);
  quad(500,302, 536,342,  560,341 ,526,302);
  quad(526,302, 560,341,  587,341 ,553,300);
  quad(553,300, 587,341,  613,337 ,581,300);
  quad(581,300, 613,337,  644,337 ,610,300);
  
  quad(619,293, 659,333,  670,310, 629,272);
  quad(629,272, 670,310,  682,283, 642,247);
  quad(642,247, 682,283,  695,258, 655,222);
}

void kayuKursi(int x, int y){
  pushMatrix();
  fill(#8B4513);
  rect(596+x,300+y, 10,50);
  
  fill(#CD853F);
  beginShape();
  vertex(606+x,300+y);
  quadraticVertex(350+x,300+y, 350+x,350+y);
  vertex(335+x,350+y);
  quadraticVertex(335+x,290+y, 606+x,287+y);
  vertex(650+x,200+y);
  vertex(665+x,200+y);
  vertex(615+x,300+y);
  endShape(CLOSE);
  
  
  fill(#8B4513);
  beginShape();
  //noStroke();
  vertex(621+x,255+y);
  quadraticVertex(550+x,250+y, 550+x,287+y);
  vertex(545+x,288+y);
  quadraticVertex(544+x,245+y, 625+x,249+y);
  endShape(CLOSE);
  popMatrix();
}

void bola() {
  pushMatrix();
    translate(-300,0,150);
    scale(1.5);
    strokeWeight(1);
    stroke(0);
  
    fill(255, 250, 10);
    arc(590, 350, 30, 30, 0, PI*1/5);
  
    fill(255);
    arc(590, 350, 30, 30, PI*1/5, PI*2/5, PIE);
  
    fill(255, 10, 200);
    arc(590, 350, 30, 30, PI*2/5, PI*3/5, PIE);
  
    fill(255);
    arc(590, 350, 30, 30, PI*3/5, PI*4/5, PIE);
  
    fill(10, 255, 50);
    arc(590, 350, 30, 30, PI*4/5, PI*5/5, PIE);
  
    fill(255);
    arc(590, 350, 30, 30, PI*5/5, PI*6/5, PIE);
  
    fill(255, 150, 10);
    arc(590, 350, 30, 30, PI*6/5, PI*7/5, PIE);
  
    fill(255);
    arc(590, 350, 30, 30, PI*7/5, PI*8/5, PIE);
  
    fill(10, 100, 255);
    arc(590, 350, 30, 30, PI*8/5, PI*9/5, PIE);
  
    fill(255);
    arc(590, 350, 30, 30, PI*9/5, PI*10/5, PIE);
    
  popMatrix();
}

void payung(){
  pushMatrix();
    rotate(radians(12));
    translate(0,-100,2);
    fill(#FF7F50);
    triangle(450,200, 600,150, 750,200);
    line(600,150, 470,200);
    line(600,150, 490,200);
    line(600,150, 510,200);
    line(600,150, 530,200);
    line(600,150, 550,200);
    line(600,150, 570,200);
    line(600,150, 590,200);
    line(600,150, 610,200);
    line(600,150, 630,200);
    line(600,150, 650,200);
    line(600,150, 670,200);
    line(600,150, 690,200);
    line(600,150, 710,200);
    line(600,150, 730,200);
    line(600,150, 750,200);
    
    fill(0);
    rect(596,200, 10,50);
    rect(596,250, 10,50);
    rect(596,300, 10,50);
    rect(596,350, 10,50);
  popMatrix();
  
  pushMatrix();
    translate(-200,-100);
    bola();
  popMatrix(); 
}

void kursiPantai(int x, int y, int z, float scl){
  strokeWeight(1);
  stroke(0);
  pushMatrix();
    rotate(radians(3));
    scale(scl);
    translate(x,y,z);
    kayuKursi(0,0);
    tengahKursi();
    kayuKursi(50,50);
    payung();
  popMatrix();
}

void daun1(int x, int y, int rotasi, float stroke){
  noFill();
  pushMatrix();
    translate(x,y);
    rotate(radians(rotasi));
    for(int i=0;i<=16;i++){
      int penjumlah = 0;
      if(i>=12){
        penjumlah -=2;
      }if(i>=9){
        penjumlah -=2;
      }if(i>=6){
        penjumlah +=2;
      }if(i>=3){
        penjumlah +=2;
      }
      strokeWeight(stroke);
      stroke(0,180,0);
      line(0+(i*5)-penjumlah,0-penjumlah,0+20+(i*5)-penjumlah,0+10-penjumlah);
    }
    strokeWeight(stroke*2.5);
    stroke(0,150,0);
    bezier(0, 0, 0, -5, 80, -5, 80, 0);
  popMatrix();
}

void daun2(int x, int y, int rotasi, float stroke){
  noFill();
  pushMatrix();
    translate(x,y);
    rotate(radians(rotasi));
    for(int i=0;i<=16;i++){
      int penjumlah = 0;
      if(i>=14){
        penjumlah -=2;
      }if(i>=12){
        penjumlah -=2;
      }if(i>=6){
        penjumlah +=2;
      }if(i>=3){
        penjumlah +=2;
      }
      stroke(0,180,0);
      strokeWeight(stroke);
      line(0+(i*-5)-penjumlah,0-penjumlah,0-20+(i*-5)-penjumlah,0+10-penjumlah);
    }
    strokeWeight(stroke*2.5);
    stroke(0,150,0);
    bezier(0, 0, 0, -5, -80, -5, -80, 0);
  popMatrix();
}

void semuaDaun(int x, int y, float stroke){
  daun1(x,y,-25, stroke);
  daun1(x,y,30, stroke);
  daun1(x,y,-55, stroke);
  daun1(x,y,-75, stroke);
  daun2(x,y,-45, stroke);
  daun2(x,y,0, stroke);
  daun2(x,y,30, stroke);
}

void kelapa(int x, int y){
  pushMatrix();
  translate(-2,0,5);
    strokeWeight(1);
    stroke(0);
    fill(100,52,23);
    ellipse(x-5,y, 10,10);
    ellipse(x+5,y, 10,10);
    pushMatrix();
      translate(0,0,1);
      ellipse(x,y+5, 10,10);
    popMatrix();
  popMatrix();
}

void pohonKelapa(int x, int y, int z, float stroke){
  pushMatrix();
    translate(-800+x,-1300+y,520+z);
    strokeWeight(1);
    stroke(0);
    fill(216,167,138);
    quad(600,220,  620,220,  610,202,  590,200);
    quad(590,200,  610,202,  601,180,  585,180);
    quad(585,180,  601,180,  595,160,  585,160);
    triangle(585,160, 595,160, 590,120);
    
    strokeWeight(.2);
    fill(0,255,0);
    for(int i=0; i<=4;i++){
      triangle(590+(i*5),230, 595+(i*5),230, 585+(i*5),200);
    }
    for(int i=0; i<=4;i++){
      triangle(605+(i*5),230, 610+(i*5),230, 610+(i*5),200);
    }
    semuaDaun(590,120,stroke);
    kelapa(590,120);
  popMatrix();
}

void pantai(){
  pushMatrix();
    rotate(radians(-7));
    fill(#FFE8AD);
    translate(1150,1450,-420);
    sphere(1200);
    pohonKelapa(530,-100,-450,.5);
    pohonKelapa(130,-100,-350,.5);
    pohonKelapa(-30,-80,-300,.5);
    pohonKelapa(0,0,0,1);
    kursiPantai(-1490,-2500,1450, .44);
  popMatrix();
}

void bumi() {
  pushMatrix();
  pantai();
  kapal();
  translate(width/2, height/2+50);
  rotateX(radians(60+valueX));
  rotateY(radians(valueY));
  translate(width/-2, height/2);
  
  
  flying -= 0.01;

  float yoff = flying;
  for (int y=0; y<rows; y++) {
    float xoff = 0;
    for (int x=0; x<cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -50, 16);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  noStroke();
  fill(0, 111, 193);
  
  translate(width/2, height/2);
  rotateZ(radians(-90));
  translate(-w/32, -h/2);
  
  
  for (int y=0; y<rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x=0; x<cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
  popMatrix();
}
