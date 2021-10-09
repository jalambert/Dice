void setup() {
  background(255);
  size(800, 820);
  noLoop();
}
int sum = 0;
int shade = 255;
int tile1 = 0;
int tile2 = 0;
int tile3 = 0;
int count = 0;
int standout1 = 0;
int standout2 = 0;
int standout3 = 0;
int xclick = 0;
int yclick = 0;
boolean rpress = false;
boolean gpress = false;
boolean bpress = false;
int r = 0;
int g = 0;
int b = 0;
int[] rolls = new int[10000];
int i = 0;
int replace = 0;

Die die1;

void draw() {
  stroke(0);
  strokeWeight(10);
  strokeJoin(ROUND);
  fill(192);
  rect(230, 740, 340, 60);
  fill(0);
  textSize(50);
  textAlign(CENTER);
  strokeWeight(1);

  text("Total: " + sum, 400, 790);
  stroke(0);

  rpress = false;
  gpress = false;
  bpress = false;
  if (keyPressed == true && key == 'r') {
    r = 255;
    gpress = false;
    bpress = false;
    rpress = true;
  }
  if (keyPressed == true && key == 'g') {
    g = 255;
    rpress = false;
    bpress = false;
    gpress = true;
  }
  if (keyPressed == true && key == 'b') {
    b = 255;
    rpress = false;
    gpress = false;
    bpress = true;
  }
  if (mousePressed == true && mouseY<720) {
    sum = sum - rolls[xclick+(yclick*20)];
    die1 = new Die(xclick*40, yclick*40);
    die1.show();
    die1.roll();

    rolls[xclick+(yclick*20)] = replace;
    sum = sum + rolls[xclick+(yclick*20)];
    stroke(0);
    strokeWeight(10);
    strokeJoin(ROUND);
    fill(192);
    rect(230, 740, 340, 60);
    fill(0);
    textSize(50);
    textAlign(CENTER);
    strokeWeight(1);

    text("Total: " + sum, 400, 790);
    stroke(0);
  } else {
    sum = 0;
    for (int y = 0; y < 720; y+=40) {
      for (int x = 0; x < 800; x+=40) {
        if (count == tile1-1) {
          standout1 = 0;
        } else {
          standout1 = 1;
        }
        if (count == tile2-1) {
          standout2 = 0;
        } else {
          standout2 = 1;
        }
        if (count == tile3-1) {
          standout3 = 0;
        } else {
          standout3 = 1;
        }
        die1 = new Die(x, y);
        die1.show();
        die1.roll();
        sum += die1.number;
        count +=1;
      }
    }
    if (mouseY>720) {
      stroke(0);
      strokeWeight(10);
      strokeJoin(ROUND);
      fill(192);
      rect(230, 740, 340, 60);
      fill(0);
      textSize(50);
      textAlign(CENTER);
      noStroke();

      text("Total: "+sum, 400, 790);
    }
    i = 0;
  }
}
void mousePressed() {
  if (mouseY<720) {
    xclick = (int)(mouseX/40);
    yclick = (int)(mouseY/40);
  } else {
    //sum = 0;
    count = 0;
    tile1 = (int)(Math.random()*360)+1;
    tile2 = (int)(Math.random()*360)+1;
    tile3 = (int)(Math.random()*360)+1;
    while (tile2 == tile1) {
      tile2 = (int)(Math.random()*360)*1;
    }
    while ((tile3 == tile2) || (tile3 == tile1)) {
      tile3 = (int)(Math.random()*360)*1;
    }
  }
  redraw();
}

class Die {
  int myX, myY, number;
  Die(int x, int y) {
    myX = x;
    myY = y;
    number = 0;
  }
  void roll() {
    if (shade == 255) {
      stroke(0);
      fill(0);
    } else {
      stroke(255);

      fill(255);
    }
    number = (int)(Math.random()*6)+1;
    if (number == 1) {
      ellipse(myX+20, myY+20, 5, 5);
    } else if (number == 2) {
      ellipse(myX+30, myY+10, 5, 5);
      ellipse(myX+10, myY+30, 5, 5);
    } else if (number == 3) {
      ellipse(myX+30, myY+10, 5, 5);
      ellipse(myX+20, myY+20, 5, 5);
      ellipse(myX+10, myY+30, 5, 5);
    } else if (number == 4) {
      ellipse(myX+10, myY+10, 5, 5);
      ellipse(myX+30, myY+10, 5, 5);
      ellipse(myX+10, myY+30, 5, 5);
      ellipse(myX+30, myY+30, 5, 5);
    } else if (number == 5) {
      ellipse(myX+10, myY+10, 5, 5);
      ellipse(myX+30, myY+10, 5, 5);
      ellipse(myX+20, myY+20, 5, 5);
      ellipse(myX+10, myY+30, 5, 5);
      ellipse(myX+30, myY+30, 5, 5);
    } else {
      ellipse(myX+10, myY+10, 5, 5);
      ellipse(myX+30, myY+10, 5, 5);
      ellipse(myX+10, myY+20, 5, 5);
      ellipse(myX+30, myY+20, 5, 5);
      ellipse(myX+10, myY+30, 5, 5);
      ellipse(myX+30, myY+30, 5, 5);
    }
    //if (mouseY>720) {
      //sum = sum+number;
    //}
    replace = number;
    rolls[i] = number;
    i++;
  }
  void show() {
    shade = ((int)(Math.random()*2))*255;
    fill(shade);
    if (standout1 == 0) {
      fill(255, 0, 0);
    } else if (standout2 == 0) {
      fill(0, 255, 0);
    } else if (standout3 == 0) {
      fill(0, 0, 255);
    } else if (rpress == true) {
      fill(255, 0, 0);
    } else if (gpress == true) {
      fill(0, 255, 0);
    } else if (bpress == true) {
      fill(0, 0, 255);
    } else {
      r = shade;
      g = shade;
      b = shade;
      fill(r, g, b);
    }
    stroke(0);
    rect(myX, myY, 40, 40);
  }
}
