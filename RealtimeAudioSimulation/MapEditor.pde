float WALL_BUILD_STEP_SIZE = 1;

boolean showLine = false;
PVector showStartPos = new PVector(0,0);
PVector showEndPos = new PVector(0,0);
float showSelectedTickness;

int SelectedID = -1;
int SelectedBuildType = -1; 

void MapEditorSetup(){
  InitWallCoefficients();
  InitWallColors();
}

void showBuildingLine(){
  if(showLine){
    stroke(120,120,220,210);
    strokeWeight(showSelectedTickness * WALL_WIDTH_MULTIPLIER);
    line(showStartPos.x, showStartPos.y, showEndPos.x, showEndPos.y);
  }
}

void MapEditorClick(){
  if(!isMouseOverGUI()){
    float ActionSelectValue = ActionSelectR.getValue(); // Build: int 3
    if(ActionSelectValue == 3 && showLine == false){
      showStartPos = new PVector((round(mouseX/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE, (round(mouseY/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE);
      showEndPos = new PVector((round(mouseX/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE, (round(mouseY/WALL_BUILD_STEP_SIZE))*WALL_BUILD_STEP_SIZE);
      showSelectedTickness = ThicknessSlider.getValue();
      showLine = true;
  
    } else if(ActionSelectValue == 3 && showLine == true && !isMouseOverGUI()){
      showLine = false;
      BuildLine();
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

  for(int i=0; i<walls.size(); i++){
    walls.get(i).display();
  }
  
  if(SelectedID >= 0){
    fill(255);
    text("Selected "+SelectedID, 20, height-22);
  }
  
  text("mouseX: "+mouseX+", mouseY: "+mouseY, 20, height-22*2); // DEBUG
  
  /*
  if(walls.size() > 0){
  for(int j=0; j<height; j++){
    for(int i=0; i<width; i++){
      for(int k=0; k<walls.size(); k++){
        if(walls.get(k).collision(new PVector(i, j)) == true){
          noStroke();
          fill(2,2,240);
          rect(i,j,1,1);
        }
      }
    }
  }
  }*/
}

void BuildLine(){
  walls.add(new Wall(showStartPos, showEndPos, showSelectedTickness, isFlat));
}
