Table tabla;
int escala = 2;
int offset = 350;
int pasoColor = 35;
int pasoPromedio = 7;
int start = 50;
int[] promedios = new int[0]; // Contiene los promedios cada pasoPromedio Puntos
int[] dias = new int[0]; // Guardamos que dia de la semana era en esos pasoPromedio Puntos
int[][] sumasPorHora = new int[7][24]; // Sumas totales para calcular los promedios para cada dia y para cada hora
int[][] nPorHora = new int[7][24]; // Cantidad de datos para cada dia y para cada hora
int hora; 

void setup() {
  size(1280, 720);  // Resolución del sketch
  stroke(255);     // Ponemos color de linea a blanco
  background(0); // Fondo negro
  colorMode(HSB); // espacio de colores
  textSize(32);   // Tamaño de texto
  tabla = loadTable("Dump Count.it . 21-5 al 31-7.csv");  // Cargamos los datos. Tienen 3 columnas: 0- Fecha  /  1- Cantidad de Autos / 2- Dia de la semana

  ///////// PROCESIAMIENTO DE LOS DATOS ////////////////////
  for (int i = 0 ; i < tabla.getRowCount()/pasoPromedio - 1; i++) {  // Calculamos los promedios cada pasoPromedio datos y tambien por dia y hora
     int tempPromedio = 0;
     for (int j = 0; j < pasoPromedio ; j++) {  // Promediamos cada *pasoPromedio* datos
       int indice = i*pasoPromedio + j;
       tempPromedio = tempPromedio + tabla.getInt(indice,1);
       
       // Aprovechamos y los vamos separando por hora y por dia de la semana
       String fecha = tabla.getString(i*pasoPromedio +j,0);
       if (fecha.substring(11,12).equals(":")){  // Chequeamos porque algunas horas tienen 1 digito y otras 2 digitos
         hora = int(fecha.substring(10,11));
       }else{
         hora = int(fecha.substring(10,12));
       }
       sumasPorHora[tabla.getInt(i*pasoPromedio +j,2) - 1][hora] = sumasPorHora[tabla.getInt(i*pasoPromedio +j,2) - 1][hora] + tabla.getInt(i*pasoPromedio +j,1);
       nPorHora[tabla.getInt(i*pasoPromedio +j,2) - 1][hora] = nPorHora[tabla.getInt(i*pasoPromedio +j,2) - 1][hora] + 1;
     }
     
     tempPromedio = tempPromedio / pasoPromedio;
     promedios = append(promedios,tempPromedio);  // Lo agregamos al Array que contiene los promedios
     dias = append(dias,tabla.getInt(i*pasoPromedio,2));
   }
////////////////////////////////////////////////////////////////

}

void draw(){   
 background(0); // Fondo Negro
 
 ////////////////////// PLOTEO ////////////////////////////////////
 int punto1, punto2;
 for (int i = 0 ; i < promedios.length - 1; i++) {  // Dibujamos la señal promediada
     punto1 = 720 - promedios[i]/escala - offset;
     punto2 = 720 - promedios[i+1]/escala - offset;
     stroke(pasoColor*dias[i],180,255); // Ponerle un color distinto segun el dia de la semana
     line(start + i, punto1, start + i + 1, punto2);
   }
  
  for (int i = 0; i<7; i++){     // Dibujamos los promedios por dia
    for (int j = 0;  j < 23; j++){
      punto1 = 720 - sumasPorHora[i][j] / nPorHora[i][j] / escala - 10; 
      punto2 = 720 - sumasPorHora[i][j + 1] / nPorHora[i][j + 1] / escala - 10; 
      stroke(pasoColor*(i+1), 180, 255);
      line(180 *i +  7*j, punto1, 180*i + (j + 1) * 7, punto2);
    }
  } 
   
   
  //////////   LEYENDAS Y TEXTOS  /////////////////
  textSize(32); 
  fill(pasoColor*1, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Domingo", 20, 700); 
  fill(pasoColor*2, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Lunes", 220, 700); 
  fill(pasoColor*3, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Martes", 390, 700); 
  fill(pasoColor*4, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Miercoles", 550, 700); 
  fill(pasoColor*5, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Jueves", 760, 700); 
  fill(pasoColor*6, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Viernes", 930, 700); 
  fill(pasoColor*7, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Sabado", 1100, 700);
  
  if (mouseY < 380 & mouseY > 50){ // Mostrar la fecha del dato al mover el mouse
    int indiceX = (mouseX - start)*pasoPromedio;
    if (indiceX > 0 & indiceX < tabla.getRowCount()){
      fill(255);
      textSize(18); 
      text(tabla.getString(indiceX,0), mouseX + 10, 30); // La columna 0 tiene la fecha
      stroke(255);
      line(mouseX,0,mouseX,380);
    }
  }
  
  if (mouseY < 700 & mouseY > 400){ // Mostrar la hora de los promedios
    int indiceX = min(mouseX % 180, 168) / 7;
    fill(255);
    textSize(18); 
    if (mouseX < 70){
     text(str(indiceX) + ":00", mouseX + 10, 420); // La columna 0 tiene la fecha
    }else{
     text(str(indiceX) + ":00", mouseX - 60, 420); // La columna 0 tiene la fecha  
    }
    stroke(255);
    line(mouseX,400,mouseX,670);
   
  }
//////////////////////////////////////////

}