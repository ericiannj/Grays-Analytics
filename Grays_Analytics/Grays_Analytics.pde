int [] grafico = new int[256];
int [] graficoEq = new int [256];

int pixelColor, pixelColorEq;
float tonalidade, tonalidadeEq;
float c;

PImage polen;
PImage imagemResultado = createImage(241,232, RGB);

void setup(){
  size(600, 700);
  background(255);
  polen = loadImage("./data/polen.png");
  
  renderElementosIniciais();
  calcTonalidadeOriginal();
  renderGrafico();
  
  renderImagemEq(polen);
  calcTonalidadeEq();
  renderGraficoEq();
}

void renderElementosIniciais() {
  textSize(25);
  fill(0);
  text("Imagem Original", 200, 50);
  image(polen, 0, 90);
  text("Imagem com Histograma Equalizado", 70, 370);
  strokeWeight(4);
  line(300,90,300,320);
  line(300,320,570,320);
  line (300, 420 ,300, 650);
  line (300, 650, 570, 650);
}

void calcTonalidadeOriginal() {
  for(int w=0; w<241; w++) {
    for(int h=0; h<232; h++) {
      pixelColor = polen.get(w, h);
      tonalidade = red(pixelColor);
      grafico[(int)tonalidade]++;
    }
  }
}

void renderGrafico() {
  for(int i = 0; i < grafico.length; i++) {
   stroke(0);
   strokeWeight(1);
   line(i + 301, 400 - 80, i + 301, 400-(grafico[i]*0.03) - 80);
  }
}

void renderImagemEq(PImage polen) {
  color corEq;
  int somaI;
  float tonalidadeCinza;
  
  for(int w=0; w<241; w++) {
    for(int h=0; h<232; h++) {
      
      corEq = polen.get(w,h);
      tonalidadeCinza = red(corEq);
      somaI = 0;
      c = 255/((float)241 * 232);
      
      for (int s = 0; s < tonalidadeCinza; s++) {
       somaI += grafico[s];
      }
      
      corEq = color(c * somaI);
      imagemResultado.set(w, h, corEq);
    }
  }
  
  image(imagemResultado, 0, 420);
}

void calcTonalidadeEq() {
  for(int w=0; w<241; w++) {
    for(int h=0; h<232; h++) {
      pixelColorEq = imagemResultado.get(w, h);
      tonalidadeEq = red(pixelColorEq);
      graficoEq[(int)tonalidadeEq]++;
    }
  }
} 

void renderGraficoEq() {
  for(int p = 0; p < graficoEq.length; p++) {
   stroke(0);
   strokeWeight(1);
   line(p + 301, 400 + 250, p + 301, 400-(graficoEq[p]*0.03) + 250);
  }
}
