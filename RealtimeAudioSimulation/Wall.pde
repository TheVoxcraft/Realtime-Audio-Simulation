ArrayList<Wall> walls = new ArrayList<Wall>();

import java.util.Map;

color wallColor = color(255);

float[] WALL_COEFF_WOOD = {.15, .11, .10, .07, .06, .03};
float[] WALL_COEFF_PLYWOOD = {.25, .1, .05, .04, .09, .06};
float[] WALL_COEFF_MARBLE = {.01, .01, .01, .01, .02, .015};
float[] WALL_COEFF_BRICK = {.03, .03, .03, .04, .05, .04};
float[] WALL_COEFF_CURTAINS = {.15, .35, .55, .75, .70, .50};

HashMap<Integer,Integer[]> WallColors = new HashMap<Integer,Integer[]>();

void InitWallColors(){
  WallColors.put(0,new Integer[] {100, 30, 30});
  WallColors.put(1,new Integer[] {160, 120, 110});
}



class Wall{
 float thickness;
 PVector StartPos;
 PVector EndPos;
 float[] WallCoefficient; // 125, 250, 500, 1000, 2000, 8000
 boolean flat;
 
 int type = 0;
 int ID;

 Wall(PVector _sp, PVector _ep, float _t, boolean _f){
   ID = (int)random(10000,99999);
   
   WallCoefficient = WALL_COEFF_WOOD;
   
   
   thickness = _t;
   StartPos = _sp;
   EndPos = _ep;
   flat = _f;
 }

 void display(){
   stroke(WallColors.get(type)[0],WallColors.get(type)[1],WallColors.get(type)[2]);
   
   strokeWeight(thickness);
   line(StartPos.x, StartPos.y, EndPos.x, EndPos.y);
   
   //testLines(); // DEBUG
 }
 
 boolean collision(PVector other){
   PVector cornerA = new PVector(StartPos.x, StartPos.y);
   PVector cornerB = new PVector(EndPos.x, EndPos.y);
   
   if(flat == false){
     cornerA.x-=thickness*.5;
     cornerB.x+=thickness*.5;
   } else if(flat == true){
     cornerA.y-=thickness*.5;
     cornerB.y+=thickness*.5;
   }
   
   /*
   println("-- wall "+ID+"--");
   println("wS "+cornerA.x+" "+cornerA.y);
   println("wE "+cornerB.x+" "+cornerB.y);
   println("M  "+mouseX+" "+mouseY);
   */
   
   if(isBetween(other.x, cornerA.x, cornerB.x)){
     if(isBetween(other.y, cornerA.y, cornerB.y)){
       return true;
     }
   }
   
   return false;
 }
 
boolean isBetween(float n, float a, float b) {
  if((n - a) * (n - b) <= 0)
    return true;
  return false;
}
 
 void testLines(){
   PVector cornerA = new PVector(StartPos.x, StartPos.y);
   PVector cornerB = new PVector(EndPos.x, EndPos.y);
   
   PVector other = new PVector(mouseX, mouseY);
   if(flat == false){
     cornerA.x-=thickness*.5;
     cornerB.x+=thickness*.5;
   } else if(flat == true){
     cornerA.y-=thickness*.5;
     cornerB.y+=thickness*.5;
   }
   noStroke();
   fill(255,100,50);
   ellipse(cornerA.x,cornerA.y,5,5);
   fill(100,255,50);
   ellipse(cornerB.x,cornerB.y,5,5);
 }

}
