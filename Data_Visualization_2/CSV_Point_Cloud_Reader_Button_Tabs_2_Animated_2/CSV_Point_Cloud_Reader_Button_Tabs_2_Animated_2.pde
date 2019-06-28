
///Modified by Adrion T. Kelley 2018





//lines
int nLines = 50;
Line[] l;
Particle[] attractors;
//lines




//flockingCircles
int numVehicles = 100 ;
ArrayList<Vehicle> vehicles;
//flockingCircles





//CircleLinesDistance
int nbCircles = 8;
Circle[] circles;
MyColor myColor;
float rMax, dMin;
//CircleLinesDistance

int page = 0;

int count  = 0;
int numCSVs = 21;  // The number of frames in the animation
int currentCSV = 0;
Table[] CSVs = new Table[numCSVs];
String CSVname;

int x;
int y;
int z;





int count2  = 0;
int numCSVs2 = 21;  // The number of frames in the animation
int currentCSV2 = 0;
Table[] CSVs2 = new Table[numCSVs2];
String CSVname2;

int x2;
int y2;
int z2;




int count3  = 0;
int numCSVs3 = 21;  // The number of frames in the animation
int currentCSV3 = 0;
Table[] CSVs3 = new Table[numCSVs3];
String CSVname3;

int x3;
int y3;
int z3;



int count4  = 0;
int numCSVs4 = 21;  // The number of frames in the animation
int currentCSV4 = 0;
Table[] CSVs4 = new Table[numCSVs4];
String CSVname4;

int x4;
int y4;
int z4;





void setup(){
  size(1400,720, P3D);
  
 frameRate(4);

  for (int i = 1; i < numCSVs; i++) {
    CSVname = "Marching_" + nf(i, 4) + ".csv";
    CSVs[i] = loadTable(CSVname, "header");

     //println(CSVname);
    //delay(1000);
  }
  
  
  for (int i = 1; i < numCSVs2; i++) {
    CSVname2 = "JumpingJacks_" + nf(i, 4) + ".csv";
    CSVs2[i] = loadTable(CSVname2, "header");

     //println(CSVname2);
    //delay(1000);
  }
  
  for (int i = 1; i < numCSVs3; i++) {
    CSVname3 = "Running_" + nf(i, 4) + ".csv";
    CSVs3[i] = loadTable(CSVname3, "header");

     //println(CSVname3);
    //delay(1000);
  }
  
  
  for (int i = 1; i < numCSVs4; i++) {
    CSVname4 = "Thizzle_" + nf(i, 4) + ".csv";
    CSVs4[i] = loadTable(CSVname4, "header");

     //println(CSVname3);
    //delay(1000);
  }
  
  //CircleLinesDistance
  rMax = min(width, height)/2;
  dMin = max(width, height)/3.5;
  circles = new Circle[nbCircles];
  initialize(false);
  //CircleLinesDistance
  
  //flockingCircles
 vehicles = new ArrayList();
  for (int i = 0; i < numVehicles; i++) {
    PVector pos = new PVector(random(width), random(height));
    PVector vel = new PVector(random(-1, 1), random(-1, 1));
    float rad = random(2, 10);
    Vehicle v = new Vehicle(pos, vel, rad);
    vehicles.add(v);
  } 
  //flockingCircles
  
  
  
  //lines
  initialize();
  //lines
  
  
  println(CSVname + " , " + CSVname2 + " , " + CSVname3 + " , " + CSVname4);
  
}




void draw() {
  //fill(255);
  //textSize(30);
  //fill(0, 9);
  //rect(0,0,width,height);
  if(page == 0) run0();
  else if(page == 1) run1(); 
  else if(page == 2) run2();
  else if(page == 3) run3();
  
  
 
  
 
  
  
}






void mousePressed(){
 // page = round(random(4));
  //floor = round down
  //ceil = round up
  
  
}


void keyPressed(){
  if(key == '1') page = 0;
  else if(key == '2') page = 1;
  else if(key == '3') page = 2;
  else if(key == '4') page = 3;
 
  
}
