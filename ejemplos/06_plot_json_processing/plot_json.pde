public void setup() {
  size(960, 540);
  noLoop();
  stroke(255);
  strokeWeight(5);
  textSize(40);
  background(0);
  textAlign(CENTER, CENTER);
  text("CARGANDO...", width/2, height/2);
}

public void draw() {
  JSONObject weatherFeed = getFeed();
  printFeed(weatherFeed);
}

public JSONObject getFeed() {
  String feedUrl = "http://api.thingspeak.com/channels/26840/feed.json";
  String response[] = loadStrings(feedUrl);
  JSONObject json = JSONObject.parse(response[0]);
  return json;
}

public void printFeed(JSONObject weatherFeed) {
  background(0);
  JSONArray weather = weatherFeed.getJSONArray("feeds");
  float[] temps = new float[weather.size()];
  for (int i=0; i<weather.size(); i++) {
    temps[i] = float(weather.getJSONObject(i).getString("field1"));
  }
  float minTemp = min(temps);
  float maxTemp = max(temps);
  float fromX = 0;
  float fromY = -(temps[0]-minTemp) / (maxTemp-minTemp) * height/3 + height*2/3; 
  for (int i=1; i<temps.length; i++) {
    float toX = width*i/(temps.length-1);
    float toY = -(temps[i]-minTemp) / (maxTemp-minTemp) * height/3 + height*2/3;
    line(fromX, fromY, toX, toY);
    fromX = toX;
    fromY = toY;
  }
}