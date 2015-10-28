Table tabla;
int escala = 2;
int offset = 350;
int pasoColor = 35;
int pasoPromedio = 7;
int start = 50;
void setup() {
  size(1280, 720);  // Resolución del sketch
  stroke(255);     // Ponemos color de linea a blanco
  background(0); // Fondo negro
  colorMode(HSB); // espacio de colores
  textSize(32);   // Tamaño de texto
  tabla = loadTable("Dump Count.it . 21-5 al 31-7.csv");  // Cargamos los datos. Tienen 3 columnas: 0- Fecha  /  1- Cantidad de Autos / 2- Dia de la semana
  
  
     
}

void draw(){
 background(0);
 for (int i = 0 ; i < tabla.getRowCount()/pasoPromedio - 1; i++) {  // Dibujamos todos los datos que entren en la pantalla
     int promedio1 = 0;
     int promedio2 = 0;
     for (int j = 0; j < pasoPromedio ; j++) {  // Promediamos cada *pasoPromedio* datos
       promedio1 = promedio1 + tabla.getInt(i*pasoPromedio + j,1);
       promedio2 = promedio2 + tabla.getInt((i+1)*pasoPromedio + j,1);
     }
     promedio1 = promedio1 / pasoPromedio;
     promedio2 = promedio2 / pasoPromedio;
     int punto1 = 720 - promedio1/escala - offset;
     int punto2 = 720 - promedio2/escala - offset;
     stroke(pasoColor*tabla.getInt(i*pasoPromedio,2),200,255); // Ponerle un color distinto segun el dia de la semana
     
     line(start + i, punto1, start + i + 1, punto2);
   }
  textSize(32); 
  fill(pasoColor*1, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Domingo", 10, 400); 
  fill(pasoColor*2, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Lunes", 170, 400); 
  fill(pasoColor*3, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Martes", 280, 400); 
  fill(pasoColor*4, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Miercoles", 400, 400); 
  fill(pasoColor*5, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Jueves", 560, 400); 
  fill(pasoColor*6, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Viernes", 670, 400); 
  fill(pasoColor*7, 200, 255);  // Imprimir el codigo de color de los dias de la semana
  text("Sabado", 800, 400);
  
  if (mouseY < 380 & mouseY > 50){ // Mostrar la fecha del dato al mover el mouse
    int indiceX = (mouseX - start)*pasoPromedio;
    if (indiceX > 0 & indiceX < tabla.getRowCount()){
      fill(255);
      textSize(18); 
      text(tabla.getString(indiceX,0), mouseX, mouseY); // La columna 0 tiene la fecha
    }
  }

}