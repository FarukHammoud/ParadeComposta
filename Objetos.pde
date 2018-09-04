class QuadroGrafico {

  int cte = 100;
  boolean on = false;
  String texto;
  float[] taxas = new float[this.cte];

  float maior=0;
  float menor=0;
  int pontos=0;

  float proporcao_x=0;
  float proporcao_y=0;

  Botao bot_fechar = new Botao("fechar", 950, 215, 21, 39);
  Botao bot_confirmar = new Botao("confirmar", 800, 210, 23, 39);


  QuadroGrafico(String novo_texto) {

    this.texto = novo_texto;
    for (int a=0; a<this.cte; a++) {
      this.taxas[a] = -1;
    }
  }
  int ContaPontos() {

    int total =0;
    for (int a=0; a<this.cte; a++) {
      if (this.taxas[a]!=-1) {
        total+=1;
      }
    } 
    return total;
  }
  float AchaMaior() {

    float Fmaior =0;
    for (int a=0; a<this.ContaPontos(); a++) {
      if (this.taxas[a]>Fmaior) {
        Fmaior=this.taxas[a];
      }
    } 
    return Fmaior;
  }
  float AchaMenor() {

    float Fmenor =9999999;
    for (int a=0; a<this.ContaPontos(); a++) {
      if (this.taxas[a]<Fmenor) {
        Fmenor=this.taxas[a];
      }
    } 
    return Fmenor;
  }
  void Show() {
    stroke(100, 0, 0);
    fill(50, 50, 50);
    strokeWeight(3);
    rect(250, 200, 750, 400, 40); 
    stroke(150, 150, 150);
    strokeWeight(1);
    line(250, 250, 1000, 250);
    fill(255, 255, 255);
    textSize(40);
    text(this.texto, 290, 240);
    textSize(20);

    stroke(100, 100, 100);
    fill(250, 250, 250);
    rect(260, 270, 730, 300);
    stroke(0, 0, 0);
    strokeWeight(3);
    line(270, 540, 900, 540);
    line(290, 560, 290, 290);
    strokeWeight(1);
    fill(0, 0, 0);
    triangle(285, 290, 295, 290, 290, 280);
    triangle(900, 535, 900, 545, 910, 540);

    this.pontos = this.ContaPontos();
    this.maior = this.AchaMaior();
    this.menor = this.AchaMenor();

    if (this.maior!=this.menor) {
      this.proporcao_x = 580/( this.pontos-1 );
      this.proporcao_y = 230/( this.maior - this.menor);

      stroke(255, 0, 0);
      for (int a=0; a<this.ContaPontos()-1; a++) {

        line(300+a*this.proporcao_x, 530-((this.taxas[a]-this.menor)*this.proporcao_y), 300+(a+1)*this.proporcao_x, 530-((this.taxas[a+1]-this.menor)*this.proporcao_y));
        strokeWeight(2);
        point(300+a*this.proporcao_x, 530-((this.taxas[a]-this.menor)*this.proporcao_y));
        textSize(10);
        text(a, 300+a*this.proporcao_x, 555);
        text(int(this.taxas[a]), 270, 530-((this.taxas[a]-this.menor)*this.proporcao_y));
        text(int(this.taxas[a+1]), 270, 530-((this.taxas[a+1]-this.menor)*this.proporcao_y));
        text((a+1), 300+(a+1)*this.proporcao_x, 555);
        point(300+(a+1)*this.proporcao_x, 530-((this.taxas[a+1]-this.menor)*this.proporcao_y));
        strokeWeight(1);
      }
    }
    bot_fechar.Show();
    bot_confirmar.Show();
  }
}
class Paredes {

  int cte = 100;
  boolean[] existe = new boolean[this.cte];
  String[] material = new String[this.cte];
  float[] condutividade = new float[this.cte];
  float[] espessura = new float[this.cte];
  int parede_atual = 0;

  boolean mouse_em_cima = false;
  boolean pressionado = false;
  boolean pressionado_direito = false;

  int link_tarefa_a = 11;
  int link_tarefa_b = 12;
  int link_tarefa_c = 27;

  String linha_1;
  String linha_2;
  String linha_3;

  Paredes() {

    for (int i=0; i<this.cte; i++) {
      existe[i] = false;
    }
  }
  void Limpar() {
    for (int a = 0; a<this.cte; a++) {
      this.existe[a]=false;
      this.material[a]="";
      this.condutividade[a]=0;
      this.espessura[a]=0;
    }
  }
  int ContaExistentes() {
    int a =0;
    for (int i=0; i<this.cte; i++) {

      if (existe[i] == true) {
        a++;
      }
    }
    return a;
  }
  float SomaEspessuras() {
    float a =0;
    for (int i=0; i<this.ContaExistentes(); i++) {

      a += espessura[i];
    }
    if (a == 0) {
      a=0.1;
    }
    return a;
  }

  void AdicionaParede(String novo_material, float novo_condutividade, float novo_espessura) {
    if (novo_espessura>0) {
      int numero_parede = this.ContaExistentes();
      println(numero_parede);

      this.existe[numero_parede] = true;
      this.material[numero_parede] = novo_material;
      this.condutividade[numero_parede] = novo_condutividade;
      this.espessura[numero_parede] = novo_espessura;
    } else {
    }
  }
  int Atual() {
    float espessura_total = this.SomaEspessuras(); 
    float razao_pe = 500/espessura_total;

    int espessura_somada=390;
    for (int i = 0; i<this.ContaExistentes(); i++) {

      if (mouseX>espessura_somada) {
        this.parede_atual = i;
      }
      espessura_somada += int(this.espessura[i]*razao_pe);
    }

    return this.parede_atual;
  }
  void Excluir(int parede) {
    if (parede<this.ContaExistentes()) {
      println("Deletando");
      for (int a = parede; a<this.ContaExistentes()-1; a++) {
        this.material[a] = this.material[a+1];
        this.condutividade[a] = this.condutividade[a+1];
        this.espessura[a] = this.espessura[a+1];
      }
      this.existe[this.ContaExistentes()-1] = false;
    }
    this.Show();
  }
  void Show() {

    int numero_paredes = this.ContaExistentes();
    float espessura_total = this.SomaEspessuras();       

    float razao_pe = 500/espessura_total;
    float pixels_acumulados=0;

    int espessura_somada=390;
    fill(100, 100, 100);
    stroke(100, 100, 100);
    //rect(390, 211, 500, 338);
    fill(255, 255, 255);
    stroke(0, 0, 0);
    for (int i = 0; i < this.cte; i++) {
      if (numero_paredes > i) {
        for (int e = 0; e<data.materiais.length; e++) {
          if (this.material[i].equals(data.materiais[e][1])) {
            fill(int(data.coresR[e][1]), int(data.coresG[e][1]), int(data.coresB[e][1]));
          }
        }

        rect(390+pixels_acumulados, 210, int(espessura[i]*razao_pe), 340);

        if (numero_paredes == i+1) {
          rect(390+pixels_acumulados, 210, 890 - (390+pixels_acumulados), 340);
        }
        pixels_acumulados += int(espessura[i]*razao_pe);
      }
    }
    if (mouseX > 390 && mouseY > 210 && mouseX < 890 && mouseY < 550) {
      this.mouse_em_cima = true;
    } else {
      this.mouse_em_cima = false;
    }
    if (mouse_em_cima && mousePressed && mouseButton == RIGHT ) {

      this.pressionado_direito = true;
    } else if (this.pressionado_direito) {
      gerenciador.Tarefa(this.link_tarefa_b);
      this.pressionado_direito = false;
    } 
    if (mouse_em_cima && mousePressed && mouseButton == LEFT ) {

      this.pressionado = true;
    } else if (this.pressionado) {
      gerenciador.Tarefa(this.link_tarefa_c);
      this.pressionado = false;
    } 
    if (this.mouse_em_cima) {

      this.Atual();

      this.linha_1 = "Material: ";
      this.linha_1 += this.material[this.parede_atual];
      this.linha_1 += " .";
      this.linha_2 = "Condutividade: ";
      this.linha_2 += this.condutividade[this.parede_atual];
      this.linha_2 += " W/m.k .";
      this.linha_3 = "Espessura: ";
      this.linha_3 += this.espessura[this.parede_atual];
      this.linha_3 += " mm .";

      gerenciador.Tarefa(this.link_tarefa_a);
    }
  }


  //continuar
}

class Mostrador {

  String linha_1 = "Taxa: 0000,00 W";
  String linha_2 = "Fluxo: 0000,00 W/M2";
  String linha_3 = "CopyRight UTFPR - CT / LACIT - 2015 ";

  void Show() {

    fill(150, 0, 0);
    textSize(20);
    if (gerenciador.frame==1) {
      if (configuracoes.area_parede != -1) {
        this.linha_1 = "Taxa: ";
        this.linha_1 += calculo.Taxa();
        this.linha_1 += " W";
        println(configuracoes.area_parede);
      } else {
        this.linha_1 = "Taxa: [\"INF_FALTANDO:ÁREA_PAREDE\"]";
      }
      text(this.linha_1, 65, 635);
      this.linha_2 = "Fluxo: ";
      this.linha_2 += calculo.Fluxo();
      this.linha_2 += " W/m2";
      text(this.linha_2, 65, 665);
      text(this.linha_3, 65, 695);
    } else if (gerenciador.frame == 2) {
      if (configuracoes_cilindricas.comprimento_parede != -1) {
        this.linha_1 = "Taxa: ";
        this.linha_1 += calculo.TaxaCilindrica();
        this.linha_1 += " W";
      } else {
        this.linha_1 = "Taxa: [\"INF_FALTANDO:COMPRIMENTO_TUBO\"]";
      }
      text(this.linha_1, 65, 635);
      if (configuracoes_cilindricas.raio_interno != -1) {
        this.linha_2 = "Fluxo: ";
        this.linha_2 += calculo.FluxoCilindrico();
        println(calculo.FluxoCilindrico());
        this.linha_2 += " W/m2";
        text(this.linha_2, 65, 665);
        text(this.linha_3, 65, 695);
      } else {
        this.linha_2 = "Fluxo: [\"INF_FALTANDO:RAIO_INTERNO\"]";
      }
      text(this.linha_2, 65, 665);
      text(this.linha_3, 65, 695);
    }
  }
}
class MostradorNumero {

  TextBox editor = new TextBox(0, 0, "Insira a temp.");
  float numero = 25;
  int x;
  int y;
  int link_tarefa_a;
  int link_tarefa_b;


  boolean mouse_em_cima = false;
  boolean pressionado = false;
  boolean manipula_com_scroll = false;

  boolean show_editor = false;

  boolean selecionado = false;
  int x_ligacao=0;
  int y_ligacao=0;

  MostradorNumero(int new_x, int new_y, int novo_link_tarefa_a, int novo_link_tarefa_b) {

    this.x = new_x;
    this.y = new_y;
    this.link_tarefa_a = novo_link_tarefa_a;
    this.link_tarefa_b = novo_link_tarefa_b;
  }

  void Limpar() {
    this.numero = 25;
    this.show_editor=false;
    this.pressionado = false;
    this.manipula_com_scroll = false;
  }
  void Show() {

    fill(200, 200, 200);
    rect(this.x+85, this.y-10, 10, 10);
    ellipse(this.x+90, this.y-10, 10, 10);
    fill(250, 0, 0);
    stroke(250, 0, 0);
    strokeWeight(8);
    point(this.x+90, this.y-10);
    if (x_ligacao!=0) {
      strokeWeight(8);
      point(this.x_ligacao, this.y_ligacao-10);
      strokeWeight(1);
      line(this.x_ligacao, this.y_ligacao-10, this.x+90, this.y-10);
    }
    strokeWeight(1);
    stroke(0, 0, 0);
    fill(50, 50, 50);
    rect(this.x, this.y, 100, 50);

    fill(50, 0, 0);
    if (this.selecionado) {
      fill(0, 50, 0);
    }
    rect(this.x+5, this.y+5, 90, 40);

    fill(150, 0, 0);
    if (this.selecionado) {
      fill(0, 150, 0);
    }
    textSize(20);
    text(int(this.numero), this.x+15, this.y+35);

    if (mouseX > this.x && mouseY > this.y && mouseX < this.x+100 && mouseY < this.y+50) {
      this.mouse_em_cima = true;
      gerenciador.Tarefa(this.link_tarefa_a);
      this.manipula_com_scroll=true;
      this.selecionado = true;
    } else if (this.mouse_em_cima) {
      this.selecionado = false;
      this.mouse_em_cima = false;
      interfaceX.scroll = 0;
      this.manipula_com_scroll=false;
      this.numero = int(this.numero);
    }
    if (mouse_em_cima && mousePressed ) {
      this.pressionado = true;
    } else if (this.pressionado) {
      gerenciador.Tarefa(this.link_tarefa_b);
      this.pressionado = false;
    } 
    if (this.manipula_com_scroll) {
      this.numero -= interfaceX.scroll/10;
      if (interfaceX.scroll==0) {
        this.numero = int(this.numero);
      }
    }
    if (this.show_editor) {
      this.selecionado = true;

      if (this.x<600) {
        editor.MudaXY(this.x+110, this.y+15);
      } else {
        editor.MudaXY(this.x-160, this.y+15);
      }
      editor.Show();
    }
  }
  void MudaNumero(int novo_numero) {

    this.numero = novo_numero;
  }
  float RetornaNumero() {

    return this.numero;
  }
}
class Conveccoes {

  String linha_1 = "";
  String linha_2 = "";

  void Show() {

    if (paredes.ContaExistentes()!=0) {

      for (int a =0; a<25; a++) {

        if (T1.numero==T2.numero) {
          stroke(250-a*4, 100, 100);
          line(389-a, 210, 389-a, 550);

          stroke(250-a*4, 100, 100);
          line(891+a, 210, 891+a, 550);
        } else if (T1.numero>=T2.numero) {
          stroke(250-a*4, 100, 100);
          line(389-a, 210, 389-a, 550);

          stroke(100, 100, 250-a*4);
          line(891+a, 210, 891+a, 550);
        } else {
          stroke(100, 100, 250-a*4);
          line(389-a, 210, 389-a, 550);

          stroke(250-a*4, 100, 100);
          line(891+a, 210, 891+a, 550);
        }
      }
      if (mouseY>220&&mouseY<550) {
        if (mouseX>365&&mouseX<390) {
          this.linha_1 = data.tipos_conveccoes[configuracoes.ambiente_1][1];
          this.linha_1 += " :";
          this.linha_2 = "Coeficiente de filme: ";
          this.linha_2 += data.filmes_conveccoes[configuracoes.ambiente_1][1];
          this.linha_2 += " W/m2.k .";

          text(this.linha_1, mouseX-250, mouseY-20);
          text(this.linha_2, mouseX-250, mouseY);
        } else if (mouseX>890&&mouseX<915) {

          this.linha_1 = data.tipos_conveccoes[configuracoes.ambiente_2][1];
          this.linha_1 += " :";
          this.linha_2 = "Coeficiente de filme: ";
          this.linha_2 += data.filmes_conveccoes[configuracoes.ambiente_2][1];
          this.linha_2 += " W/m2.k";

          text(this.linha_1, mouseX+5, mouseY-20);
          text(this.linha_2, mouseX+5, mouseY);
        }
      }
    }
  }
}


class Botao {

  String tipo;
  int x;
  int y;
  String texto=" ";

  int link_tarefa_a;
  int link_tarefa_b;

  int numero_de_letras;
  boolean mouse_em_cima = false;
  boolean clicado = false;
  boolean pressionado = false;

  Botao(String novo_tipo, int novo_x, int novo_y, String novo_texto, int novo_link_tarefa_b) {
    this.tipo = novo_tipo;
    this.x = novo_x;
    this.y = novo_y;
    this.texto = novo_texto;
    this.link_tarefa_b = novo_link_tarefa_b;
  }
  Botao(String novo_tipo, int new_x, int new_y, int novo_link_tarefa_a, int novo_link_tarefa_b) {
    this.tipo = novo_tipo;
    this.x = new_x;
    this.y = new_y;
    this.link_tarefa_a = novo_link_tarefa_a;
    this.link_tarefa_b = novo_link_tarefa_b;
  }
  void MudaXY(int novo_X, int novo_Y) {

    this.x = novo_X;
    this.y = novo_Y;
  }
  void Show() {



    if (this.tipo == "inicial") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+400 && mouseY < this.y+200) {
        this.mouse_em_cima = true;
      } else {
        this.mouse_em_cima = false;
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } else {
        this.pressionado = false;
      }
      if (this.mouse_em_cima) {
        fill(25, 125, 255);
      } else {
        fill(0, 75, 225);
      }
      stroke(255, 255, 255);
      rect(this.x, this.y, 400, 200, 10); 

      fill(255, 255, 255);

      this.numero_de_letras = this.texto.length();
      textSize(600/this.numero_de_letras);
      text(this.texto, this.x+50, this.y+(50/this.numero_de_letras)+120);
    }
    if (this.tipo == "normal_1") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+60 && mouseY < this.y+60) {
        this.mouse_em_cima = true;
      } else {
        this.mouse_em_cima = false;
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);
      fill(50, 50, 50);
      rect(this.x, this.y, 60, 60, 10);
    }
    if (this.tipo == "fechar") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+30 && mouseY < this.y+20) {
        this.mouse_em_cima = true;
        fill(255, 0, 0);
      } else {
        this.mouse_em_cima = false;
        fill(100, 0, 0);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);

      rect(this.x, this.y, 30, 20, 5);
      fill(255, 255, 255);
      textSize(15);
      text("X", this.x+10, this.y+15);
    }
    if (this.tipo == "confirmar") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+120 && mouseY < this.y+30) {
        this.mouse_em_cima = true;
        fill(0, 255, 0);
      } else {
        this.mouse_em_cima = false;
        fill(0, 100, 0);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);

      rect(this.x, this.y, 120, 30, 5);
      fill(255, 255, 255);
      textSize(20);
      text("Confirmar", this.x+10, this.y+25);
    }
    if (this.tipo == "editar") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+80 && mouseY < this.y+30) {
        this.mouse_em_cima = true;
        fill(0, 255, 0);
      } else {
        this.mouse_em_cima = false;
        fill(0, 100, 0);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);

      rect(this.x, this.y, 80, 30, 5);
      fill(255, 255, 255);
      textSize(20);
      text("Editar", this.x+10, this.y+25);
    }
    if (this.tipo == "excluir") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+80 && mouseY < this.y+30) {
        this.mouse_em_cima = true;
        fill(255, 0, 0);
      } else {
        this.mouse_em_cima = false;
        fill(100, 0, 0);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);

      rect(this.x, this.y, 80, 30, 5);
      fill(255, 255, 255);
      textSize(20);
      text("Excluir", this.x+10, this.y+25);
    }
  }
}
class CheckBox {

  int x;
  int y;
  boolean valor=false;
  String texto = "Null";

  boolean mouse_em_cima=false;
  boolean pressionado=false;


  CheckBox(int novo_x, int novo_y, String novo_texto) {
    this.x = novo_x;
    this.y = novo_y;
    this.texto = novo_texto;
  }
  CheckBox(int novo_x, int novo_y, String novo_texto, boolean novo_valor) {
    this.x = novo_x;
    this.y = novo_y;
    this.texto = novo_texto;
    this.valor = novo_valor;
  }
  void MudaTexto(String novo_texto) {
    this.texto = novo_texto;
  }
  void Show() {
    fill(255, 255, 255);
    stroke(200, 200, 200);
    rect(this.x, this.y, 10, 10);
    textSize(10);
    text(this.texto, this.x+20, this.y+10);
    if (this.valor==true) {
      fill(0, 255, 0); 
      ellipse(this.x+5, this.y+5, 4, 4);
    }
    if (mouseX > this.x && mouseY > this.y && mouseX < this.x+10 && mouseY < this.y+10) {
      this.mouse_em_cima = true;
    } else {
      this.mouse_em_cima = false;
    }
    if (mouse_em_cima && mousePressed ) {
      this.pressionado = true;
    } else if (this.pressionado) {
      if (this.valor==true) {
        this.valor = false;
      } else {
        this.valor = true;
      }
      this.pressionado = false;
    } 
    if (this.mouse_em_cima) {
      fill(0, 100, 0); 
      ellipse(this.x+5, this.y+5, 4, 4);
    }
  }
}
class TextBox {

  int x;
  int y;
  String texto = "...";
  String tipo;

  boolean habilitado=false;
  boolean mouse_em_cima=false;
  boolean pressionado=false;

  void Limpar() {

    this.texto = "...";
  }
  TextBox(int novo_x, int novo_y, String novo_tipo) {
    this.x = novo_x;
    this.y = novo_y;
    this.tipo = novo_tipo;
  }

  void MudaTexto(String novo_texto) {

    this.texto = novo_texto;
  }
  void MudaXY(int novo_X, int novo_Y) {

    this.x = novo_X;
    this.y = novo_Y;
  }
  void Show() {
    fill(255, 255, 255);
    stroke(200, 200, 200);
    rect(this.x, this.y, 150, 20);
    textSize(14);
    fill(0, 0, 0);
    text(this.texto, this.x+10, this.y+17);
    if (mouseX > this.x && mouseY > this.y && mouseX < this.x+150 && mouseY < this.y+20) {
      this.mouse_em_cima = true;
    } else {
      this.mouse_em_cima = false;
      this.habilitado = false;
    }
    if (mouse_em_cima && mousePressed ) {
      this.pressionado = true;
    } else if (this.pressionado) {
      this.pressionado = false;

      this.habilitado = true;

      this.texto = "";
      interfaceX.DeletaString();
    } 
    if (this.mouse_em_cima) {
      fill(255, 255, 255);
      stroke(0, 200, 0);
      rect(this.x, this.y, 150, 20);
      textSize(14);
      fill(0, 0, 0);
      if (this.habilitado) {
        this.texto = interfaceX.atual_string;
      }
      text(this.texto, this.x+10, this.y+17);
    }
  }
}
class QuadroAddParede {

  boolean on = false;
  String tipo;
  String texto;

  float condutividade;
  float espessura;
  String material;

  Botao bot_fechar = new Botao("fechar", 950, 215, 17, 18);
  Botao bot_confirmar = new Botao("confirmar", 800, 210, 19, 20);

  CheckBox check_mat_1 = new CheckBox(300, 310, "Null");
  CheckBox check_mat_2 = new CheckBox(300, 330, "Null");
  CheckBox check_mat_3 = new CheckBox(300, 350, "Null");
  CheckBox check_mat_4 = new CheckBox(300, 370, "Null");
  CheckBox check_mat_5 = new CheckBox(300, 390, "Null");
  CheckBox check_mat_6 = new CheckBox(300, 410, "Null");
  CheckBox check_mat_7 = new CheckBox(300, 430, "Null");
  CheckBox check_mat_8 = new CheckBox(300, 450, "Null");
  CheckBox check_mat_9 = new CheckBox(300, 470, "Null");
  CheckBox check_mat_10 = new CheckBox(300, 490, "Null");

  TextBox text_mat = new TextBox(300, 470, "Null");
  TextBox text_esp = new TextBox(300, 470, "Null");
  TextBox text_con = new TextBox(300, 470, "Null");



  QuadroAddParede(String novo_tipo, String novo_texto) {

    this.tipo = novo_tipo;
    this.texto = novo_texto;
  }
  void Compila() {

    //fazer verificação

    this.condutividade = float(text_con.texto);
    this.material = text_mat.texto;
    this.espessura = float(text_esp.texto);

    if (data.materiais.length>0) {
      if (check_mat_1.valor) { 
        this.condutividade = float(data.condutividades[0][1]);
        this.material = data.materiais[0][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>1) {
      if (check_mat_2.valor) { 
        this.condutividade = float(data.condutividades[1][1]);
        this.material = data.materiais[1][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>2) {
      if (check_mat_3.valor) { 
        this.condutividade = float(data.condutividades[2][1]);
        this.material = data.materiais[2][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>3) {
      if (check_mat_4.valor) { 
        this.condutividade = float(data.condutividades[3][1]);
        this.material = data.materiais[3][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>4) {
      if (check_mat_5.valor) { 
        this.condutividade = float(data.condutividades[4][1]);
        this.material = data.materiais[4][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>5) {
      if (check_mat_6.valor) { 
        this.condutividade = float(data.condutividades[5][1]);
        this.material = data.materiais[5][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>6) {
      if (check_mat_7.valor) { 
        this.condutividade = float(data.condutividades[6][1]);
        this.material = data.materiais[6][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>7) {
      if (check_mat_8.valor) { 
        this.condutividade = float(data.condutividades[7][1]);
        this.material = data.materiais[7][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>8) {
      if (check_mat_9.valor) { 
        this.condutividade = float(data.condutividades[8][1]);
        this.material = data.materiais[8][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
    if (data.materiais.length>9) {
      if (check_mat_10.valor) { 
        this.condutividade = float(data.condutividades[9][1]);
        this.material = data.materiais[9][1];
        paredes.AdicionaParede(this.material, this.condutividade, this.espessura);
        paredes_cilindricas.AdicionaParede(this.material, this.condutividade, this.espessura);
      }
    }
  }
  void Show() {

    stroke(100, 0, 0);
    fill(50, 50, 50);
    strokeWeight(3);
    rect(250, 200, 750, 400, 40); 
    stroke(150, 150, 150);
    strokeWeight(1);
    line(250, 250, 1000, 250);
    fill(255, 255, 255);
    textSize(40);
    text(this.texto, 290, 240);
    textSize(20);



    if (this.tipo == "AddParede") {

      textSize(20);
      text("Selecione o material da parede:", 300, 300);

      if (data.materiais.length>0) {
        check_mat_1.MudaTexto(data.materiais[0][1]);
        check_mat_1.Show();
      }
      if (data.materiais.length>1) {
        check_mat_2.MudaTexto(data.materiais[1][1]);
        check_mat_2.Show();
      }
      if (data.materiais.length>2) {
        check_mat_3.MudaTexto(data.materiais[2][1]);
        check_mat_3.Show();
      }
      if (data.materiais.length>3) {
        check_mat_4.MudaTexto(data.materiais[3][1]);
        check_mat_4.Show();
      }
      if (data.materiais.length>4) {
        check_mat_5.MudaTexto(data.materiais[4][1]);
        check_mat_5.Show();
      }
      if (data.materiais.length>5) {
        check_mat_6.MudaTexto(data.materiais[5][1]);
        check_mat_6.Show();
      }
      if (data.materiais.length>6) {
        check_mat_7.MudaTexto(data.materiais[6][1]);
        check_mat_7.Show();
      }
      if (data.materiais.length>7) {
        check_mat_8.MudaTexto(data.materiais[7][1]);
        check_mat_8.Show();
      }
      if (data.materiais.length>8) {
        check_mat_9.MudaTexto(data.materiais[8][1]);
        check_mat_9.Show();
      }
      if (data.materiais.length>9) {
        check_mat_10.MudaTexto(data.materiais[9][1]);
        check_mat_10.Show();
      }
      fill(255, 255, 255);
      text("Outro: ", 300, data.materiais.length*20+320);
      textSize(20);
      text_mat.MudaXY(350, data.materiais.length*20+305);
      text("Insira a espessura da parede (mm):", 300, data.materiais.length*20+350);
      text_esp.MudaXY(300, data.materiais.length*20+360);
      text("Condutividade (deixar em branco para usar a padrão) :", 300, data.materiais.length*20+400);
      text_con.MudaXY(300, data.materiais.length*20+410);
      bot_fechar.Show();
      bot_confirmar.Show();
      text_mat.Show();
      text_esp.Show();
      text_con.Show();
    }
  }
}
class QuadroConfiguracoes {

  boolean on = false;
  String tipo;
  String texto;


  float coeficiente_filme_1=0;
  float coeficiente_filme_2=0;

  int ambiente_1;
  int ambiente_2;

  float area_parede=0;


  Botao bot_fechar = new Botao("fechar", 950, 215, 21, 22);
  Botao bot_confirmar = new Botao("confirmar", 800, 210, 23, 24);

  CheckBox check_temp_1 = new CheckBox(300, 290, "Ativar Temperatura 1 na Superfície");
  CheckBox check_temp_2 = new CheckBox(300, 310, "Ativar Temperatura 2 na Superfície");

  CheckBox check_conv1_1 = new CheckBox(300, 370, "Null");
  CheckBox check_conv1_2 = new CheckBox(300, 390, "Null");
  CheckBox check_conv1_3 = new CheckBox(300, 410, "Null");
  CheckBox check_conv1_4 = new CheckBox(300, 430, "Null");
  CheckBox check_conv1_5 = new CheckBox(300, 450, "Null");
  CheckBox check_conv1_6 = new CheckBox(300, 470, "Null");
  CheckBox check_conv1_7 = new CheckBox(300, 490, "Null");
  CheckBox check_conv1_8 = new CheckBox(300, 510, "Null");
  CheckBox check_conv1_9 = new CheckBox(300, 530, "Null");
  CheckBox check_conv1_10 = new CheckBox(300, 550, "Null");

  CheckBox check_conv2_1 = new CheckBox(700, 370, "Null");
  CheckBox check_conv2_2 = new CheckBox(700, 390, "Null");
  CheckBox check_conv2_3 = new CheckBox(700, 410, "Null");
  CheckBox check_conv2_4 = new CheckBox(700, 430, "Null");
  CheckBox check_conv2_5 = new CheckBox(700, 450, "Null");
  CheckBox check_conv2_6 = new CheckBox(700, 470, "Null");
  CheckBox check_conv2_7 = new CheckBox(700, 490, "Null");
  CheckBox check_conv2_8 = new CheckBox(700, 510, "Null");
  CheckBox check_conv2_9 = new CheckBox(700, 530, "Null");
  CheckBox check_conv2_10 = new CheckBox(700, 550, "Null");

  TextBox text_filme_1 = new TextBox(700, 550, "Null");
  TextBox text_filme_2 = new TextBox(700, 550, "Null");
  TextBox text_area = new TextBox(700, 550, "Null");




  QuadroConfiguracoes(String novo_tipo, String novo_texto) {

    this.tipo = novo_tipo;
    this.texto = novo_texto;

    //por padrão

    check_conv1_1.valor = true;
    check_conv2_1.valor = true;
  }
  void Compila() {
    this.coeficiente_filme_1 = float(text_filme_1.texto);
    this.coeficiente_filme_2 = float(text_filme_2.texto);
    if (float(text_area.texto)>=0&&float(text_area.texto)<=999999) {
      this.area_parede = float(text_area.texto);
    } else {
      this.area_parede = -1;
    }

    if (data.tipos_conveccoes.length>0) {
      if (check_conv1_1.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[0][1]);
        this.ambiente_1 = 0;
      }
      if (check_conv2_1.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[0][1]);
        this.ambiente_2 = 0;
      }
    }
    if (data.tipos_conveccoes.length>1) {
      if (check_conv1_2.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[1][1]);
        this.ambiente_1 = 1;
      }
      if (check_conv2_2.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[1][1]);
        this.ambiente_2 = 1;
      }
    }
    if (data.tipos_conveccoes.length>2) {
      if (check_conv1_3.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[2][1]);
        this.ambiente_1 = 2;
      }
      if (check_conv2_3.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[2][1]);
        this.ambiente_2 = 2;
      }
    }
    if (data.tipos_conveccoes.length>3) {
      if (check_conv1_4.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[3][1]);
        this.ambiente_1 = 3;
      }
      if (check_conv2_4.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[3][1]);
        this.ambiente_2 = 3;
      }
    }
    if (data.tipos_conveccoes.length>4) {
      if (check_conv1_5.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[4][1]);
        this.ambiente_1 = 4;
      }
      if (check_conv2_5.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[4][1]);
        this.ambiente_2 = 4;
      }
    }
    if (data.tipos_conveccoes.length>5) {
      if (check_conv1_6.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[5][1]);
        this.ambiente_1 = 5;
      }
      if (check_conv2_6.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[5][1]);
        this.ambiente_2 = 5;
      }
    }
    if (data.tipos_conveccoes.length>6) {
      if (check_conv1_7.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[6][1]);
        this.ambiente_1 = 6;
      }
      if (check_conv2_7.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[6][1]);
        this.ambiente_2 = 6;
      }
    }
    if (data.tipos_conveccoes.length>7) {
      if (check_conv1_8.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[7][1]);
        this.ambiente_1 = 7;
      }
      if (check_conv2_8.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[7][1]);
        this.ambiente_2 = 7;
      }
    }
    if (data.tipos_conveccoes.length>8) {
      if (check_conv1_9.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[8][1]);
        this.ambiente_1 = 8;
      }
      if (check_conv2_9.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[8][1]);
        this.ambiente_2 = 8;
      }
    }
    if (data.tipos_conveccoes.length>9) {
      if (check_conv1_10.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[9][1]);
        this.ambiente_1 = 9;
      }
      if (check_conv2_10.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[9][1]);
        this.ambiente_2 = 9;
      }
    }
  }
  void Show() {

    stroke(100, 0, 0);
    fill(50, 50, 50);
    strokeWeight(3);
    rect(250, 200, 750, 400, 40); 
    stroke(150, 150, 150);
    strokeWeight(1);
    line(250, 250, 1000, 250);
    fill(255, 255, 255);
    textSize(40);
    text(this.texto, 290, 240);
    textSize(20);



    if (this.tipo == "config") {

      textSize(20);
      text("Para desativar a resistência por convecção:", 300, 280);
      text("AMBIENTE 1", 380, 350);
      text("AMBIENTE 2", 740, 350);

      if (data.tipos_conveccoes.length>0) {
        check_conv1_1.MudaTexto(data.tipos_conveccoes[0][1]);
        check_conv1_1.Show();
        check_conv2_1.MudaTexto(data.tipos_conveccoes[0][1]);
        check_conv2_1.Show();
      }
      if (data.tipos_conveccoes.length>1) {
        check_conv1_2.MudaTexto(data.tipos_conveccoes[1][1]);
        check_conv1_2.Show();
        check_conv2_2.MudaTexto(data.tipos_conveccoes[1][1]);
        check_conv2_2.Show();
      }
      if (data.tipos_conveccoes.length>2) {
        check_conv1_3.MudaTexto(data.tipos_conveccoes[2][1]);
        check_conv1_3.Show();
        check_conv2_3.MudaTexto(data.tipos_conveccoes[2][1]);
        check_conv2_3.Show();
      }
      if (data.tipos_conveccoes.length>3) {
        check_conv1_4.MudaTexto(data.tipos_conveccoes[3][1]);
        check_conv1_4.Show();
        check_conv2_4.MudaTexto(data.tipos_conveccoes[3][1]);
        check_conv2_4.Show();
      }
      if (data.tipos_conveccoes.length>4) {
        check_conv1_5.MudaTexto(data.tipos_conveccoes[4][1]);
        check_conv1_5.Show();
        check_conv2_5.MudaTexto(data.tipos_conveccoes[4][1]);
        check_conv2_5.Show();
      }
      if (data.tipos_conveccoes.length>5) {
        check_conv1_6.MudaTexto(data.tipos_conveccoes[5][1]);
        check_conv1_6.Show();
        check_conv2_6.MudaTexto(data.tipos_conveccoes[5][1]);
        check_conv2_6.Show();
      }
      if (data.tipos_conveccoes.length>6) {
        check_conv1_7.MudaTexto(data.tipos_conveccoes[6][1]);
        check_conv1_7.Show();
        check_conv2_7.MudaTexto(data.tipos_conveccoes[6][1]);
        check_conv2_7.Show();
      }
      if (data.tipos_conveccoes.length>7) {
        check_conv1_8.MudaTexto(data.tipos_conveccoes[7][1]);
        check_conv1_8.Show();
        check_conv2_8.MudaTexto(data.tipos_conveccoes[7][1]);
        check_conv2_8.Show();
      }
      if (data.tipos_conveccoes.length>8) {
        check_conv1_9.MudaTexto(data.tipos_conveccoes[8][1]);
        check_conv1_9.Show();
        check_conv2_9.MudaTexto(data.tipos_conveccoes[8][1]);
        check_conv2_9.Show();
      }
      if (data.tipos_conveccoes.length>9) {
        check_conv1_10.MudaTexto(data.tipos_conveccoes[9][1]);
        check_conv1_10.Show();
        check_conv2_10.MudaTexto(data.tipos_conveccoes[9][1]);
        check_conv2_10.Show();
      }
      fill(255, 255, 255);
      text("Outro Coeficiente: ", 300, data.tipos_conveccoes.length*20+390);
      text("Outro Coeficiente: ", 700, data.tipos_conveccoes.length*20+390);
      textSize(20);
      text("Área da Superfície da Parede (em m2): ", 300, data.tipos_conveccoes.length*20+430);
      text_filme_1.MudaXY(400, data.tipos_conveccoes.length*20+375);
      text_filme_2.MudaXY(800, data.tipos_conveccoes.length*20+375);
      text_area.MudaXY(690, data.tipos_conveccoes.length*20+415);

      text_filme_1.Show();
      text_filme_2.Show();
      check_temp_1.Show();
      check_temp_2.Show();
      bot_fechar.Show();
      bot_confirmar.Show();
      text_area.Show();
    }
  }
}
class QuadroEditar {

  boolean on = false;
  int x;
  int y;
  int parede;

  Botao bot_editar = new Botao("editar", 0, 0, -1, 28);
  Botao bot_excluir = new Botao("excluir", 0, 0, -1, 29);

  void Show() {

    rect(this.x, this.y-40, 200, 40, 10);
    bot_editar.MudaXY(this.x+10, this.y-35);
    bot_excluir.MudaXY(this.x+110, this.y-35); 
    bot_editar.Show();
    bot_excluir.Show();
  }
}
class QuadroAlerta {

  boolean on = false;
  String texto = "";
  int link_tarefa=-1;
  Botao bot_confirmar = new Botao("confirmar", 0, 0, -1, link_tarefa);

  QuadroAlerta(String novo_texto, int novo_link_tarefa) {

    this.texto = novo_texto;
    this.link_tarefa = novo_link_tarefa;
    this.bot_confirmar.link_tarefa_b = this.link_tarefa;
  }
  void Show() {

    fill(50, 50, 50);
    stroke(255, 255, 255);
    rect(540, 320, 200, 80, 10);
    fill(255, 255, 255);
    textSize(20);
    text(this.texto, 550, 350);
    bot_confirmar.MudaXY(600, 360);
    bot_confirmar.Show();
  }
}


class ParedesCilindricas {

  int cte = 100;
  boolean[] existe = new boolean[this.cte];
  String[] material = new String[this.cte];
  float[] condutividade = new float[this.cte];
  float[] espessura = new float[this.cte];
  int parede_atual = 0;

  boolean mouse_em_cima = false;
  boolean pressionado = false;
  boolean pressionado_direito = false;

  int link_tarefa_a = 31;
  int link_tarefa_b = 23;
  int link_tarefa_c = 23;

  String linha_1;
  String linha_2;
  String linha_3;

  ParedesCilindricas() {

    for (int i=0; i<this.cte; i++) {
      existe[i] = false;
    }
  }
  void Limpar() {
    for (int a = 0; a<this.cte; a++) {
      this.existe[a]=false;
      this.material[a]="";
      this.condutividade[a]=0;
      this.espessura[a]=0;
    }
  }
  int ContaExistentes() {
    int a =0;
    for (int i=0; i<this.cte; i++) {

      if (existe[i] == true) {
        a++;
      }
    }
    return a;
  }
  float SomaEspessuras() {
    float a =0;
    for (int i=0; i<this.ContaExistentes(); i++) {

      a += espessura[i];
    }
    if (a == 0) {
      a=0.1;
    }
    return a;
  }

  void AdicionaParede(String novo_material, float novo_condutividade, float novo_espessura) {

    int numero_parede = this.ContaExistentes();
    println(numero_parede);

    this.existe[numero_parede] = true;
    this.material[numero_parede] = novo_material;
    this.condutividade[numero_parede] = novo_condutividade;
    this.espessura[numero_parede] = novo_espessura;
  }
  int Atual() {
    float espessura_total = this.SomaEspessuras(); 
    float razao_pe = 200/espessura_total;

    int espessura_somada=90;
    for (int i = this.ContaExistentes()-1; i>=0; i--) {

      if (calculo.DistanciaPP(640, 390, mouseX, mouseY)>espessura_somada) {
        this.parede_atual = i;
      }
      espessura_somada += int(this.espessura[i]*razao_pe/2);
    }

    return this.parede_atual;
  }
  void Excluir(int parede) {
    if (parede<this.ContaExistentes()) {
      println("Deletando");
      for (int a = parede; a<this.ContaExistentes()-1; a++) {
        this.material[a] = this.material[a+1];
        this.condutividade[a] = this.condutividade[a+1];
        this.espessura[a] = this.espessura[a+1];
      }
      this.existe[this.ContaExistentes()-1] = false;
    }
    this.Show();
  }
  void Show() {

    int numero_paredes = this.ContaExistentes();
    float espessura_total = this.SomaEspessuras();       

    float razao_pe = 200/espessura_total;
    float pixels_acumulados=0;

    stroke(0, 0, 0);
    fill(255, 255, 255);
    for (int i = 0; i < this.cte; i++) {
      if (numero_paredes > i) {
        for (int e = 0; e<data.materiais.length; e++) {
          if (this.material[i].equals(data.materiais[e][1])) {
            fill(int(data.coresR[e][1]), int(data.coresG[e][1]), int(data.coresB[e][1]));
          }
        }

        ellipse(640, 390, 380-pixels_acumulados, 380-pixels_acumulados);

        pixels_acumulados += int(espessura[i]*razao_pe);
      }
    }
    if (this.ContaExistentes()>0) {
      fill(100, 100, 100);
      stroke(0, 0, 0);
      ellipse(640, 390, 180, 180);
    }
    if (calculo.DistanciaPP(640, 390, mouseX, mouseY)<190&&calculo.DistanciaPP(640, 390, mouseX, mouseY)>90) {
      this.mouse_em_cima = true;
    } else {
      this.mouse_em_cima = false;
    }
    if (mouse_em_cima && mousePressed && mouseButton == RIGHT ) {

      this.pressionado_direito = true;
    } else if (this.pressionado_direito) {
      gerenciador.Tarefa(this.link_tarefa_b);
      this.pressionado_direito = false;
    } 
    if (mouse_em_cima && mousePressed && mouseButton == LEFT ) {

      this.pressionado = true;
    } else if (this.pressionado) {
      gerenciador.Tarefa(this.link_tarefa_c);
      this.pressionado = false;
    } 
    if (this.mouse_em_cima) {

      this.Atual();

      this.linha_1 = "Material: ";
      this.linha_1 += this.material[this.parede_atual];
      this.linha_1 += " .";
      this.linha_2 = "Condutividade: ";
      this.linha_2 += this.condutividade[this.parede_atual];
      this.linha_2 += " W/m.k .";
      this.linha_3 = "Espessura: ";
      this.linha_3 += this.espessura[this.parede_atual];
      this.linha_3 += " mm .";

      gerenciador.Tarefa(this.link_tarefa_a);
    }
  }


  //continuar
}
class ConveccoesCilindricas {

  String linha_1 = "";
  String linha_2 = "";

  void Show() {

    if (paredes.ContaExistentes()!=0) {
      noFill();
      for (int a =0; a<25; a++) {

        if (T3.numero==T4.numero) {
          stroke(250-a*4, 100, 100);
          ellipse(640, 390, 381+a, 381+a);
          ellipse(640, 390, 179-a, 179-a);
        } else if (T3.numero>T4.numero) {
          stroke(100, 100, 250-a*4);
          ellipse(640, 390, 381+a, 381+a);

          stroke(250-a*4, 100, 100);
          ellipse(640, 390, 179-a, 179-a);
        } else {
          stroke(100, 100, 250-a*4);
          ellipse(640, 390, 179-a, 179-a);

          stroke(250-a*4, 100, 100);
          ellipse(640, 390, 381+a, 381+a);
        }
      }
      if (mouseY>220&&mouseY<550) {
        if (mouseX>365&&mouseX<390) {
          this.linha_1 = data.tipos_conveccoes[configuracoes.ambiente_1][1];
          this.linha_1 += " :";
          this.linha_2 = "Coeficiente de filme: ";
          this.linha_2 += data.filmes_conveccoes[configuracoes.ambiente_1][1];
          this.linha_2 += " W/m2.k .";

          text(this.linha_1, mouseX-250, mouseY-20);
          text(this.linha_2, mouseX-250, mouseY);
        } else if (mouseX>890&&mouseX<915) {

          this.linha_1 = data.tipos_conveccoes[configuracoes.ambiente_2][1];
          this.linha_1 += " :";
          this.linha_2 = "Coeficiente de filme: ";
          this.linha_2 += data.filmes_conveccoes[configuracoes.ambiente_2][1];
          this.linha_2 += " W/m2.k";

          text(this.linha_1, mouseX+5, mouseY-20);
          text(this.linha_2, mouseX+5, mouseY);
        }
      }
    }
  }
}
class QuadroConfiguracoesCilindricas {

  boolean on = false;
  String tipo;
  String texto;


  float coeficiente_filme_1=0;
  float coeficiente_filme_2=0;

  int ambiente_1;
  int ambiente_2;

  float comprimento_parede=0;
  float raio_interno = 0;


  Botao bot_fechar = new Botao("fechar", 950, 215, 21, 36);
  Botao bot_confirmar = new Botao("confirmar", 800, 210, 23, 37);

  CheckBox check_temp_1 = new CheckBox(300, 290, "Ativar Temperatura 1 na Superfície");
  CheckBox check_temp_2 = new CheckBox(300, 310, "Ativar Temperatura 2 na Superfície");

  CheckBox check_conv1_1 = new CheckBox(300, 370, "Null");
  CheckBox check_conv1_2 = new CheckBox(300, 390, "Null");
  CheckBox check_conv1_3 = new CheckBox(300, 410, "Null");
  CheckBox check_conv1_4 = new CheckBox(300, 430, "Null");
  CheckBox check_conv1_5 = new CheckBox(300, 450, "Null");
  CheckBox check_conv1_6 = new CheckBox(300, 470, "Null");
  CheckBox check_conv1_7 = new CheckBox(300, 490, "Null");
  CheckBox check_conv1_8 = new CheckBox(300, 510, "Null");
  CheckBox check_conv1_9 = new CheckBox(300, 530, "Null");
  CheckBox check_conv1_10 = new CheckBox(300, 550, "Null");

  CheckBox check_conv2_1 = new CheckBox(700, 370, "Null");
  CheckBox check_conv2_2 = new CheckBox(700, 390, "Null");
  CheckBox check_conv2_3 = new CheckBox(700, 410, "Null");
  CheckBox check_conv2_4 = new CheckBox(700, 430, "Null");
  CheckBox check_conv2_5 = new CheckBox(700, 450, "Null");
  CheckBox check_conv2_6 = new CheckBox(700, 470, "Null");
  CheckBox check_conv2_7 = new CheckBox(700, 490, "Null");
  CheckBox check_conv2_8 = new CheckBox(700, 510, "Null");
  CheckBox check_conv2_9 = new CheckBox(700, 530, "Null");
  CheckBox check_conv2_10 = new CheckBox(700, 550, "Null");

  TextBox text_filme_1 = new TextBox(700, 550, "Null");
  TextBox text_filme_2 = new TextBox(700, 550, "Null");
  TextBox text_comprimento = new TextBox(700, 550, "Null");
  TextBox text_raio = new TextBox(700, 550, "Null");




  QuadroConfiguracoesCilindricas(String novo_tipo, String novo_texto) {

    this.tipo = novo_tipo;
    this.texto = novo_texto;

    //por padrão

    check_conv1_1.valor = true;
    check_conv2_1.valor = true;
  }
  void Compila() {
    this.coeficiente_filme_1 = float(text_filme_1.texto);
    this.coeficiente_filme_2 = float(text_filme_2.texto);

    this.comprimento_parede = float(text_comprimento.texto);
    this.raio_interno = float(text_raio.texto);

    if (float(text_comprimento.texto)>=0&&float(text_comprimento.texto)<=999999) {
      this.comprimento_parede = float(text_comprimento.texto);
    } else {
      this.comprimento_parede = -1;
    }
    if (float(text_raio.texto)>=0&&float(text_raio.texto)<=999999) {
      this.raio_interno = float(text_raio.texto);
    } else {
      this.raio_interno = -1;
    }

    if (data.tipos_conveccoes.length>0) {
      if (check_conv1_1.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[0][1]);
        this.ambiente_1 = 0;
      }
      if (check_conv2_1.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[0][1]);
        this.ambiente_2 = 0;
      }
    }
    if (data.tipos_conveccoes.length>1) {
      if (check_conv1_2.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[1][1]);
        this.ambiente_1 = 1;
      }
      if (check_conv2_2.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[1][1]);
        this.ambiente_2 = 1;
      }
    }
    if (data.tipos_conveccoes.length>2) {
      if (check_conv1_3.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[2][1]);
        this.ambiente_1 = 2;
      }
      if (check_conv2_3.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[2][1]);
        this.ambiente_2 = 2;
      }
    }
    if (data.tipos_conveccoes.length>3) {
      if (check_conv1_4.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[3][1]);
        this.ambiente_1 = 3;
      }
      if (check_conv2_4.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[3][1]);
        this.ambiente_2 = 3;
      }
    }
    if (data.tipos_conveccoes.length>4) {
      if (check_conv1_5.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[4][1]);
        this.ambiente_1 = 4;
      }
      if (check_conv2_5.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[4][1]);
        this.ambiente_2 = 4;
      }
    }
    if (data.tipos_conveccoes.length>5) {
      if (check_conv1_6.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[5][1]);
        this.ambiente_1 = 5;
      }
      if (check_conv2_6.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[5][1]);
        this.ambiente_2 = 5;
      }
    }
    if (data.tipos_conveccoes.length>6) {
      if (check_conv1_7.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[6][1]);
        this.ambiente_1 = 6;
      }
      if (check_conv2_7.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[6][1]);
        this.ambiente_2 = 6;
      }
    }
    if (data.tipos_conveccoes.length>7) {
      if (check_conv1_8.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[7][1]);
        this.ambiente_1 = 7;
      }
      if (check_conv2_8.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[7][1]);
        this.ambiente_2 = 7;
      }
    }
    if (data.tipos_conveccoes.length>8) {
      if (check_conv1_9.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[8][1]);
        this.ambiente_1 = 8;
      }
      if (check_conv2_9.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[8][1]);
        this.ambiente_2 = 8;
      }
    }
    if (data.tipos_conveccoes.length>9) {
      if (check_conv1_10.valor) {
        this.coeficiente_filme_1 = float(data.filmes_conveccoes[9][1]);
        this.ambiente_1 = 9;
      }
      if (check_conv2_10.valor) {
        this.coeficiente_filme_2 = float(data.filmes_conveccoes[9][1]);
        this.ambiente_2 = 9;
      }
    }
  }
  void Show() {

    stroke(100, 0, 0);
    fill(50, 50, 50);
    strokeWeight(3);
    rect(250, 200, 750, 400, 40); 
    stroke(150, 150, 150);
    strokeWeight(1);
    line(250, 250, 1000, 250);
    fill(255, 255, 255);
    textSize(40);
    text(this.texto, 290, 240);
    textSize(20);



    if (this.tipo == "config") {

      textSize(20);
      text("Para desativar a resistência por convecção:", 300, 280);
      text("AMBIENTE 1", 380, 350);
      text("AMBIENTE 2", 740, 350);

      if (data.tipos_conveccoes.length>0) {
        check_conv1_1.MudaTexto(data.tipos_conveccoes[0][1]);
        check_conv1_1.Show();
        check_conv2_1.MudaTexto(data.tipos_conveccoes[0][1]);
        check_conv2_1.Show();
      }
      if (data.tipos_conveccoes.length>1) {
        check_conv1_2.MudaTexto(data.tipos_conveccoes[1][1]);
        check_conv1_2.Show();
        check_conv2_2.MudaTexto(data.tipos_conveccoes[1][1]);
        check_conv2_2.Show();
      }
      if (data.tipos_conveccoes.length>2) {
        check_conv1_3.MudaTexto(data.tipos_conveccoes[2][1]);
        check_conv1_3.Show();
        check_conv2_3.MudaTexto(data.tipos_conveccoes[2][1]);
        check_conv2_3.Show();
      }
      if (data.tipos_conveccoes.length>3) {
        check_conv1_4.MudaTexto(data.tipos_conveccoes[3][1]);
        check_conv1_4.Show();
        check_conv2_4.MudaTexto(data.tipos_conveccoes[3][1]);
        check_conv2_4.Show();
      }
      if (data.tipos_conveccoes.length>4) {
        check_conv1_5.MudaTexto(data.tipos_conveccoes[4][1]);
        check_conv1_5.Show();
        check_conv2_5.MudaTexto(data.tipos_conveccoes[4][1]);
        check_conv2_5.Show();
      }
      if (data.tipos_conveccoes.length>5) {
        check_conv1_6.MudaTexto(data.tipos_conveccoes[5][1]);
        check_conv1_6.Show();
        check_conv2_6.MudaTexto(data.tipos_conveccoes[5][1]);
        check_conv2_6.Show();
      }
      if (data.tipos_conveccoes.length>6) {
        check_conv1_7.MudaTexto(data.tipos_conveccoes[6][1]);
        check_conv1_7.Show();
        check_conv2_7.MudaTexto(data.tipos_conveccoes[6][1]);
        check_conv2_7.Show();
      }
      if (data.tipos_conveccoes.length>7) {
        check_conv1_8.MudaTexto(data.tipos_conveccoes[7][1]);
        check_conv1_8.Show();
        check_conv2_8.MudaTexto(data.tipos_conveccoes[7][1]);
        check_conv2_8.Show();
      }
      if (data.tipos_conveccoes.length>8) {
        check_conv1_9.MudaTexto(data.tipos_conveccoes[8][1]);
        check_conv1_9.Show();
        check_conv2_9.MudaTexto(data.tipos_conveccoes[8][1]);
        check_conv2_9.Show();
      }
      if (data.tipos_conveccoes.length>9) {
        check_conv1_10.MudaTexto(data.tipos_conveccoes[9][1]);
        check_conv1_10.Show();
        check_conv2_10.MudaTexto(data.tipos_conveccoes[9][1]);
        check_conv2_10.Show();
      }
      fill(255, 255, 255);
      text("Outro Coeficiente: ", 300, data.tipos_conveccoes.length*20+390);
      text("Outro Coeficiente: ", 700, data.tipos_conveccoes.length*20+390);
      textSize(20);
      text("Comprimento da Tubulação (em m): ", 300, data.tipos_conveccoes.length*20+430);
      text("Raio Interno (em mm): ", 300, data.tipos_conveccoes.length*20+470);
      text_filme_1.MudaXY(400, data.tipos_conveccoes.length*20+375);
      text_filme_2.MudaXY(800, data.tipos_conveccoes.length*20+375);
      text_comprimento.MudaXY(660, data.tipos_conveccoes.length*20+415);
      text_raio.MudaXY(525, data.tipos_conveccoes.length*20+455);

      text_filme_1.Show();
      text_filme_2.Show();
      check_temp_1.Show();
      check_temp_2.Show();
      bot_fechar.Show();
      bot_confirmar.Show();
      text_comprimento.Show();
      text_raio.Show();
    }
  }
}