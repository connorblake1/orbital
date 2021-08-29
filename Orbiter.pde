ArrayList<ArrayList<Satellite>> bodies; //this variable holds a list of a list of everything in this simulation that is going to interact
int dotsL = 300; //this is for tracing out the paths of the bodies: longer = slower and prettier, smaller (2 is minimum) = faster (CHANGE THIS IF YOU WOULD LIKE)
int indexL = 0; //this also messes with tracing out the paths of the bodies, so but don't mess with this one
float t = 0;
float rSum = 0;
int selector; //you will change this later to pick which systems you want to see
float[][][][] dots; //ditto
final static float G = 8; //gravitational constant G (changing the fundamental constants of the universe, while fun, will make trying to find interesting orbital systems annoying)
final static float it = .01; //time step, maybe dont mess with this either
void setup() {
  bodies = new ArrayList<ArrayList<Satellite>>(); //extremely disgusting ArrayList of ArrayLists
  size(800, 800);
  //PRESETS FOR GRAVITATIONAL SYSTEMS:
  selector = 1; //CHANGE THIS VALUE HERE TO SEE DIFFERENT SYSTEMS (values: integers between 1 and 5)
  if (selector == 1) {
    //1: <planet and moon>
    bodies.add(new ArrayList<Satellite>());
    //if you want to try modifying the systems here are the variables you need to assign to make a body
    //                new Satellite(xPosition from -400 to 400, yPosition from -400 to 400, xVelocity, yVelocity, mass, is the object fixed in space? true or false, color(RGB));
    bodies.get(0).add(new Satellite(0, 0, 0, 0, 300, false, color(255,0,0))); //so for example this is the sun in the system so it starts at the origin with no velocity but a mass of 300, it is fixed in space, and its color is red
    bodies.get(0).add(new Satellite(0, 170, 30, 0, 10, false,color(0,0,255)));
    bodies.get(0).add(new Satellite(0, 180, 47, 0, .01, false,color(255,0,0)));
    //bodies.get(0).add(new Satellite(-300,0,60,5,2000000,false,color(255)));
    //bodies.add(new ArrayList<Satellite>());
    //bodies.get(1).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0)));
    //bodies.get(1).add(new Satellite(0, 170, 30, 0, 10, false,color(0,255,0)));
    //bodies.get(1).add(new Satellite(0, 180, 50, 0, .1, false,color(0,255,0)));
     //</planet and moon>
   }
  else if (selector == 2) {
     //2: <black holes>
    bodies.add(new ArrayList<Satellite>());
    bodies.get(0).add(new Satellite(0, 40, 25, -25, 300, false, color(0,255,0)));
    bodies.get(0).add(new Satellite(0, -40, -25, 25, 300, false, color(0,255,0)));
    bodies.add(new ArrayList<Satellite>());
    bodies.get(1).add(new Satellite(0, 50, 25, -25, 300, false,color(0,0,255)));
    bodies.get(1).add(new Satellite(0, -50, -25, 25, 300, false, color(0,0,255)));
    bodies.add(new ArrayList<Satellite>());
    bodies.get(2).add(new Satellite(0, 30, 25, -25, 300, false, color(255,0,0)));
    bodies.get(2).add(new Satellite(0, -30, -25, 25, 300, false, color(255,0,0)));
    //</black holes>
  }
  else if (selector == 3) {
    //3: <Kepler's Second Law>
    //average distance: 102.68
    //period:  ??
    bodies.add(new ArrayList<Satellite>());
    bodies.get(0).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0)));
    bodies.get(0).add(new Satellite(0, 140, 25, 0, 300, false, color(0,255,0)));
    bodies.add(new ArrayList<Satellite>());
    bodies.get(1).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0),true));
    bodies.get(1).add(new Satellite(33.95648,127.74996,22.71653 ,-17.609762, 300, false, color(0,255,0)));
    //</Kepler's Second Law>
    }
  else if (selector == 4) {
    //4: <Kepler's Third Law>
    //average distance: 175.22
    //period: 27.37
    bodies.add(new ArrayList<Satellite>());
    bodies.get(0).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0)));
    bodies.get(0).add(new Satellite(0, 110, 54, 0, 300, false, color(0,255,0)));
    //</Kepler's Third Law>
    }
  else if (selector == 5) {
    //5: <Playground>
    bodies.add(new ArrayList<Satellite>());
    bodies.get(0).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0)));
    bodies.get(0).add(new Satellite(0, 170, 30, 0, 10, false,color(0,255,0)));
    bodies.get(0).add(new Satellite(0, 180, 52, 0, .1, false,color(0,255,0)));}
  dots = new float[dotsL][2][bodies.get(0).size()][bodies.size()];
}
void draw() {
  background(0);
  translate(width/2, height/2);
  for (int k = 0; k < bodies.size(); k++) {
    for (int i = 0; i < bodies.get(k).size(); i++) {
      for (int j = 0; j < bodies.get(k).size(); j++) {
        if (i != j && !bodies.get(k).get(i).returnStatic()) {
          bodies.get(k).get(i).iterate(bodies.get(k).get(j), it);}}}
    for (int i = 0; i < bodies.get(k).size(); i++) {
      if (!bodies.get(k).get(i).returnDuplicate()) {
        bodies.get(k).get(i).sketch();
        //println("X: " + bodies.get(k).get(i).getX() + " Y: " + bodies.get(k).get(i).getY() + " DX: " + bodies.get(k).get(i).getDX()+ " DY: " + bodies.get(k).get(i).getDY());
        dots[indexL][0][i][k] = bodies.get(k).get(i).getX();
        dots[indexL][1][i][k] = bodies.get(k).get(i).getY();
        indexL++;
        if (indexL == dotsL-1) {
          indexL = 0;}
        drawDots();}}}
   if (selector == 3) {
     line(0,0,bodies.get(0).get(1).getX(),bodies.get(0).get(1).getY());
     line(0,0,bodies.get(1).get(1).getX(),bodies.get(1).get(1).getY());}
   t+= it;
   //if(t< 27.37) {
   //  rSum += sqrt(sq(bodies.get(0).get(0).getX()-bodies.get(0).get(1).getX())+sq(bodies.get(0).get(0).getY()-bodies.get(0).get(1).getY()))/27.37*it;}
   //println(rSum);
   //println(float(int(t*100))/100);
 }
void drawDots() {
  stroke(255);
  for (int k = 0; k < bodies.size(); k++) {
    for (int j = 0; j < bodies.get(k).size(); j++) {
      if (!bodies.get(k).get(j).returnStatic() && !bodies.get(k).get(j).returnDuplicate()) {
      for (int i = 0; i < dotsL; i++) {
        point(dots[i][0][j][k], dots[i][1][j][k]);}}}}}
