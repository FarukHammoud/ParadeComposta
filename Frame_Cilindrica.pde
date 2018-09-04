GCilindrico gCilindrico = new GCilindrico();
ParedesCilindricas paredes_cilindricas = new ParedesCilindricas();
ConveccoesCilindricas conveccoes_cilindricas = new ConveccoesCilindricas();
MostradorNumero T3 = new MostradorNumero(100, 550, 4, 33);
MostradorNumero T4 = new MostradorNumero(1070, 550, 4, 34);
QuadroConfiguracoesCilindricas configuracoes_cilindricas = new QuadroConfiguracoesCilindricas("config", "Configurações");
Botao bot_adicionarC = new Botao("normal_1", 60, 200, 7, 8);
Botao bot_configC = new Botao("normal_1", 60, 360, 13, 35);

class GCilindrico {

    void Show(){
      
     if(configuracoes_cilindricas.check_temp_1.valor){
         T3.x_ligacao = 550;
         T3.y_ligacao = 390;
       
     }
     else{
         T3.x_ligacao = 640;
         T3.y_ligacao = 390;
       
     }
     if(configuracoes_cilindricas.check_temp_2.valor){
         T4.x_ligacao = 830;
         T4.y_ligacao = 390;
       
       
     }
     else{
         T4.x_ligacao = 0;
         T4.y_ligacao = 0;
       
     }
      fill(0, 0, 255);
    ellipse(20,20,10,10);

    stroke(255, 255, 255);

    fill(100, 100, 100);
    rect(50, 180, 1180, 530);

    stroke(0, 0, 0);

    fill(50, 50, 50);
    rect(51, 610, 1178, 99);

    fill(50, 0, 0);
    rect(61, 615, 1158, 90);



    tela.Show();
    paredes_cilindricas.Show();
    conveccoes_cilindricas.Show();
    T3.Show();
    T4.Show();
    bot_adicionarC.Show();
    bot_ponto.Show();
    bot_configC.Show();
    bot_grafico.Show();
    bot_voltar.Show();
    if (addParede.on) {
      addParede.Show();
    }
    if (configuracoes_cilindricas.on) {
      configuracoes_cilindricas.Show();
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