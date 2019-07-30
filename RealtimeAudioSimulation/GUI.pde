// Documentation: http://www.sojamo.de/libraries/controlP5/#examples

ControlP5 cp5;

DropdownList BuildTypeDL;
Slider ThicknessSlider;
RadioButton ActionSelectR;

void setupGUI() {

  cp5 = new ControlP5(this);
  // create a DropdownList
  BuildTypeDL = cp5.addDropdownList("Build Type")
          .setPosition(width-100, 75);

  ThicknessSlider = cp5.addSlider("Thickness (cm)")
     .setPosition(width-310, 20)
     .setRange(1,20)
     .setValue(6)
     .setNumberOfTickMarks(10)
     .setSliderMode(Slider.FLEXIBLE);

  ActionSelectR = cp5.addRadioButton("ActionSelect")
         .setPosition(width-135,20)
         .setSize(20,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(2)
         .setSpacingColumn(40)
         .addItem("Select",1)
         .addItem("Rotate",2)
         .addItem("Build",3)
         .addItem("Remove",4);

  customize(BuildTypeDL); // customize lists
  BuildTypeDL.addItem("Brick", 0);
  BuildTypeDL.addItem("Wood", 1);
  BuildTypeDL.addItem("Speaker", 2);
  BuildTypeDL.addItem("Sim Ears", 3);

}

void ActionSelect(float v){
  println(v);
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(200));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.setWidth(75);
  ddl.setColorBackground(color(75));
  ddl.setColorActive(color(255, 128));
}


void controlEvent(ControlEvent theEvent) {
  boolean DEBUG = false;
  
  if (theEvent.isFrom(ActionSelectR)) {
    int val = (int)theEvent.getValue();
    if(val != 3){ // value 3 = building
      showLine = false; // Cancel current wall build
    }
    if(val != 1){ // value 3 = building
      SelectedID = -1; // Cancel selection
    }
  }
  
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup() && DEBUG) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  }
  else if (theEvent.isController() && DEBUG) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}


boolean isMouseOverGUI(){
  return cp5.isMouseOver();
}