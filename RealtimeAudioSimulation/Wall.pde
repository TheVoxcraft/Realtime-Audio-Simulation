ArrayList<Wall> walls = new ArrayList<Wall>();

import java.util.Map;

color wallColor = color(255);
float WALL_WIDTH_MULTIPLIER = 2;

HashMap<String,float[]> WallCoefficients = new HashMap<String,float[]>();
HashMap<String,int[]> WallColors = new HashMap<String,int[]>();
void InitWallCoefficients(){
  WallCoefficients.put("wood",new float[] {.15, .11, .10, .07, .06, .3});
  //WallCoefficients.put("brick",new Float[] {});
}
void InitWallColors(){
  WallColors.put("wood",new int[] {200, 150, 120});
  WallColors.put("brick",new int[] {230, 230, 230});
}


class Wall{
 float thickness;
 PVector StartPos;
 PVector EndPos;
 float[] WallCoefficient = new float[6]; // 125, 250, 500, 1000, 2000, 8000
 boolean flat;
 
 String type = "wood";
 int ID;

 Wall(PVector _sp, PVector _ep, float _t, boolean _f){
   ID = (int)random(10000,99999);
   
   WallCoefficient = new float[] {.15, .11, .10, .07, .06, .3};
   
   thickness = _t;
   StartPos = _sp;
   EndPos = _ep;
   flat = _f;
 }

 void display(){
   stroke(WallColors.get(type)[0],WallColors.get(type)[1],WallColors.get(type)[2]);
   
   strokeWeight(thickness * WALL_WIDTH_MULTIPLIER);
   line(StartPos.x, StartPos.y, EndPos.x, EndPos.y);
   
   //testLines(); // DEBUG
 }
 
 boolean collision(PVector other){
   PVector cornerA = new PVector(StartPos.x, StartPos.y);
   PVector cornerB = new PVector(EndPos.x, EndPos.y);
   
   if(flat == false){
     cornerA.x-=thickness;
     cornerB.x+=thickness;
   } else if(flat == true){
     cornerA.y-=thickness;
     cornerB.y+=thickness;
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
     cornerA.x-=thickness;
     cornerB.x+=thickness;
   } else if(flat == true){
     cornerA.y-=thickness;
     cornerB.y+=thickness;
   }
   noStroke();
   fill(255,100,50);
   ellipse(cornerA.x,cornerA.y,5,5);
   fill(100,255,50);
   ellipse(cornerB.x,cornerB.y,5,5);
 }

}


class WallTypes{
  class wood{
    color COLOR = color();
  }
  
}
