// Fernanda Moreno
// LMC 2700 Project 2: Tooling

import ddf.minim.*;
PShape star;

int x, y, x0, y0, firstPress;
float sound = 0;
int starArray[] = new int[5];

//twinkling stars
int[] starX = new int[1000];
int[] starY = new int[1000];
color[] starColor = new color[1000];
int starSize = 3; //size of the twinkling stars

Minim minim;
AudioInput in;

void setup() {
  firstPress = 1;
  size(1000,661);
  colorMode(HSB, 360);
  background(#050F64);
  
  //star locations
  for (int i = 0; i < starX.length; i++) {
    starX[i] =(int)random(width);
    starY[i] = (int)random(height);
    starColor[i] = color((int)random(100,255));
  }
  star = createShape();
  star.beginShape();
  star.vertex(0, -25);
  star.vertex(7, -10);
  star.vertex(23.5, -7.5);
  star.vertex(11.5, 3.5);
  star.vertex(14.5, 20);
  star.vertex(0, 12.5);
  star.vertex(-14.5, 20);
  star.vertex(-11.5, 3.5);
  star.vertex(-23.5, -7.5);
  star.vertex(-7, -10);
  star.endShape(CLOSE);
  star.setFill(color(255,255,0));
  star.setStroke(0);
  star.setStrokeWeight(1.5);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO);
}

void draw() {
  twinkle();
  if (mousePressed == true && firstPress == 1) {
    firstPress = 0;
    x0 = mouseX;
    y0 = mouseY;
    point(x0, y0);
    fill(58,80,99);
    shape(star, x0, y0);
  }
  if (mousePressed == true && firstPress == 0) {
    x = mouseX;
    y = mouseY;
    point(x,y);
    line(x0,y0,x,y);
    x0 = x;
    y0 = y;
    translate(mouseX, mouseY);
    shape(star);
  }
  star.setFill(color(15,55,99));
  sound += 1 * in.mix.level();       
  sound = constrain(sound, 0, 1);
  sound = lerp(sound, 0, 0.03); 
  colorMode(HSB, 100);
  stroke(color(map(sound, 0, 1, 0, 100),map(sound, 0, 1, 0, 100),map(sound, 0, 1, 0, 100)));

}

void keyPressed() {
  if (key == ' ') {
    setup();
  }
}

void twinkle() {
  for (int i = 0; i < starX.length; i++) {
    fill(random(50,255)); // makes them twinkle
    if (random(10) < 1) {
       starColor[i] = (int)random(100,255);
    }
    fill(starColor[i]);
    
    ellipse(starX[i], starY[i], starSize, starSize);
  }
}
