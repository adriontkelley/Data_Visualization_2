void run3(){
   background(0);
  count4++;
  if(count4 == CSVs4.length) count4 = 1;
  for (int i=0; i<CSVs4[count4].getRowCount(); i++) {
    x4 = CSVs4[count4].getInt(i, 0);
    y4 = CSVs4[count4].getInt(i, 1);
    z4 = CSVs4[count4].getInt(i, 2)*(-mouseY);
    float zz4 = z4/300.0;
    
    pushMatrix();
    
    float theta = map(700, 0, width, 0, TWO_PI);

  // Rotate by the angle theta
  rotateY((mouseX/200.0)+600);
 rotate(theta);
 
    translate(x4 -1500, y4 - 800, zz4 );
    
    stroke(random(255),random(255),random(255));
   fill(random(255),random(255),random(255));
    rect(width/2, height/2, random(20), random(20));
    
    popMatrix();
  
  }
}