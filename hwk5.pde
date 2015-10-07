import ddf.minim.*;

class Ball {
  float x, y;
  float vx, vy;
  float size = 10;
  color c;

  Ball(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    
    // Controls the speed of ball
    vx = random(1)+1.5;
    vy = random(1);
  }

  void draw() {
    noStroke();
    fill(255);
    ellipse(x, y, size*2, size*2);
  }

  void reset() {
    x=x;
    y=y;
    vx =random(1)+1.5;
    if (random(1) < 0.5) {
      vx = -vx;
    }
    vy = random(1) - 1.5;
  }

  void move() {
    x += vx;
    y += vy;
    if (x < size || x > width-size) {
      vx = -vx;
    }
    if (y < size || y > height-size) {
      vy = -vy;
    }
    if (x-size < p1.x + p1.w) {
      if (y > p1.y &&
        y < p1.y + p1.h) {
        vx = -vx*1.5;
        ping.trigger();
      } else {
        rightScore++;
        reset();
        bam.trigger();
      }
    }
    if (x+size > p2.x) {
      if (y > p2.y &&
        y < p2.y + p2.h) {
        vx = -vx*1.5;
        ping.trigger();
      } else {
        leftScore++;
        reset();
        bam.trigger();
      }
    }
  }
}

class Paddle {
  float x, y, vy, w = 20, h = 80; 
  color c;

  Paddle(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    vy = 0;
  }

  void draw() {
    noStroke();
    rect(x, y, w, h);
    fill(255);
  }

  void move() {
    y += vy;
    if (y < 0 || y > height-h) {
      vy = 0;
      y = constrain(y, 0, height-h);
    }
  }
}

ArrayList <Ball> list;
Paddle p1, p2;
int leftScore = 0;
int rightScore = 0;


import ddf.minim.*;

Minim minim;
AudioSample ping;
AudioSample bam;

void setup() {
  size(500, 500);
  colorMode(HSB);
  list = new ArrayList<Ball>();
  list.add(new Ball(width*0.5, height*0.5, color(random(255), 255, 255)));

  p1 = new Paddle(15, 200, color(255));
  p2 = new Paddle(width-30, 200, color(255));

  {
    minim = new Minim(this);


    ping = minim.loadSample( "ping.mp3", 512);
    if ( ping == null ) println("Didn't get kick!");

    bam = minim.loadSample("bam.mp3", 512);
    if ( bam == null ) println("Didn't get bam!");
  }
}

void drawScores() {
  textSize(40);
  text(""+leftScore, width/2-40, 60);
  text(""+rightScore, width/2+20, 60);
}

void draw() {
  background(0);

  for (int i = 0; i < list.size(); i += 1) {
    list.get(i).draw();
    list.get(i).move();
  }

  p1.move();
  p1.draw();
  p2.move();
  p2.draw();
  drawScores();
}

//keypress up and down for each paddles 
void keyPressed() {
  if (key == 'a') {
    p1.vy = -5;
  }
  if (key == 'z') {
    p1.vy = 5;
  }
  if (key == 'k') {
    p2.vy = -5;
  }
  if (key == 'm') {
    p2.vy = 5;
  }
}

void keyReleased() {
  if (key == 'a' && p1.vy < 0) {
    p1.vy = 0;
  }
  if (key == 'z' && p1.vy > 0) {
    p1.vy = 0;
  }
  if (key == 'l' && p2.vy < 0) {
    p2.vy = 0;
  }
  if (key == 'm' && p2.vy > 0) {
    p2.vy = 0;
  }
}
