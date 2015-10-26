public void setup() {
  size(800, 450);
  noLoop();
  noStroke();
  fill(255);
}

public void draw() {
  background(0);
  textAlign(CENTER);
  text("CARGANDO...", width/2, height/2);
  
  XML[] stations = getStations();
  textAlign(LEFT);
  for (int i=0; i<stations.length; i++) {
    String name = stations[i].getChild("EstacionNombre").getContent();
    String availableBikes = stations[i].getChild("BicicletaDisponibles").getContent();
    println(name + " " + availableBikes);
  }
}

public XML[] getStations() {
  String ecobiciUrl = "http://recursos-data.buenosaires.gob.ar/ckan2/ecobici/estado-ecobici.xml";
  String response[] = loadStrings(ecobiciUrl);
  XML xml = parseXML(response[0]);
  XML stations[] = xml.getChild("soap:Body").getChild("BicicletasWSResponse").getChild("BicicletasWSResult").getChild("Bicicletas").getChild("Estaciones").getChildren("Estacion");
  return stations;
}