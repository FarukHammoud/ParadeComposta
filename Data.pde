Data data = new Data();

class Data {

  String materiais_lines[];
  String materiais_string;
  String new_materiais_lines[];
  String conveccoes_lines[];
  String conveccoes_string;
  String new_conveccoes_lines[];
  //materiais : file
  String materiais[][];
  String condutividades[][];
  String coresR[][];
  String coresG[][];
  String coresB[][];
  //convecções :file
  String tipos_conveccoes[][];
  String filmes_conveccoes[][];

  //para tmp
  int cte=10;
  String[] dados = new String[this.cte];
  int pontos=0;
  
  void ImprimaMateriais() {

    for (int i = 0; i < this.materiais_lines.length; i++) {

      println(this.materiais_lines[i]);
    }
    println("Testando: Materias set by text");
    print("1. ");
    println(this.materiais[0][0]);
    print("1. ");
    println(this.materiais[1][0]);
    print("1. ");
    println(this.materiais[2][0]);
    print("1. ");
    println(this.materiais[3][0]);
  }
  void ImprimaConveccoes() {

    for (int i = 0; i < this.conveccoes_lines.length; i++) {

      println(this.conveccoes_lines[i]);
    }
  }

  void getMateriais() {

    this.materiais_string = join(materiais_lines, " ");

    this.materiais = matchAll(this.materiais_string, "material = \"(.*?)\";");
    this.condutividades = matchAll(this.materiais_string, "condutividade = \"(.*?)\";");
    this.coresR = matchAll(this.materiais_string, "R = \"(.*?)\";");
    this.coresG = matchAll(this.materiais_string, "G = \"(.*?)\";");
    this.coresB = matchAll(this.materiais_string, "B = \"(.*?)\";");
  }
  void getConveccoes() {

    this.conveccoes_string = join(conveccoes_lines, " ");

    this.tipos_conveccoes = matchAll(this.conveccoes_string, "tipo = \"(.*?)\";");
    this.filmes_conveccoes = matchAll(this.conveccoes_string, "coeficiente de filme = \"(.*?)\";");
  }
  void getTmp() {
    
    int contagem =0;
    
    for (int a=0; a<this.pontos; a++) {
      try {
        this.dados[a] = entrada.readLine();
        println(this.dados[a]);
        contagem++;
      } 
      catch (IOException e) {
        e.printStackTrace();
        this.dados[a] = null;
      }
    }
    for (int a=0; a<contagem; a++) {
       grafic.taxas[a] = float(this.dados[a]);
    }
    
  }
  void ImprimeTmp() {
    
    this.pontos++;
    if (gerenciador.frame == 1) {
      saida.println(calculo.Taxa());
      saida.flush();
    } else if (gerenciador.frame == 2) {
      saida.println(calculo.TaxaCilindrica());
      saida.flush();
    }
  }


  //saveStrings("data.txt",this.new_data_lines); se precisar um dia
}