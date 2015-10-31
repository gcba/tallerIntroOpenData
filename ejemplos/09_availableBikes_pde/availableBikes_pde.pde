String dataURL = "http://recursos-data.buenosaires.gob.ar/ckan2/ecobici/estado-ecobici.xml";
final float maxStationSize = 80;
final float minStationSize = 10;
String mapImg = "ba-Map.png";
PImage m;
int udTime = int(60 * 5 * frameRate);


MercatorMap  mercatorMap;

  class Station {
  private String name; 
  private float lat, lon;
  public int ba, racks;
  public float x, y;

  Station(String _name, float _lat, float _lon, int  _ba, float _x, float _y, int _racks) {
    name = _name; 
    lat = _lat; 
    lon = _lon; 
    ba = _ba;
    racks = _racks;
    y = _y;
    x = _x;
  }
}



final int xPad = 5;
final int yPad = 5;

void iDraw(float frames){
  background(20);
  image(m,0,0);
  float xSize = width-10;
  float per = map(frames, 0,(float)udTime,0,xSize); 
  float r = map(frames,0,(float)udTime,180,255);
  noStroke();
  fill(60,0,0);
  rect(5,height-yPad, xSize,3);
  fill(r,0,0);
  triangle(xSize-per+12,height-yPad*3,xSize-per-2,height-yPad*3,xSize-per+5,height-yPad*2);
  rect(5,height-yPad, xSize-per,3);
  stroke(r,0,0);
  line(xSize-per+xPad,height-yPad,xSize-per+xPad,height-yPad*3);
}






void setup() {
  cursor(CROSS);
  size(960, 540);
  smooth(8);
   m = loadImage(mapImg);
  iDraw(frameCount % udTime);
  noStroke(); fill(255); textSize(20);
  text("Cargando...", width/2-"Cargando...".length() * 5, height/2);  
  mercatorMap = new MercatorMap(960, 540, -34.512, -34.7129, -58.637, -58.2044); 
  getStations();
  updateInfo(stationsXML, false);
}

void printdata(){
  for (int i = 0; i< Stations.size(); i++){
    Station s = Stations.get(i);
    float d = map(s.ba, 0, s.racks,0,360);
    if(dist(mouseX,mouseY,s.x,s.y) < s.racks*.2 ){
      fill(20);
      noStroke();
      rect( width*3/4-10,170,200, 120);
      textSize(18);
      String n = s.name;
      if(n.length() > 17){
        n = n.substring(0,16)+"...";
      } 
      fill(200);text(n, width*3/4,200);
      fill(200,0,0); rect(width*3/4-10,170,200, 5);
      textSize(13);
      fill(110);text("Anclajes Totales: ", width*3/4,230);
      fill(200,0,0); text(s.racks, width*3/4+160,230);
      fill(110); text("Bicicletas Disponibles: ", width*3/4,250);
      fill(200,0,0); text(s.ba, width*3/4+160,250);
      fill(110); text("Anclajes Disponibles: ", width*3/4,270);
      fill(200,0,0); text(str(s.racks-s.ba), width*3/4+160,270);
      stroke(200,0,0);
      line(s.x,s.y,width*3/4-10,172);
  }
    fill(200,150);
    noStroke();
    arc(s.x,s.y, s.racks*.5,s.racks*.5, 0, radians(d));
    fill(180,0,0); noStroke();
    ellipse(s.x,s.y,s.racks*.4,s.racks*.4);
    textSize(6);
    fill(200);
    text(s.ba, s.x-str(s.ba).length(), s.y+2);
  }
}
float f = 0;
void draw() {
  if(frameCount % udTime== 0){
    thread("getStations");
    println("Making request....");
    f = 0; 
  }
  f++;
  iDraw(f);
  printdata();  
}