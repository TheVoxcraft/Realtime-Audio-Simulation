class Speaker{
  
  String srcFile;
  
  Speaker(String path){
    
    loadAudio("AudioFiles/GuitarMusic.wav");
  }
  
  void loadAudio(String path){
    srcFile = sketchPath("") + path;
  }
}
