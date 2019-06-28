void run1(){
   background(0);
  count2++;
  if(count2 == CSVs2.length) count2 = 1;
  for (int i=0; i<CSVs2[count2].getRowCount(); i+=20) {
    x2 = CSVs2[count2].getInt(i, 0);
    y2 = CSVs2[count2].getInt(i, 1);
    z2 = CSVs2[count2].getInt(i, 2)*(-mouseY);
    float zz2 = z2/300.0;
    
    pushMatrix();
    
    float theta = map(700, 0, width, 0, TWO_PI);

  // Rotate by the angle theta
  rotateY((mouseX/200.0)+600);
 rotate(theta);
 
    translate(x2 -1500, y2 - 800, zz2 );
    fill(255);
    noStroke();
    //ellipse(width/2, height/2, 20, 20);
    
    //flockingCircles
    for (int j = 0; j < vehicles.size (); j++) {
    Vehicle v  =  vehicles.get(j);
    v.run();
  }
  //flockingCircles
    
    popMatrix();
   // noStroke();
  
  }
}

//flockingCircles
  class Vehicle {
  float rad, howFar, min, max;
  PVector pos, vel, accel, coh, avd, ali; 

  Vehicle(PVector p, PVector v, float r) {
    rad = r;
    pos = p;
    vel = v;
    v.normalize();
    howFar = 60;
    min = .4;
    max = .6;
  }
//flockingCircles

//flockingCircles
 void run() {
    update();
    wrap();
    render();
  }
  //flockingCircles
  
  //flockingCircles
   void update() {
    accel = new PVector();
    coh = cohesion();
    avd = avoid();
    ali = align();

    coh.mult(.3);
    avd.mult(1);
    ali.mult(1);

    accel.add(coh);
    accel.add(avd);
    accel.add(ali);

    vel.add(accel);
    vel.limit(2);
    pos.add(vel);
  }
//flockingCircles


//flockingCircles
void wrap() {
    if (pos.x < -20) pos.x = width+20;
    else if (pos.x > width+20) pos.x = -20;
    if (pos.y < -20) pos.y = height+20;
    else if (pos.y > height+20) pos.y = -20;
  }
  //flockingCircles
  
  
  //flockingCircles
  PVector align() {
    PVector sum = new PVector();
    float diff = max - min;
    for (int i = 0; i < vehicles.size (); i++) {
      Vehicle v =  vehicles.get(i);
      float dst = pos.dist(v.pos);
      float percent = (dst*dst) / (howFar*howFar);
      if (percent < max && dst > min) {
        percent = (percent - min)/diff;
        float num = (.5-cos(percent*2*PI)*.5 + .5) *.1;
        PVector hold = v.vel.get();
        hold.normalize();
        hold.mult(num);
        sum.add(hold);
      }
    }
    return sum;
  }
  //flockingCircles
  
  
  
  
//flockingCircles
PVector avoid() {
    PVector sum = new PVector();
    for (int i = 0; i < vehicles.size (); i++) {
      Vehicle v =  vehicles.get(i);
      float dst = pos.dist(v.pos);
      float percent = (dst*dst) / (howFar*howFar);
      if (dst >0 && percent < min) {
        float scalar = (min/ percent - 1)*.01;
        PVector hold = pos.get();
        hold.sub(v.pos);
        hold.normalize();
        hold.mult(scalar);
        sum.add(hold);
      }
    }
    return sum;
  }
  //flockingCircles
  
  
  
  //flockingCircles
  PVector cohesion( ) {
    PVector sum = new PVector();
    float diff = 1-max;
    for (int i = 0; i < vehicles.size (); i++) {
      Vehicle v =  vehicles.get(i);
      float dst = pos.dist(v.pos);
      float percent = (dst*dst) / (howFar*howFar);
      if (percent > max && percent <= 1) {
        percent = (percent - max)/diff;
        float num = (.5- cos(percent*PI*2)*.5 +.5)*.01;
        PVector hold = v.pos.get();
        hold.sub(pos);
        hold.normalize();
        hold.mult(num);
        sum.add(hold);
      }
    }
    return sum;
  }
  //flockingCircles
  
  
  
  //flockingCircles
  void render() {
    strokeWeight(.3);
    stroke(#A2F6FF);
    for (int i = 0; i < vehicles.size (); i++) {
      Vehicle v =  vehicles.get(i);
      float dst = pos.dist(v.pos);
      if (dst < .5*howFar && dst > 0) {
        line(pos.x, pos.y, v.pos.x, v.pos.y);
      }
    }
    fill(#FF7E27);
    noStroke();
    ellipse(pos.x, pos.y, rad, rad);
  }
}
//flockingCircles
 

  