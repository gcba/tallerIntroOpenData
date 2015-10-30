
//LABELS CONF
boolean SHOW_LABELS = true;
final int     LABEL_SIZE = 5;

//STATIONS CONF
final int STATION_SIZE = 8;

final int SECONDS_SPEED = 10;
final int MINUTES_SPEED = 1;
final int HOURS_SPEED = 1;
final int FINALTIME = 21;

String TIME2RESET= "";
boolean running = true;
boolean stationsRendered = false;
String csvStation = "estBiciPub.csv";
String csvTravels = "recBici.csv";
String mapImg = "ba-Map.png";
PImage map;
PGraphics tempScreen;
float appCycles;
PImage rStations;
int eclipse = 960/2+80;
int total = 540/2-30;