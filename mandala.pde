boolean filled=true;
int manyCircles;
int manyPetals;
float step = 0.02;
ci []circlesNum;
color clrTable[] = {
    #ef52d7, #ea68f9, #cb7cf8, #a27cf8,
    #80e1e0, #80e1c0, #9bf1ab, #cdff9d,
    #eeff9d, #fff79d, #ffe79d, #f35743,
    #c91235, #e3429d, #d472c0, #3982f1,
    #4e47ed, #fd7da4, #e0dc61, #fde39f
  };

void setup() {
  size(800, 600);

  startAnew();
}

void startAnew() {
  manyCircles=int(random(6, 18));
  manyPetals = int(random(6, 12));
  background(0);
  circlesNum = new ci[manyCircles];
  for (int i=0; i< manyCircles; i++) {
    circlesNum[i] = new ci(random(-width/10, width/2), random(width/16, width/6));
  }
}
void draw() {
  for (int i=0; i< manyCircles; i++) {
    circlesNum[i].update();
    circlesNum[i].drawc();
  }
}

void mouseReleased() {
  startAnew();
}

void keyPressed()
{ 
  if (key == 's' || key == 'S') {
    int numR = int(random(5000));
    String fname="snapshots/fl_" + frameCount +"_" + numR + ".png";
    PImage scrShot;
    scrShot=get();
    scrShot.save(fname);
  }
  if (key == 'f' || key == 'F') {
    filled = !filled;
    startAnew();
  }
}

class ci {
  PVector spot;
  PVector eli;
  float bigRadius;
  float penRadius;
  int clrIndex;
  float acc;
  ci(float br, float pr) {
    eli = new PVector(6, 6, 0);
    spot = new PVector(0, 0, 0);
    bigRadius = br;
    penRadius = pr;
    spot.y = bigRadius;
    clrIndex = int(random(10000)) % clrTable.length;
  }
  void update() {
    acc += step;
    spot.y +=  min(manyPetals * sin(acc * PI)/2, width/2);
    spot.x +=  min(manyPetals * cos(acc * PI)/2, width/2);
    eli.x = abs(sin(acc * PI) * penRadius/3);
    eli.y = abs(cos(acc * PI) * penRadius/3);
  }

  void drawc() {
    if (acc <= TWO_PI * 7) {
      strokeWeight(0.8);
      stroke(clrTable[clrIndex], 200);
      if (filled) {
        fill(clrTable[clrIndex], 80);
      }
      else {
        noFill();    
      }
      pushMatrix();
      translate(width/2, height/2);
      rotate(acc);
      ellipse(spot.x, spot.y, eli.x, eli.y);
      popMatrix();
    }
  }
}
