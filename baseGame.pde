PVector v, v1;
int positionx[] = new int[10]; //Array List of ints that determine x location of obstacles
PVector vectors[] = new PVector[10];//Array List of PVectors located at bottom of top obstacle
PVector vectors0[] = new PVector[10];//Array List of PVectors located at bottom of top obstacle
float randseed[] = new float[10];
boolean runGame;
PImage gOver;
PImage loser;
float initX, initX2;
float punchL, punchR;
float sRot; //START OF SUPERMAN VARIABLES
PVector Sloc;
PVector dir;
boolean leftPunch = false;
boolean rightPunch = false;
boolean superRot = false;
boolean animate = false;
float time;
float ctime;
int x;
float capeM;
boolean click;
PImage img1, img2, outimg, img5, img3; //INTRO STUFF
int loc;
PFont f; 
int value = 400;
int px, py;
int vx, vy;
boolean text;
boolean intro;
boolean ending;
int clickCounter;

void setup(){
  
  img1 = loadImage("img1.png"); //INTRO CODE
  img2 = loadImage("img2.jpg");
  img5 = loadImage("img5.png");
  loser = loadImage("hahah.png");
  //image(img5, 0, 0);
  img5.resize(0, 50);
  img1.resize(0, 200);
  img2.resize(0,400);
  //img3 = loadImage("img3.png");
  size(800, 400);
  outimg = createImage(img2.width, img2.height, RGB);
  f = createFont("TimesNewRoman", 100, true);
  px = -50;
  py = 400;
  vx = 1;
  vy = -1;
  text = false;
  intro = true;
  ending = false;
  clickCounter = 0;
  v = new PVector(10,150);  //Location of superman hitbox
  //size(600,400);
  for(int i = 0; i < 10; i++) //Creates the locations for the x array list
    positionx[i] = 400 + 300 * i;
  runGame = true;
  for(int i = 0; i < 10; i++) //fills randseed with randomized values
    randseed[i] = random(50,200);
  println(randseed);
  gOver = loadImage("Gotham.jpg");
  initX = 0;
  initX2 = 1000;
  Sloc = new PVector(0, 0); //START OF SUPERMAN VARIABLES
  dir = new PVector(0, 0);
  time= 0.5;
  capeM=0;
  click =false;
  punchL=0;
  punchR=0;
  sRot =0;
  ctime=0;
}
void draw(){
  println(v.y);
  if(intro){
      img2.loadPixels();
    img5.loadPixels();
    img1.loadPixels();
    image(img2, 0, 0);
    fill(255, 255, 255, 100);
    noStroke();
    rect(10, 40, 100, 50);
    rect(0, 350, 800, 400);
    //image(img3, width/4,height/3);
  
    if (text == true) {
      image(img1, px, py);
      if (px<width/3) {
        px += vx;
        py += vy;
        textFont(f, 25);                  
        text("Superman couldn't find Lois Lane anywhere in Metropolis. He flew all the way to Gotham in search of Lois. Help him save his girl from Batman.", value, 380); 
        value = value - 4;
      }
    } else {
      image(img1, px, py);
      textFont(f, 25);                  
      text("Superman couldn't find Lois Lane anywhere in Metropolis. He flew all the way to Gotham in search of Lois. Help him save his girl from Batman.", value, 380); 
      value = value - 4;
    }
    updatePixels();
    image(img5, width-775 + random (-5, 5), height-360);
  }
  if(!intro){
      background(255,100);
       image(gOver,initX,0);
       image(gOver,initX2,0);
    if(runGame){
      fill(255);
      Superman(v.x-100, v.y);
      fill(10,10,10);
      ellipse(v.x, v.y, 10, 10); //TEST SHAPE
      vectors[1] = new PVector(positionx[1], randseed[1]); //CREATES THE VECTOR TO TOP BLOCK
        vectors0[1] = new PVector(positionx[1], 400 - (300 - randseed[1]));
      //line(v.x,v.y,vectors[1].x,vectors[1].y);
      //line(v.x,v.y,vectors0[1].x,vectors0[1].y);
      //fill(0);
      for(int i = 0; i < 10; i++){ //Goes through every x value, draws a rectangle, and then adjusts location
        vectors[i] = new PVector(positionx[i], randseed[i]); //CREATES THE VECTOR TO TOP BLOCK
        vectors0[i] = new PVector(positionx[i], 400 - (300 - randseed[i])); //CREATES THE VECTOR TO BOTTOM BLOCK
        rect(positionx[i],0,100,randseed[i]); //MAKES TOP BLOCK
        rect(positionx[i],400 - (300 - randseed[i]), 100,400); //MAKES BOTTOM BLOCK 
        fill(#FEFF05);
        rect(positionx[i]+randseed[i]/8,randseed[i]/4,randseed[i]/4,randseed[i]/4);
        rect(positionx[i]+randseed[i]/8,300,randseed[i]/4,randseed[i]/4);
        fill(0);
        //rect(positionx[i],0,100,randseed[i]);
        //line(v.x,v.y,vectors[i].x,vectors[i].y);
        //line(v.x,v.y,vectors0[i].x,vectors0[i].y);
        positionx[i] = positionx[i] - 4;
        //println(v.x - vectors[0].x);
        if(v.y - vectors[i].y <= 0 && v.x - vectors[i].x >= 0 && v.x - vectors[i].x <= 100)
          runGame = false;
        if(v.y - vectors0[i].y >= 0 && v.x - vectors[i].x >= 0 && v.x - vectors[i].x <= 100)
          runGame = false;
        
      }
      if(vectors[9].x < 0)
          ending = true;
    }
    //v = new PVector(mouseX, mouseY);
    v = new PVector(v.x, v.y + (v.y+100)/100);
    /*if(v.y < 100) //RUDIMENTARY ACCELERATION
      v = new PVector(v.x, v.y + 1);
    else if(v.y < 200)
      v = new PVector(v.x, v.y + 2);
    else if(v.y < 300)
      v = new PVector(v.x, v.y + 4);
    else if(v.y < 400)
      v = new PVector(v.x, v.y + 8);
    /*if(v.x - vectors[9].x > 100) //TEST CODE, DO NOT IMPLEMENT
      background(0);
  //}
  if(!runGame){
      background(255);
      image(gOver,87,166);
  }
  //v = new PVector(mouseX, mouseY);
  */
  initX-=2;
  initX2-=2;
  }
    
  if(!runGame)
    image(loser,25,150);
  
  if(initX == -1000) //RESETS 
    initX = 1000;
  if(initX2 == -1000)
    initX2 = 1000;
  if(ending)
    image(loser,100,100);
  
}
void mousePressed(){
  text = !text;
  if(mouseX > 50 && mouseX < 200 && mouseY > 0 && mouseY < 100){
    clickCounter++;
  }
  if(mousePressed && clickCounter > 1){
    intro = false;
    v = new PVector(v.x, v.y - 50);
  }
}

void Superman(float shiftx, float shifty) {
  
  float ScaleX =(float) width/100;
  float ScaleY =(float) height/50;
  pushMatrix();
  translate(shiftx, shifty);
  scale(.2);
  // scale(.5);
  translate(400, 150);
  rotate(HALF_PI*.4);
  translate(-200, -200);
  scale(.5);

  pushMatrix();
  translate(1*ScaleX*cos(capeM), 1*ScaleY*cos(capeM));
  //cape
  pushMatrix();
  translate(1.01*ScaleX*cos(capeM), 1.01*ScaleY*cos(capeM));

  fill(224, 38, 61);
  beginShape();
  //startpoint
  curveVertex(312, 207);
  curveVertex(312, 207);
  for (int i=2; i<abs(86-312); i++){
      curveVertex(-i+312,i*250/abs(88-312)+207+-10*sin(radians(5*(i-ctime))));
  }
  //end point
  curveVertex(88, 457);
  
  curveVertex(40, 510);
  curveVertex(35, 531);
  curveVertex(42, 553);
  curveVertex(53, 564);
  curveVertex(61, 528);
  curveVertex(73, 513);
  curveVertex(94, 504);
  curveVertex(115, 496);
  curveVertex(131, 494);
  curveVertex(139, 494);
  curveVertex(142, 498);
  curveVertex(144, 501);
  curveVertex(124, 540);
  curveVertex(125, 554);
  curveVertex(132, 573);
  curveVertex(147, 591);
  curveVertex(185, 607);
  curveVertex(205, 607);
  curveVertex(275, 609);
  curveVertex(296, 632);
  curveVertex(349, 646);
  curveVertex(368, 657);
  curveVertex(365, 672);
  curveVertex(333, 700);
  curveVertex(363, 695);
  curveVertex(395, 679);
  curveVertex(439, 625);
  curveVertex(479, 559);
  curveVertex(558, 401);
  curveVertex(556, 223);
  curveVertex(435, 213);
  curveVertex(312, 207);
  curveVertex(312, 207);
  endShape();
  popMatrix();

  pushMatrix();
  //lefthand
  fill(247, 206, 159);
  beginShape(); 
  curveVertex(751, 78);
  curveVertex(750, 78);
  curveVertex(736, 68);
  curveVertex(732, 50);
  curveVertex(740, 34);
  curveVertex(749, 5);
  curveVertex(751, 3);
  curveVertex(756, 4);
  curveVertex(768, 1);
  curveVertex(782, 7);
  curveVertex(788, 8);
  curveVertex(799, 29);
  curveVertex(781, 47);
  curveVertex(772, 42);
  curveVertex(775, 47);
  curveVertex(774, 56);
  curveVertex(751, 78);
  curveVertex(751, 78);
  endShape();

  //leftforearm
  fill(24, 149, 207);
  beginShape();
  curveVertex(751, 78);
  curveVertex(750, 78);
  curveVertex(677, 178);
  curveVertex(641, 153);
  curveVertex(645, 130);
  curveVertex(650, 117);
  curveVertex(671, 94);
  curveVertex(699, 76);
  curveVertex(732, 55);
  curveVertex(736, 70);
  curveVertex(742, 75);
  curveVertex(751, 78);
  curveVertex(750, 78);
  endShape();
  popMatrix();
  fill(24, 149, 207);
  
  //upperleftarm
  pushMatrix();
  beginShape();
  curveVertex(640, 152);
  curveVertex(641, 152);
  curveVertex(656, 159);
  curveVertex(672, 164);
  curveVertex(680, 178);
  curveVertex(641, 228);
  curveVertex(608, 281);
  curveVertex(587, 294);
  curveVertex(566, 276);
  curveVertex(553, 264);
  curveVertex(545, 235);
  curveVertex(541, 211);
  curveVertex(562, 191);
  curveVertex(591, 178);
  curveVertex(640, 148);
  curveVertex(641, 148);
  endShape();
  popMatrix();
  //torso
  beginShape();
  //neckcape chest vertex
  curveVertex(517, 214);
  curveVertex(518, 214);
  curveVertex(537, 217);
  curveVertex(558, 222);
  curveVertex(579, 235);
  curveVertex(584, 240);
  curveVertex(597, 256);
  //lower part of arm meets here
  curveVertex(603, 268);
  curveVertex(605, 334);
  curveVertex(596, 359);
  curveVertex(547, 410);
  //belt
  curveVertex(506, 450);
  curveVertex(378, 387);
  curveVertex(349, 343);
  curveVertex(353, 309);
  curveVertex(343, 266);
  curveVertex(368, 233);
  curveVertex(367, 220);
  curveVertex(400, 215);
  curveVertex(443, 212);
  curveVertex(477, 211);
  curveVertex(517, 214);
  curveVertex(518, 214);
  endShape();
  
  //superman logo outside
  stroke(223, 38, 60);
  strokeWeight(12);
  fill(248, 229, 66);
  beginShape();
  vertex(467, 229);
  vertex(467, 229);
  vertex(559, 234);
  vertex(595, 269);
  vertex(545, 329);
  vertex(450, 248);
  vertex(467, 229);
  vertex(467, 229);
  endShape();
  noStroke();

  //supermanS
  fill(223, 38, 60);
  beginShape();
  curveVertex(556, 246);
  curveVertex(556, 246);
  curveVertex(556, 239);
  curveVertex(566, 245);
  curveVertex(567, 255);
  curveVertex(549, 255);
  curveVertex(540, 247);
  curveVertex(534, 244);
  curveVertex(522, 241);
  curveVertex(508, 241);
  curveVertex(501, 243);
  curveVertex(497, 248);
  curveVertex(497, 250);
  curveVertex(500, 255);
  curveVertex(513, 260);
  curveVertex(533, 262);
  curveVertex(550, 261);
  curveVertex(563, 265);
  curveVertex(576, 272);
  curveVertex(580, 282);
  curveVertex(556, 309);
  curveVertex(542, 309);
  curveVertex(522, 293);
  curveVertex(527, 288);
  curveVertex(533, 287);
  curveVertex(536, 293);
  curveVertex(551, 295);
  curveVertex(560, 293);
  curveVertex(564, 286);
  curveVertex(555, 280);
  curveVertex(526, 276);
  curveVertex(496, 274);
  curveVertex(474, 254);
  curveVertex(475, 246);
  curveVertex(479, 239);
  curveVertex(485, 233);
  curveVertex(546, 237);
  curveVertex(556, 246);
  curveVertex(556, 246);
  endShape();
  stroke(0);
  strokeWeight(1);

  //upper right arm trying to rotate/translate
  fill(24, 149, 207);
  pushMatrix();
  translate(205, 235);
  rotate(PI);
  translate(-745, -270);
  beginShape();
  curveVertex(640, 152);
  curveVertex(641, 152);
  curveVertex(656, 159);
  curveVertex(672, 164);
  curveVertex(680, 178);
  curveVertex(641, 228);
  curveVertex(608, 281);
  curveVertex(587, 294);
  curveVertex(566, 276);
  curveVertex(553, 264);
  curveVertex(545, 235);
  curveVertex(541, 211);
  curveVertex(562, 191);
  curveVertex(591, 178);
  curveVertex(640, 148);
  curveVertex(641, 148);
  endShape();
//  popMatrix();
  popMatrix(); 
  pushMatrix();
  //rightforearm
  pushMatrix();
  translate(-5, -10);
  beginShape();
  curveVertex(270, 340);
  curveVertex(271, 340);
  curveVertex(290, 342);
  curveVertex(295, 346);  
  curveVertex(336, 343);
  curveVertex(349, 342);
  curveVertex(373, 342);
  //hand vertex -5, -10
  curveVertex(392, 337);
  curveVertex(393, 348);
  curveVertex(398, 359);
  curveVertex(407, 363);
  curveVertex(378, 385);
  curveVertex(336, 409);
  curveVertex(306, 417);
  curveVertex(288, 409);
  curveVertex(261, 400);
  curveVertex(257, 376);
  curveVertex(263, 359);
  curveVertex(270, 340);
  curveVertex(271, 340);
  endShape();
  popMatrix();
  //right hand
  fill(247, 206, 159);
  beginShape();
  pushMatrix();
  translate(-10, 5);
  curveVertex(392, 337);
  curveVertex(392, 337);
  curveVertex(401, 331);
  curveVertex(395, 313);
  curveVertex(399, 307);
  curveVertex(407, 300);
  curveVertex(410, 292);
  curveVertex(417, 293);
  curveVertex(421, 297);
  curveVertex(434, 295);
  curveVertex(438, 300);
  curveVertex(439, 307);
  curveVertex(445, 310);
  curveVertex(449, 317);
  curveVertex(451, 330);
  curveVertex(450, 349);
  curveVertex(432, 358);
  curveVertex(415, 357);
  curveVertex(408, 364);
  curveVertex(398, 358);
  curveVertex(393, 346);
  curveVertex(392, 337);
  curveVertex(392, 337);
  endShape();
  popMatrix();
  popMatrix();
  //rightleg
  fill(24, 148, 205);
  beginShape();
  curveVertex(322, 464);
  curveVertex(321, 464);
  curveVertex(336, 463);
  curveVertex(355, 470);
  curveVertex(366, 477);
  curveVertex(375, 485);
  curveVertex(381, 497);
  curveVertex(387, 513);
  curveVertex(390, 524);
  curveVertex(391, 541);
  curveVertex(407, 541);
  curveVertex(428, 538);
  curveVertex(459, 527);
  curveVertex(439, 559);
  curveVertex(399, 609);
  curveVertex(362, 640);

  curveVertex(345, 648);
  curveVertex(281, 678);
  curveVertex(256, 693);
  curveVertex(244, 702);
  curveVertex(224, 729);
  curveVertex(209, 744);
  curveVertex(99, 831);
  curveVertex(49, 892);
  curveVertex(31, 910);
  curveVertex(17, 917);
  curveVertex(4, 915);
  curveVertex(5, 888);
  curveVertex(11, 861);
  curveVertex(34, 819);
  curveVertex(40, 820);
  curveVertex(48, 827);
  curveVertex(90, 710);
  curveVertex(119, 662);
  curveVertex(147, 645);
  curveVertex(161, 640);
  curveVertex(189, 633);
  curveVertex(229, 570);
  curveVertex(251, 538);
  curveVertex(289, 494);
  curveVertex(322, 464);
  curveVertex(321, 464);
  endShape();
  //leftleg
  beginShape();
  curveVertex(391, 541);
  curveVertex(391, 541);
  curveVertex(407, 541);
  curveVertex(428, 538);
  curveVertex(459, 527);
  curveVertex(439, 559);
  curveVertex(399, 609);
  curveVertex(362, 640);

  curveVertex(345, 648);
  curveVertex(281, 678);
  curveVertex(256, 693);
  curveVertex(244, 702);
  curveVertex(224, 729);
  curveVertex(209, 744);
  curveVertex(99, 831);
  curveVertex(49, 892);
  curveVertex(31, 910);
  curveVertex(17, 917);
  curveVertex(65, 840);
  curveVertex(214, 680);
  curveVertex(227, 674);
  curveVertex(239, 661);
  curveVertex(314, 614);
  curveVertex(391, 541);
  curveVertex(391, 541);
  endShape();

  //rightboot
  fill(223, 38, 60);
  beginShape();
  curveVertex(103, 685);
  curveVertex(103, 685);
  curveVertex(165, 680);
  curveVertex(166, 707);
  curveVertex(188, 699);
  curveVertex(187, 709);
  curveVertex(123, 774);
  curveVertex(62, 844);
  curveVertex(48, 862);
  curveVertex(17, 914);
  curveVertex(4, 915);
  curveVertex(6, 877);
  curveVertex(16, 848);
  curveVertex(34, 818);
  curveVertex(40, 820);
  curveVertex(47, 828);
  curveVertex(79, 737);
  curveVertex(103, 685);
  curveVertex(103, 685);
  endShape();

  //leftboot
  beginShape();
  curveVertex(188, 708);
  curveVertex(188, 708);
  curveVertex(207, 709);
  curveVertex(205, 725);
  curveVertex(223, 721);
  curveVertex(220, 737);
  curveVertex(177, 770);
  curveVertex(112, 821);
  curveVertex(93, 841);
  curveVertex(65, 877);
  curveVertex(43, 903);
  curveVertex(16, 917);
  curveVertex(37, 876);
  curveVertex(66, 839);
  curveVertex(88, 811);
  curveVertex(133, 763);
  curveVertex(188, 708);
  curveVertex(188, 708);
  endShape();

  //underwearthing
  fill(65, 67, 64);
  beginShape();
  curveVertex(378, 387);
  curveVertex(379, 387);
  curveVertex(507, 451);
  curveVertex(475, 507);
  curveVertex(455, 532);
  curveVertex(427, 540);
  curveVertex(391, 543);
  curveVertex(389, 518);
  curveVertex(383, 500);
  curveVertex(376, 487);
  curveVertex(361, 473);
  curveVertex(337, 464);
  curveVertex(333, 464);
  curveVertex(321, 465);
  curveVertex(335, 443);
  curveVertex(361, 413);
  curveVertex(378, 387);
  curveVertex(379, 387);
  endShape();

  //belt
  fill(248, 230, 66);
  pushMatrix();
  translate(378, 388);
  rotate(PI/6);
  translate(-378, -388);
  rect(378, 388, 53, 26);
  popMatrix();
  pushMatrix();
  translate(437, 420);
  rotate(PI/6.5);
  translate(-437, -420);
  rect(437, 420, 80, 26);
  popMatrix(); 

  //neck
  fill(247, 206, 159);
  beginShape();
  curveVertex(518, 213);
  curveVertex(518, 214);
  curveVertex(516, 191);
  curveVertex(511, 171);
  curveVertex(509, 164);
  curveVertex(507, 153);
  curveVertex(480, 156);
  curveVertex(463, 152);
  curveVertex(445, 150);
  curveVertex(434, 151);
  curveVertex(434, 168);
  curveVertex(432, 182);
  curveVertex(424, 197);
  curveVertex(416, 213);
  curveVertex(437, 212);
  curveVertex(458, 211);
  curveVertex(471, 210);
  curveVertex(481, 210);
  curveVertex(498, 212);
  curveVertex(518, 213);
  curveVertex(518, 214);
  endShape();

  //left cape connector
  fill(224, 38, 61);
  beginShape();
  curveVertex(517, 213);
  curveVertex(517, 213);
  curveVertex(557, 221);
  curveVertex(554, 209);
  curveVertex(554, 200);
  curveVertex(516, 193);
  curveVertex(517, 213);
  curveVertex(517, 213);
  endShape();

  //right cape connector
  beginShape();
  curveVertex(434, 211);
  curveVertex(434, 211);
  curveVertex(403, 215);
  curveVertex(360, 219);
  curveVertex(353, 205);
  curveVertex(373, 195);
  curveVertex(387, 192);
  curveVertex(399, 197);
  curveVertex(411, 203);
  curveVertex(402, 197);
  curveVertex(410, 194);
  curveVertex(419, 195);
  curveVertex(434, 211);
  curveVertex(434, 211);
  endShape();

  //face details
  stroke(0);
  beginShape();
  curveVertex(476, 112);
  curveVertex(476, 112);
  curveVertex(496, 110);
  curveVertex(496, 110);
  endShape();

  //head
  fill(247, 206, 159);
  beginShape();
  curveVertex(466, 169);
  curveVertex(467, 171);
  curveVertex(486, 172);
  curveVertex(511, 171);
  curveVertex(521, 165);
  curveVertex(525, 163);
  curveVertex(528, 155);
  curveVertex(527, 151);
  curveVertex(527, 146);
  curveVertex(521, 143);
  curveVertex(519, 135);
  curveVertex(515, 130);
  curveVertex(510, 128);
  curveVertex(514, 120);
  curveVertex(503, 112);
  curveVertex(505, 109);
  curveVertex(496, 100);
  curveVertex(475, 96);
  curveVertex(466, 98);
  curveVertex(461, 101);
  curveVertex(453, 107);
  curveVertex(456, 112);
  curveVertex(457, 120);
  curveVertex(457, 132);
  curveVertex(448, 129);
  curveVertex(444, 128);
  curveVertex(442, 133);
  curveVertex(442, 140);
  curveVertex(446, 148);
  curveVertex(453, 149);
  curveVertex(458, 151);
  curveVertex(462, 159);
  curveVertex(466, 168);
  curveVertex(467, 168);
  endShape();

  //hair
  fill(65, 67, 63);
  beginShape();
  curveVertex(493, 99);
  curveVertex(494, 99);
  curveVertex(500, 92);
  curveVertex(500, 85);
  curveVertex(496, 78);
  curveVertex(491, 75);
  curveVertex(486, 76);
  curveVertex(477, 76);
  curveVertex(470, 82);
  curveVertex(463, 88);
  curveVertex(447, 95);
  curveVertex(442, 98);
  curveVertex(436, 103);
  curveVertex(433, 110);
  curveVertex(432, 120);
  curveVertex(435, 168);
  curveVertex(439, 162);
  curveVertex(445, 153);
  curveVertex(445, 148);
  curveVertex(443, 143);
  curveVertex(442, 136);
  curveVertex(442, 131);
  curveVertex(444, 128);
  curveVertex(446, 127);
  curveVertex(450, 129);
  curveVertex(457, 133);
  curveVertex(456, 124);
  curveVertex(457, 116);
  curveVertex(452, 107);
  curveVertex(461, 100);
  curveVertex(476, 96);
  curveVertex(486, 97);
  curveVertex(493, 99);
  curveVertex(494, 99);
  endShape();

  //eyebrow
  beginShape();
  curveVertex(476, 112);
  curveVertex(476, 112);
  curveVertex(486, 111);
  curveVertex(496, 110);
  curveVertex(496, 110);
  endShape();

  //mouth
  beginShape();
  curveVertex(498, 141);
  curveVertex(498, 141);
  curveVertex(502, 138);
  curveVertex(508, 138);
  curveVertex(508, 139);
  endShape();

  //eye
  beginShape();
  curveVertex(484, 117);
  curveVertex(484, 117);
  curveVertex(488, 116);
  curveVertex(492, 115);
  curveVertex(492, 115);
  endShape();

  popMatrix();
  popMatrix(); 
  capeM = capeM+PI/35;
}

void upperleftarm(){
   fill(24, 149, 207);
  pushMatrix();
  translate(0,0);
  beginShape();
  curveVertex(640, 152);
  curveVertex(641, 152);
  curveVertex(656, 159);
  curveVertex(672, 164);
  curveVertex(680, 178);
  curveVertex(641, 228);
  curveVertex(608, 281);
  curveVertex(587, 294);
  curveVertex(566, 276);
  curveVertex(553, 264);
  curveVertex(545, 235);
  curveVertex(541, 211);
  curveVertex(562, 191);
  curveVertex(591, 178);
  curveVertex(640, 148);
  curveVertex(641, 148);
  endShape();
//  popMatrix();
  popMatrix(); 
}
