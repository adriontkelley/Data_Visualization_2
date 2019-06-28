

void run0(){
  background(0);
  //fill(0, 25);
  //rect(0,0,width,height);
  count++;
  if(count == CSVs.length) count = 1;
  for (int i=0; i<CSVs[count].getRowCount(); i+=25) {
    x = CSVs[count].getInt(i, 0);
    y = CSVs[count].getInt(i, 1);
    z = CSVs[count].getInt(i, 2)*(-mouseY);
    float zz = z/300.0;
    
    
    
    pushMatrix();
    
    float theta = map(700, 0, width, 0, TWO_PI);

  // Rotate by the angle theta
  rotateY((mouseX/200.0)+600);
 rotate(theta);
 
    translate(x -1000, y - 600, zz );
    
     
     
     //CircleLinesDistance
     myColor.update();
  for (int j = 0; j < nbCircles; j++)
  {
    circles[j].update();
    for (int k = j+1; k < nbCircles; k++)
    {
      connect(circles[j], circles[k]);
    }
  }
  //CircleLinesDistance

    popMatrix();
   
  }
  
    
  
}
  
  
  
  //CircleLinesDistance
void connect(Circle c1, Circle c2)
{
  float d, x1, y1, x2, y2, r1 = c1.radius, r2 = c2.radius;
  float rCoeff = map(min(abs(r1), abs(r2)), 0, rMax, .08, 1);
  int n1 = c1.nbLines, n2 = c2.nbLines;
  for (int i = 0; i < n1; i++)
  {
    x1 = c1.x + r1 * cos(i * TWO_PI / n1 + c1.theta);
    y1 = c1.y + r1 * sin(i * TWO_PI / n1 + c1.theta);
    for (int j = 0; j < n2; j++)
    {
      x2 = c2.x + r2 * cos(j * TWO_PI / n2 + c2.theta);
      y2 = c2.y + r2 * sin(j * TWO_PI / n2 + c2.theta);

      d = dist(x1, y1, x2, y2);
      if (d < dMin)
      {
        stroke(myColor.R + r2/1.5, myColor.G + r2/2.2, myColor.B + r2/1.5, map(d, 0, dMin, 140, 0) * rCoeff);
        line(x1, y1, x2, y2);
      }
    }
  }
}
//CircleLinesDistance


//CircleLinesDistance
void initialize(Boolean p_random)
{ 
  for (int i = 0; i < nbCircles; i++)
  {
    circles[i] = new Circle(random(rMax), 
    p_random ? random(-width/3, width/3) : 0, 
    p_random ? random(-height/3, height/3) : 0);
  }
  myColor = new MyColor();
}
//CircleLinesDistance


//CircleLinesDistance
class Circle
{
  float x, y, radius, theta = 0;
  int nbLines = (int)random(3, 25);
  float rotSpeed = (random(1) < .5 ? 1 : -1) * random(.005, .034);
  float radSpeed = (random(1) < .5 ? 1 : -1) * random(.3, 1.4);
  
  Circle(float p_radius, float p_x, float p_y)
  {
    radius = p_radius;
    x = p_x;
    y = p_y;
  }

  void update()
  {
    theta += rotSpeed;
    radSpeed *= abs(radius += radSpeed) > rMax ? -1 : 1;
  }
}
//CircleLinesDistance

//CircleLinesDistance
class MyColor
{
  float R, G, B, Rspeed, Gspeed, Bspeed;
  final static float minSpeed = .2;
  final static float maxSpeed = .8;
  MyColor()
  {
    R = random(20, 255);
    G = random(20, 255);
    B = random(20, 255);
    Rspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
    Gspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
    Bspeed = (random(1) > .5 ? 1 : -1) * random(minSpeed, maxSpeed);
  }

  public void update()
  {
    Rspeed = ((R += Rspeed) > 255 || (R < 20)) ? -Rspeed : Rspeed;
    Gspeed = ((G += Gspeed) > 255 || (G < 20)) ? -Gspeed : Gspeed;
    Bspeed = ((B += Bspeed) > 255 || (B < 20)) ? -Bspeed : Bspeed;
  }
}
//CircleLinesDistance