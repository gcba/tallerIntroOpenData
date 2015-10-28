Table tabla;
int escala = 2;
int start = 0;
int offset = 100;

void setup() {
  size(1280, 720);  // Resolución del sketch
  stroke(255);     // Ponemos color de linea a blanco
  background(0); // Fondo negro
  tabla = loadTable("Dump Count.it . 21-5 al 31-7.csv");  // Cargamos los datos
}

void draw() {
 background(0);   // Volvemos el fondo a negro
 start = start + 1;  // movemos el valor desde el que dibujamos los datos
 
 for (int i = start; i < start + 1280; i++) {  // Dibujamos todos los datos que entren en la pantalla
    int punto1 = 720 - tabla.getInt(i,1)/escala - offset;
    int punto2 = 720 - tabla.getInt(i+1,1)/escala - offset;
    line(i - start , punto1, i - start +1, punto2);
    }
    
}