//TRAVELS CONSTRUCTOR
// Esta funcion se encarga de cargar los
// datos del CSV de viajes de bicis.
void buildTravels() {
  Table stTable = loadTable("recBicis1d.csv", "header");
  int trLoaded = 0;
  for (TableRow row : stTable.rows ()) {
    int idOrigen  = row.getInt("origenestacionid");
    int idDestino = row.getInt("destinoestacionid"); 
    Estacion tEst = getStationById(idOrigen);
    int  useTime  = row.getInt("tiempouso")*60;
    timeStamp startUseAt = new timeStamp(row.getString("origenfecha"));
    viajes.add( new bTravel(idOrigen, idDestino, useTime, startUseAt, int(tEst.x) , int(tEst.y )));
    if (trLoaded == 0) {
      clock = startUseAt;
      TIME2RESET= row.getString("origenfecha");
      println(row.getString("origenfecha"));
      println(">> Initial time:  "+clock.hours+":"+clock.mins+":"+clock.segs+"hrs.");
      println(">> Initial Date:  "+clock.days+"/"+clock.months+"/"+clock.year+".");
    }
    trLoaded++;
  }
  trLoaded++;
  println(trLoaded+" loaded travels...");
}



void buildStations() {
  Table stTable = loadTable("estBiciPub.csv", "header");
  int stLoaded = 0;
  for (TableRow row : stTable.rows ()) {
    PVector marker = mercatorMap.getScreenLocation(new PVector(row.getFloat("lon"), row.getFloat("lat")));
    float   _x    = marker.x;
    float   _y    = marker.y;
    int     _id   = row.getInt("id");
    String  _name = row.getString("nombre");
    estaciones.add(new Estacion(_x, _y, _name, _id));
    stLoaded++;
  }
  stLoaded++;
  println(stLoaded+" stations loaded.... DONE!");
  image(drawEst(), 0, 0);
}