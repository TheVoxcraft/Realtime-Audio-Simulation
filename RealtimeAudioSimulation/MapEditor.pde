float WALL_BUILD_STEP_SIZE = 1;

boolean showLine = false;
PVector showStartPos = new PVector(0,0);
PVector showEndPos = new PVector(0,0);
float showSelectedTickness;

int SelectedID = -1;
int SelectedBuildType = 0; 

void MapEditorSetup(){
  InitWallColors();
}

void showBuildingLine(){
  if(showLine){
    stroke(120,120,220,210);
    strokeWeight(showSelectedTickness);
    line(showStartPos.x, showStartPos.y, showEndPos.x, showEndPos.y);
  }
}

void MapEditorClick(){
  if(!isMouseOverGUI()){
    float ActionSelectValue = ActionSelectR.getValue(); // Build: int 3
    if(ActionSelectValue == 3 && showLine == false && SelectedBuildType <= 4){
      showStartPos = new PVector((round(mouseX/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE, (round(mouseY/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE);
      showEndPos = new PVector((round(mouseX/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE, (round(mouseY/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE);
      showSelectedTickness = ThicknessSlider.getValue();
      showLine = true;
  
    } else if(ActionSelectValue == 3 && showLine == true){
      showLine = false;
      BuildLine();
    }
    
    if(ActionSelectValue == 3 && SelectedBuildType == 5){ 
      BuildSpeaker();
    }
    
    if(ActionSelectValue == 3 && SelectedBuildType == 5){ 
      BuildMicrophone();
    }
    
    if(ActionSelectValue == 4){ // Remove: int 4
      for(int i=0; i<walls.size(); i++){
        
        if(walls.get(i).collision(new PVector(mouseX, mouseY)) == true){
          walls.remove(i);
          break;
        }
      }
    }
    
    if(ActionSelectValue == 1){ // Select: int 4
      for(int i=0; i<walls.size(); i++){
        if(walls.get(i).collision(new PVector(mouseX, mouseY)) == true){
          SelectedID = walls.get(i).ID;
          println("Selected: " + SelectedID);
          break;
        }
      }
    }
  }
}

boolean isFlat = false;
void MapEditorUpdate(){
  
  if(showLine){
    BuildingLine();
  }

  for(int i=0; i<walls.size(); i++){
    walls.get(i).display();
  }
  
  if(SelectedID >= 0){
    fill(255);
    text("Selected "+SelectedID, 20, height-22*2);
  }
  
  fill(220,220,255,200);
  textSize(10);
  text("mouseX: "+mouseX+", mouseY: "+mouseY, 20, height-22); // DEBUG
  
}

void BuildingLine(){
  float xoffset = abs(mouseX-showStartPos.x);
  float yoffset = abs(mouseY-showStartPos.y);
    
  if(xoffset < yoffset){
    showEndPos = new PVector(showStartPos.x, (round(mouseY/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE);
    isFlat = false;
    fill(255); // DEBUG
    text(round((int)(showEndPos.x-showStartPos.x+showSelectedTickness))+" cm", 20, 20);
    text(abs((int)(showEndPos.y-showStartPos.y))+" cm", 20, 35);
    }
  else if(xoffset > yoffset) {
    showEndPos = new PVector((round(mouseX/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE, showStartPos.y);
    isFlat = true;
      
    fill(255); // DEBUG
    text(abs((int)(showEndPos.x-showStartPos.x))+" cm", 20, 20);
    text(abs((int)(showEndPos.y-showStartPos.y+showSelectedTickness))+" cm", 20, 35);
  }
}

void BuildLine(){
  walls.add(new Wall(showStartPos, showEndPos, showSelectedTickness, isFlat, SelectedBuildType));
}

void BuildMicrophone(){


}

void BuildSpeaker(){
  

}
