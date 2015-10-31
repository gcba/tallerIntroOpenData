Table tabla;
int escala = 2;
int offset = 100;

void setup() {
  size(1280, 720);  // Resolución del sketch
  stroke(255);     // Ponemos color de linea a blanco
  background(0); // Fondo negro
  tabla = loadTable("Dump Count.it . 21-5 al 31-7.csv");  // Cargamos los datos
  
   for (int i = 0 ; i < tabla.getRowCount()/10; i++) {  // Dibujamos todos los datos que entren en la pantalla
     int promedio1 = 0;
     int promedio2 = 0;
     for (int j = 0; j < 5 ; j++) {  // Promediamos cada 10 datos
       promedio1 = promedio1 + tabla.getInt(i*10 + j,1);
       promedio2 = promedio2 + tabla.getInt((i+1)*10 + j,1);
     }
     promedio1 = promedio1 / 5;
     promedio2 = promedio2 / 5;
     int punto1 = 720 - promedio1/escala - offset;
     int punto2 = 720 - promedio2/escala - offset;
     line(i, punto1, i + 1, punto2);
   }
}