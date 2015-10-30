ArrayList<Estacion> estaciones = new ArrayList<Estacion>();
MercatorMap mercatorMap;
boolean showMap = true;
timeStamp clock; 


void setup() {
  size(960 , 540);
  smooth(8);
  map = loadImage(mapImg);
  ellipseMode(CENTER);
  background(0);
  mercatorMap = new MercatorMap(960 , 540, -34.512, -34.7129, -58.637, -58.2044); 
  buildStations();
  buildTravels();
}


void draw() {
  image(map,0,0);  
  upDateClock();
  if(running){
  printTravels();
  }
}