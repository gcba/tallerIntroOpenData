ArrayList<bTravel> viajes = new ArrayList<bTravel>();

class bTravel {
  int actX,actY,destino,origen;
  float travelTime;
  float dreco= 0;
  timeStamp timeStart;
  bTravel(int eO, int eD, float tT, timeStamp tStart, int apX, int apY) {
    origen     = eO; 
    destino    = eD; 
    travelTime = tT;
    timeStart = tStart;
    actX = apX; actY = apY;
  }
}


class timeStamp {
  int segs; 
  int mins; 
  int hours;
  int days; 
  int months; 
  int year;

  timeStamp(String _sTimeStamp) {
    year = parseInt(_sTimeStamp.substring(0, 4)); 
    months = parseInt(_sTimeStamp.substring(5, 7)); 
    days = parseInt(_sTimeStamp.substring(8, 10));
    hours = parseInt(_sTimeStamp.substring(11, 13)); 
    mins = parseInt(_sTimeStamp.substring(14, 16)); 
    days = parseInt(_sTimeStamp.substring(17, 19));
  }
}


class Estacion {
  float x;
  float y;
  int id; 
  String name;
  color  rColor=color(random(255), random(255), random(255));
  Estacion(float _x, float _y, String _name, int _id) {
    x    = _x;
    y    = _y;
    name = _name;
    id   = _id;
  }
}