void run2(){
   background(0);
  count3++;
  if(count3 == CSVs3.length) count3 = 1;
  for (int i=0; i<CSVs3[count3].getRowCount(); i+=20) {
    x3 = CSVs3[count3].getInt(i, 0);
    y3 = CSVs3[count3].getInt(i, 1);
    z3 = CSVs3[count3].getInt(i, 2)*(-mouseY);
    float zz3 = z3/300.0;
    
    pushMatrix();
    
    float theta = map(700, 0, width, 0, TWO_PI);

  // Rotate by the angle theta
  rotateY((mouseX/200.0)+600);
 rotate(theta);
 
    translate(x3 -1100, y3 - 500, zz3 );
    //noStroke();
    //fill(255);
   // box(20);
    
    
    //lines
    colorMode(HSB); 
  strokeWeight(1.5);
  noFill();
  //lines
  
  
  //lines
  // move attractors
  attractors[0].update();  
  attractors[1].update();
  
  // interact lines with attractors
  float radius = 75*cos(frameCount/150.);
  for(int j = 0; j < l.length; j++) {
    l[j].interact(radius, attractors[0].pos.x, attractors[0].pos.y);
    l[j].interact(-radius, attractors[1].pos.x, attractors[1].pos.y);
    l[j].display();  // display lines
  }
  //lines
    
    popMatrix();
    
  
  }
}

//lines
void initialize() {
  // Create Lines
  float c0 = random(255);
  float c1 = random(255);
  l = new Line[nLines];
  for(int i = 0; i < l.length; i++) {
    float col = lerp(c0, c1, float(i)/l.length);
    l[i] = new Line(10 + 2*i, col);
  }
  //lines
  
  
  
  //lines
  // Create Attractors
  attractors = new Particle[2];
  for (int i = 0; i < attractors.length; i++) {
    attractors[i] = new Particle(random(width), random(height));
    float angle = random(TWO_PI);
    attractors[i].vel.set(cos(angle), sin(angle), 0);
  }
}
//lines


//lines
class Line {
  ArrayList<Particle> p;
  color col;
  int nPoints = 100;
  
  Line(int y, float c) {
    p = new ArrayList<Particle>();
    for (int i = 0; i < nPoints; i++) {
      p.add(new Particle(2+5*i, y));
    }
    
    col = color(c, 100, 255);
  }
  //lines
  
 
  //lines
  void display() {  // display line
    stroke(col);
    beginShape();
    for (int i = 0; i < p.size(); i+=30) {
      curveVertex(p.get(i).pos.x, p.get(i).pos.y);
    }
    endShape();
  }
  //lines
  
 
  //lines
  void interact(float radius, float mx, float my) {  // interact line with attractor
    for (int i = 0; i < p.size(); i++) {
      p.get(i).interact(radius, mx, my);      
    }
    
    //change size of the line when necessary
    for (int i = 0; i < p.size()-1; i++) {
      float d = dist(p.get(i).pos.x, p.get(i).pos.y, p.get(i+1).pos.x, p.get(i+1).pos.y);
      if (d > 5) {  // add a new point when two neighbor points are too far apart
        float x = (p.get(i).pos.x + p.get(i+1).pos.x) / 2;
        float y = (p.get(i).pos.y + p.get(i+1).pos.y) / 2;
        p.add(i+1, new Particle(x, y));
      } else if (d < 1) {  // remove a point when 2 neighbor points are too close
        p.remove(i);
      }
    }   
  }
}
//lines




//lines
class Particle {
  PVector pos, vel, acc;
  
  Particle(float x, float y) {
    pos = new PVector(x, y, 0);
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
  //lines
 
  
  //lines
  void interact(float r0, float x, float y) {  // interact points with attractors
    float sign = r0/abs(r0);
    r0 = abs(r0);
    
    float r = dist(pos.x, pos.y, x, y);
    float angle = atan2(pos.y-y, pos.x-x);
    
    if (r <= r0) {
      float radius = 0.5*sign*(r0-r)/r0;
      vel.set(radius*cos(angle), radius*sin(angle));
    } else {
      vel.set(0, 0);
    }
    
    pos.add(vel);
  }
  //lines
  
 
  //lines
  void update() {  // move attractors
    //change direction sometimes
    if (random(1) > 0.97) {
      float angle = random(-PI, PI);
      acc.set(cos(angle), sin(angle), 0);
      
      float mod = PVector.angleBetween(acc, vel);
      mod = map(mod, 0, PI, 0.1, 0.001);
      acc.mult(mod); 
    }
    
    // update
    vel.add(acc);
    vel.limit(1.5); 
    pos.add(vel);
    
    // check edges
    pos.x = (pos.x + width)%width;
    pos.y = (pos.y + height)%height;
  }
}
//lines