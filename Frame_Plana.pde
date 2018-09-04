GPlana gPlana = new GPlana();
Mostrador tela = new Mostrador();
MostradorNumero T1 = new MostradorNumero(100, 550, 4, 5);
MostradorNumero T2 = new MostradorNumero(1070, 550, 4, 6);
Paredes paredes = new Paredes();
Conveccoes conveccoes = new Conveccoes();
Botao bot_adicionar = new Botao("normal_1", 60, 200, 7, 8);
Botao bot_ponto = new Botao("normal_1", 60, 280, 9, 10);
Botao bot_config = new Botao("normal_1", 60, 360, 13, 14);
Botao bot_grafico = new Botao("normal_1", 60, 440, 15, 16);
Botao bot_voltar = new Botao("normal_1", 1160, 200, 25, 26);
QuadroAddParede addParede = new QuadroAddParede("AddParede", "Nova Parede");
QuadroConfiguracoes configuracoes = new QuadroConfiguracoes("config", "Configurações");
QuadroEditar editar = new QuadroEditar();
QuadroAlerta salvo = new QuadroAlerta("Ponto Salvo",30);
QuadroAlerta falta = new QuadroAlerta("Dados Faltando",38);
QuadroGrafico grafic = new QuadroGrafico("Gráfico Taxa X Ponto");

class GPlana {
  

  void Show() {
     if(configuracoes.check_temp_1.valor){
         T1.x_ligacao = 390;
         T1.y_ligacao = 500;
       
     }
     else{
         T1.x_ligacao = 0;
         T1.y_ligacao = 0;
       
     }
     if(configuracoes.check_temp_2.valor){
         T2.x_ligacao = 890;
         T2.y_ligacao = 450;
       
       
     }
     else{
         T2.x_ligacao = 0;
         T2.y_ligacao = 0;
       
     }
    
    fill(0, 255, 0);
    ellipse(20, 20, 10, 10);

    stroke(255, 255, 255);

    fill(100, 100, 100);
    rect(50, 180, 1180, 530);

    stroke(0, 0, 0);

    fill(50, 50, 50);
    rect(51, 610, 1178, 99);

    fill(50, 0, 0);
    rect(61, 615, 1158, 90);

    fill(150, 150, 150);
    rect(390, 550, 500, 60);

    rect(390, 181, 500, 29);

    for (int a =0; a< 48; a++) {

      stroke(0, 0, 0);
      line(390+a*10, 195, 415+a*10, 210);
      line(390+a*10, 550, 415+a*10, 565);
    }

    tela.Show();
    conveccoes.Show();
    paredes.Show();
    T1.Show();
    T2.Show();
    bot_adicionar.Show();
    bot_ponto.Show();
    bot_config.Show();
    bot_grafico.Show();
    bot_voltar.Show();
    if (addParede.on) {
      addParede.Show();
    }
    if (configuracoes.on) {
      configuracoes.Show();
    }
    if (editar.on) {
      editar.Show();
    }
    if (salvo.on) {
      salvo.Show();
    }
    if (grafic.on) {
      grafic.Show();
    }

    image(mais, 65, 205, 50, 50);
    image(ponto, 65, 285, 50, 50);
    image(config, 65, 365, 50, 50);
    image(grafico, 65, 445, 50, 50);
    image(voltar, 1165, 205, 50, 50);
    
  }
}