/*

Features:
*  Map  Editor  - build rooms (different types of walls, ex: wood, brick)
               move simulation ears
               move simulation speaker
* Realtime audio simulation - sound bounce sim
  ** Inverse square law: (1/d^2)
  ** Microsound delay: (m*1000)/340 = ms delay
* Custom Sounds

*/

import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

void setup(){
  size(800, 600, P3D);
  strokeCap(SQUARE);

  setupGUI();
  MapEditorSetup();

}

void draw(){
  background(28);
  showBuildingLine();

  MapEditorUpdate();
}

void keyPressed(){

}

void mouseClicked(){
   MapEditorClick();
}
