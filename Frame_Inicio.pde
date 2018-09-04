GInicio gInicio = new GInicio();
Botao bot_in_1 = new Botao("inicial", 200, 300, "Plana", 1);
Botao bot_in_2 = new Botao("inicial", 680, 300, "Cilíndrica", 2);


class GInicio {

  boolean showOptions = false;

  void Show() {
    image(fundo, 0, 0, 1280, 720);
    fill(255, 0, 0);
    stroke(255, 255, 255);
    ellipse(20, 20, 10, 10);
    fill(0, 100, 250);
    rect(50, 20, 1180, 150);

    fill(255, 255, 255);
    textSize(20);
    stroke(255, 255, 255);
    text("Simulador Didático", 55, 40);
    fill(255, 0, 0); 
    textSize(80);
    text("Paredes Compostas", 80, 130);
    image(lacit, 940, 50, 200, 100);

    if (showOptions) {
      textSize(30);
      fill(150, 150, 150);
      text("1. Selecione o tipo de Parede:", 100, 270);
       

      bot_in_1.Show();
      bot_in_2.Show();
    } else {

      fill(255, 255, 255);
      textSize(30);
      text("- Pressione \"ESPAÇO\" para Iniciar o Simulador -", 280, 420);
    }
  }
}