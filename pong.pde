/*
 Игра Pong 
 */

// Ball

final int BALL_SIZE = 70;
final int HALF_BALL_SIZE = BALL_SIZE /2;

int ballX;
int ballY;
int ballDX = 5;
int ballDY = 5;

//Paddless

final int PADDLES_WIDTH = 30;
final int PADDLES_HEIGHT = 120;
final int PADDLES_HALF_WIDTH = PADDLES_WIDTH / 2;
final int PADDLES_HALF_HEIGHT = PADDLES_HEIGHT / 2;

int leftPaddleX;
int leftPaddleY;
int leftPaddleDY = 5;

int rightPaddleX;
int rightPaddleY;
int rightPaddleDY = 5;

PImage img;

// Menu

final int MENU_STATE  = 0;
final int GAME_STATE  = 1;
final int PAUSE_STATE = 2;

int state = MENU_STATE;

//Score

final int SCORE_TEXT_SIZE = 150;
final int SCORE_Margin_TOP = 100;
final int SCORE_Margin_SIDE = 200;

int leftPlayerScore = 0;
int rightPlayerScore = 0;

void setup() { 
  fullScreen();
  background(0);
  noStroke();
  rectMode(CENTER);
  loadFonts();

  //BALL

  ballX = width / 2 ;
  ballY = height / 2 ;

  //PADDLES

  leftPaddleX = PADDLES_HALF_WIDTH ;
  rightPaddleX = width - PADDLES_HALF_WIDTH ;
  leftPaddleY = rightPaddleY = height / 2;
}

void draw () {
  background(0);

  //Menu

  switch (state) {
  case MENU_STATE:
    drawMenu();
    break;
  case GAME_STATE:
    drawGame();
    break;
  case PAUSE_STATE:
    drawPause();
    break;
  }
}  

void drawMenu() { 
  img = loadImage("pong.jpg");
  image(img, 0, 0);
  fill(#F7E83E);
  textSize(150);
  textAlign(CENTER, CENTER );
  text("Pong", width / 2, height / 2 );

  fill(#40FFFD);
  textSize(40);
  text(" Press Enter to start the game", width / 2, height / 2 + 150);
}

void drawGame() {
  background(#06A2CB);

  //BALL

  fill(#35FA4D);
  rect(ballX, ballY, BALL_SIZE, BALL_SIZE);

  ballX += ballDX;
  ballY -= ballDY;

  if (ballX -  HALF_BALL_SIZE>= width) {
    leftPlayerScore++;
    ballX = width / 2;
    ballY = height / 2;
    ballDX *= -1;
  }
  if ( ballX + HALF_BALL_SIZE< 0) {
    rightPlayerScore++;
    ballX = width / 2;
    ballY = height / 2;
    ballDX *= -1;
  }
  if (ballY +  HALF_BALL_SIZE>= height || ballY- HALF_BALL_SIZE< 0) {
    ballDY *= -1;
  }

  //PADDLES

  fill(#FABC35);
  rect(leftPaddleX, leftPaddleY, PADDLES_WIDTH, PADDLES_HEIGHT);
  rect(rightPaddleX, rightPaddleY, PADDLES_WIDTH, PADDLES_HEIGHT);

  if (keyPressed) {
    if (keyCode == UP) {
      leftPaddleY -= leftPaddleDY;
      rightPaddleY -= rightPaddleDY;
      if (leftPaddleY - PADDLES_HALF_HEIGHT < 0) {
        leftPaddleY =  PADDLES_HALF_HEIGHT;
      }
      if (rightPaddleY -  PADDLES_HALF_HEIGHT <0) {
        rightPaddleY =  PADDLES_HALF_HEIGHT;
      }
    } else if (keyCode ==DOWN) {
      leftPaddleY += leftPaddleDY;
      rightPaddleY += rightPaddleDY;
      if (leftPaddleY + PADDLES_HALF_HEIGHT > height) {
        leftPaddleY =   height - PADDLES_HALF_HEIGHT;
      }
      if (rightPaddleY +  PADDLES_HALF_HEIGHT > height) {
        rightPaddleY = height - PADDLES_HALF_HEIGHT;
      }
    }
  }

  //collision   Detection

  if (abs(ballX - leftPaddleX) < HALF_BALL_SIZE + PADDLES_HALF_WIDTH &&
    abs(ballY - leftPaddleY) < HALF_BALL_SIZE + PADDLES_HALF_HEIGHT || 
    abs(ballX - rightPaddleX) < HALF_BALL_SIZE + PADDLES_HALF_WIDTH &&
    abs(ballY - rightPaddleY) < HALF_BALL_SIZE + PADDLES_HALF_HEIGHT) {
    ballDX *= -1;
  }

  //SCORE

  fill(#F7E83E);
  textSize(SCORE_TEXT_SIZE);
  textAlign(CENTER, CENTER);
  text(leftPlayerScore, SCORE_Margin_SIDE, SCORE_Margin_TOP);
  text(rightPlayerScore, width - SCORE_Margin_SIDE, SCORE_Margin_TOP);
}


void drawPause() {
  img = loadImage("pause.png");
  image(img, 0, 0);
  fill(#F7E83E);
  textSize(150);
  textAlign(CENTER, CENTER );
  text("Pause", width / 2, height / 2 - 50);

  fill(255);
  textSize(40);
  text(" Press Space to continue the game", width / 2, height / 2 + 150);
}

void keyPressed() {
  switch (state) {
  case MENU_STATE:
    keyPressedInMenu();
    break;
  case GAME_STATE:
    keyPressedInGame();
    break;
  case PAUSE_STATE:
    keyPressedOnPause();
    break;
  }
}

void keyPressedInMenu() {
  if (keyCode == ENTER) {
    leftPlayerScore = 0;
    rightPlayerScore = 0;
    state = GAME_STATE;
  }
}

void keyPressedInGame() {
  if (key == ' ') {
    state = PAUSE_STATE;
  }
}

void  keyPressedOnPause() {
  if (keyCode == ' ') {
    state = GAME_STATE;
  }
}

PFont mainFont;

void loadFonts() { 
  mainFont = createFont("PINGPONG.TTF", 32);
  textFont(mainFont);
}
