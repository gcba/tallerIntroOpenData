public void setup() {
  size(960, 540);
  noLoop();
  noStroke();
  fill(255);
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
  JSONArray weather = weatherFeed.getJSONArray("feeds");
  JSONObject lastWeather = weather.getJSONObject(weather.size() - 1);
  String info = "La Plata\nTemperatura " + lastWeather.getString("field1") + " °\nHumedad " + lastWeather.getString("field2") + " %\nPresion " + lastWeather.getString("field3") + " hPa";
  background(0);
  text(info, width/2, height/2);
}