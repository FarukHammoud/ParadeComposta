PImage fundo;
PImage lacit;
PImage mais;
PImage ponto;
PImage config;
PImage grafico;
PImage voltar;
PrintWriter saida;
BufferedReader entrada;

void setup(){
  
   //fullScreen();
  
   data.materiais_lines = loadStrings("materiais.txt");
   data.conveccoes_lines = loadStrings("conveccoes.txt");
   size(1280,720);

   fundo = loadImage("fundo.jpg");
   lacit = loadImage("lacit.PNG");
   mais = loadImage("mais.png");
   ponto = loadImage("ponto.png");
   config = loadImage("config.png");
   grafico = loadImage("grafico.png");
   voltar = loadImage("voltar.png");
   
   data.getMateriais();
   data.getConveccoes();
   
   saida = createWriter("tmp_data.txt"); 
   entrada = createReader("tmp_data.txt");
    
}
void draw(){
  
   gerenciador.Atualizar();
   interfaceX.SearchKey();
   
}