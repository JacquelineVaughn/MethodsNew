class AudioPlayer
{
  private AudioInputStream stream; // Holds stream data for the system
  private Clip audio; // Access to playback, loop, and scrubbing controls
  
  /**
   * Default constructor.
   */
  public AudioPlayer(File input)
  {
    // Make sure input file exists before attempting to load it.
    if(input == null || !input.exists()) throw new IllegalArgumentException("Input file must not be null, and must exist.");
    
    try{
      // Load stream data
      stream = AudioSystem.getAudioInputStream(input);
      // Generate clip handler from stream metadata
      audio = (Clip)AudioSystem.getLine(new DataLine.Info(Clip.class, stream.getFormat()));
      // Open clip stream
      audio.open(stream);
    }catch(UnsupportedAudioFileException e){
      throw new IllegalArgumentException("Source file is of an incompatible format.");
    }catch(LineUnavailableException e){
      throw new IllegalStateException("Audio engine could not obtain stream from given file.");
    } catch(IOException e){
      throw new IllegalArgumentException("Source file could not be read.");
    }
  }
  
  public void stop(){
    audio.stop();
  }
  
  public void play(){
    audio.start();
  }
  
  public void loop(int times)
  {
    // Start playback from the beginning of the clip, regardless of where it is right now
    if(isPlaying()) audio.stop();
    audio.start();
    // Loop the entire clip n times (actual nunber is n-1 due to the first playback run not counting as a loop)
    audio.setLoopPoints(0, -1);
    audio.loop(times - 1);
  }
  
  public boolean isPlaying(){
    return audio.isRunning();
  }
  
  public void addListener(LineListener listener){
    if(listener != null) audio.addLineListener(listener);
  }
  
  @Override
  public void finalize(){
    // Close the audio stream when this object is destroyed by the JVM garbage collector.
    audio.close();
  }
}


import javax.sound.sampled.*;

//declaring variables
PImage hand1;
PImage hand2;
PImage hand3;
PImage hand4;
PImage hand5;
PImage person;
boolean go=false;
float x=0;
float y=560;
float speed = 2;
PImage NBG;
//declaring string
String[] n={"1","2","3","4","5","6"};
String num ="";
  void move(){
  x=x+speed;
  if(x>width){
    y=560;
    x=0;
  }
}
void display(){
  imageMode(CENTER);
  image(person,x,y,300,300);
}
void setup(){
  size(1000,700);
  background(0);
//initializing hand images
  hand1=loadImage("BLANKhand.png");
  hand2=loadImage("BLANKhand2.png");
  hand3=loadImage("BLANKhand3.png");
  hand4=loadImage("BLANKhand4.png");
  hand5=loadImage("BLANKhand5.png");
  person=loadImage("Person.png");
  // Load the target clip into memory and start playback
  File src = new File((dataPath("surreal.wav")));
  AudioPlayer pl = new AudioPlayer(src);
  pl.loop(0);
  NBG=loadImage("BLANKbackground.png");
}
void draw(){
  background(0);
  imageMode(CORNER);
  image(NBG,0,0,1000,700);
  hands();
  if(go==true){
    display();
    move();
  }
}

void mouseClicked(){
  //makes it pick a random number
  num=n[int(random(5))];
    go=true;
}
//makes hand method
void hands(){
  imageMode(CORNER);
  if(num=="1"){
    image(hand1,0,200,200,500);
  }
  if(num=="2"){
    image(hand2,500,0,700,200);
  }
  if(num=="3"){
    image(hand3,0,200,200,500);
  }
  if(num=="4"){
    image(hand4,0,400,200,400);
  }
  if(num=="5"){
    image(hand5,600,0,400,200);
  }
}
