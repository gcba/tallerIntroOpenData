public void setup() {
  size(960, 540);
  noLoop();
  noStroke();
  fill(255);
  textSize(20);
}

public void draw() {
  HashMap<String, Integer> calls = getCallCount();
  printInfo(calls);
}

public HashMap<String, Integer> getCallCount() {
  HashMap<String, Integer> calls = new HashMap<String, Integer>();
  String csvPath = "../../data/147_enero.csv";
  Table csv = loadTable(csvPath, "header");
  for (TableRow row : csv.rows()) {
    String barrio = row.getString("barrio");
    if (calls.containsKey(barrio)) {
      calls.put(barrio, calls.get(barrio) + 1);
    } else {
      calls.put(barrio, 1);
    }
  }
  return calls;
}

public void printInfo(HashMap<String, Integer> calls) {
  textAlign(LEFT, TOP);
  background(0);
  int xOffset = 10;
  int yOffset = 10;
  ArrayList<String> lines = new ArrayList<String>();
  String currentLine = "";
  for (String barrio : calls.keySet()) {
    if (currentLine.length() == 0) {
      currentLine = barrio + " " + calls.get(barrio);
    } else {
      String newInfo = barrio + " " + calls.get(barrio);
      if (textWidth(currentLine) + textWidth("  ") + textWidth(newInfo) + 2*xOffset < width) {
        currentLine += "  " + newInfo;
      } else {
        lines.add(currentLine);
        currentLine = newInfo;
      }
    }
  }
  lines.add(currentLine);
  String info = "";
  for (int i=0; i<lines.size(); i++) {
    info += lines.get(i) + "\n";
  }
  text(info, xOffset, yOffset);
}