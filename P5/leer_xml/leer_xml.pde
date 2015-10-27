public void setup() {
  size(960, 540);
  noLoop();
  noStroke();
  fill(255);
  textSize(20);
  background(0);
  textAlign(CENTER);
  text("CARGANDO...", width/2, height/2);
}

public void draw() {
  XML[] stations = getStations();
  printInfo(stations);
}

public XML[] getStations() {
  String ecobiciUrl = "http://recursos-data.buenosaires.gob.ar/ckan2/ecobici/estado-ecobici.xml";
  String response[] = loadStrings(ecobiciUrl);
  XML xml = parseXML(response[0]);
  XML stations[] = xml.getChild("soap:Body").getChild("BicicletasWSResponse").getChild("BicicletasWSResult").getChild("Bicicletas").getChild("Estaciones").getChildren("Estacion");
  return stations;
}

public void printInfo(XML[] stations) {
  textAlign(LEFT, TOP);
  background(0);
  int xOffset = 10;
  int yOffset = 10;
  ArrayList<String> lines = new ArrayList<String>();
  lines.add("Bicicletas disponibles");
  String currentLine = stations[0].getChild("EstacionNombre").getContent() + " " + stations[0].getChild("BicicletaDisponibles").getContent();
  for (int i=1; i<stations.length; i++) {
    String name = stations[i].getChild("EstacionNombre").getContent();
    String availableBikes = stations[i].getChild("BicicletaDisponibles").getContent();
    String newInfo = name + " " + availableBikes;
    if (textWidth(currentLine) + textWidth("  ") + textWidth(newInfo) + 2*xOffset < width) {
      currentLine += "  " + newInfo;
    } else {
      lines.add(currentLine);
      currentLine = newInfo;
    }
  }
  lines.add(currentLine);
  String info = "";
  for (int i=0; i<lines.size(); i++) {
    info += lines.get(i) + "\n";
  }
  text(info, xOffset, yOffset);
}