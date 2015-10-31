XML stationsXML[];

public void getStations() {
  String ecobiciUrl = "http://recursos-data.buenosaires.gob.ar/ckan2/ecobici/estado-ecobici.xml";
  String response[] = loadStrings(ecobiciUrl);
  XML xml = parseXML(response[0]);
  stationsXML = xml.getChild("soap:Body").getChild("BicicletasWSResponse").getChild("BicicletasWSResult").getChild("Bicicletas").getChild("Estaciones").getChildren("Estacion");
}

ArrayList<Station> Stations = new ArrayList <Station>();

void updateInfo(XML [] StXML , boolean update){
  for (int i = 0; i< StXML.length; i++){
    String _name = StXML[i].getChild("EstacionNombre").getContent();
    float _lat   = parseFloat(StXML[i].getChild("Latitud").getContent());
    float _lon   = parseFloat(StXML[i].getChild("Longitud").getContent());
    int _ba      = parseInt(StXML[i].getChild("BicicletaDisponibles").getContent());
    int _aracks  = parseInt(StXML[i].getChild("AnclajesDisponibles").getContent());
    int _racks   = parseInt(StXML[i].getChild("AnclajesTotales").getContent());
    if (update){
      //DO SOMETHING
    }else{
      PVector marker = mercatorMap.getScreenLocation(new PVector(_lat,_lon));
      Stations.add(new Station(_name, _lat, _lon,_ba, marker.x, marker.y , _racks ));
    }
      Station s = Stations.get(i);
      s.ba = _ba;
      Stations.set(i,s);
  }
}