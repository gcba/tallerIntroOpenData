
void printTravels() {
  background(0);
  image(map,0,0);
  image(drawEst(), 0, 0);
  for (int i=0; i< viajes.size (); i++) {
    bTravel tempViaje = viajes.get(i);
    int timeDifference = difTime(clock, tempViaje.timeStart);
    if ( timeDifference >= 0) {
      Estacion eO = getStationById(tempViaje.origen);
      Estacion eD = getStationById(tempViaje.destino);
      float ny=0;
      float nx=0;
      nx  = eO.x -(eO.x - eD.x)/tempViaje.travelTime*tempViaje.dreco;
      ny = eO.y -(eO.y - eD .y)/tempViaje.travelTime*tempViaje.dreco;                    
      if (tempViaje.dreco <= tempViaje.travelTime) {
        strokeWeight(0.5);
        stroke(180);
        line(eO.x,eO.y, eD.x,eD.y);
        noStroke();
        fill(255,180);
        ellipse(nx, ny,5,5);
        tempViaje.dreco+=SECONDS_SPEED;
        viajes.set(i, tempViaje);
      } else {
        viajes.remove(i);
      }
    }
  }
  fill(255);
  String cp ="";
  if(clock.hours < 10){cp = "0"+str(clock.hours); }  else  {cp = str(clock.hours);  }
  if(clock.mins < 10){cp += ":0"+str(clock.mins);}  else  {cp +=":"+str(clock.mins);}
  if(clock.segs < 10){cp += ":0"+str(clock.segs);}  else  {cp +=":"+str(clock.segs);}
  textSize(30);
  text(cp, width-cp.length()*20, height-20);
}



PImage drawEst() {
  if(!stationsRendered){
  tempScreen = createGraphics(960, 540);
  tempScreen.beginDraw();
  for (int i=0; i < estaciones.size (); i++ ) {
    Estacion tE = estaciones.get(i);
    tempScreen.stroke(200,0,0, 120);
    tempScreen.strokeWeight(STATION_SIZE);
    tempScreen.fill(200,0,0);
    tempScreen.ellipse(tE.x, tE.y,STATION_SIZE, STATION_SIZE);
    if(SHOW_LABELS){
     tempScreen.fill(200,0,0);
     tempScreen.textSize(LABEL_SIZE);
     tempScreen.fill(200);
     int ddx, ddy;
     ddy = ddx = 0;
     print(tE.x+" == "+eclipse+"?");
     if(tE.x < eclipse){tempScreen.textAlign(RIGHT); ddx = -20;println("RIGHT");}else{ tempScreen.textAlign(LEFT);println("LEFT");ddx = 20;}
     if(tE.y < total){ ddy = -20;}else{ ddy = 20;}

     float tx = tE.x+ddx;
     float ty = tE.y+int(LABEL_SIZE/2)+ddy;
     tempScreen.text(tE.name, tx, ty );
     tempScreen.stroke(150);
     tempScreen.strokeWeight(.5f);
     tempScreen.line(tx,ty,tE.x,tE.y);
     noStroke();
     tempScreen.fill(150);
     tempScreen.ellipse(tE.x,tE.y,1,1);
     tempScreen.ellipse(tx,ty,1,1);
    }

  }
  tempScreen.endDraw();
  stationsRendered = true;
  rStations = tempScreen.get();
  }
  return rStations;
}