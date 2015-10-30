
Estacion getStationById(int id) {
  int e = 0;
  for (int i=0; i<estaciones.size (); i++) {
    Estacion temp = estaciones.get(i);
    if (temp.id == id) {
      e = i;
    }
  }
  return estaciones.get(e);
}

void upDateClock() {
  if(estaciones.size() == 0){
    clock = new timeStamp(TIME2RESET);
  }
  if (running) {
    clock.segs+=SECONDS_SPEED;
      if (clock.segs>=60) {
      clock.segs =0;
      clock.mins+=MINUTES_SPEED;
    }
    if (clock.mins>=60) {
      clock.mins = 0;
      clock.hours+=HOURS_SPEED;
    }
    if(clock.hours > FINALTIME){
    running = false;
    clock.hours=0;
    }
    //println(">> "+clock.hours+":"+clock.mins+":"+clock.segs+" hrs.");
  }
}


int difTime(timeStamp clock, timeStamp tTime){
  int clockInMinutes = round(clock.hours*60+clock.mins+clock.segs*0.0166666667f);
  int timeInMinutes = round(tTime.hours*60+tTime.mins+tTime.segs*0.0166666667f);
  return clockInMinutes-timeInMinutes;
}