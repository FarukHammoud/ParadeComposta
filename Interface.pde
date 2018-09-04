Interface interfaceX = new Interface();
class Interface {

  String atual_string;
  float scroll = 0;
  void ScrollPlus() {
    scroll++;
  }
  void ScrollMinus() {
    scroll--;
  }
  void DeletaString() {

    this.atual_string="";
  }
  String RetornaString() {

    return this.atual_string;
  }
  void SearchKey() {
    if (keyPressed) {
      keyPressed = false;
      if ((key>='a'&&key<='z')||key==' '||key=='.'||(key>='A'&&key<='Z')||(key>='0'&&key<='9')) {

        this.atual_string += str(key);
      }
      if (key==BACKSPACE){
         if (this.atual_string.length() > 0) {
          this.atual_string = this.atual_string.substring(0, this.atual_string.length() - 1);
        }
        
      }
      if (key==DELETE) {

        this.atual_string="";
      }
      if (keyCode == DOWN) {
      } else if (keyCode == LEFT) {
      } else if (keyCode == RIGHT) {
      } else if (keyCode == UP) {
        paredes.AdicionaParede("Madeira", 50, 5.5);
      } else if (keyCode == ENTER) {
      } else if (key == '+') {
      } else if (key == ' ') {
        gerenciador.Tarefa(3); // Habilita opções no inicio
      } else if (key == '-') {
      } else if (key == 'x'||key == 'X') {
        gerenciador.Tarefa(0); // Muda para frame 0
      } else if (key == 'y'||key == 'Y') {
        gerenciador.Tarefa(1); // Muda para frame 1
      } else if (key == 'z'||key == 'Z') {
        gerenciador.Tarefa(2); // Muda para frame 2
      } else if (key == 'D'||key == 'd') {
        data.getMateriais();
        data.getConveccoes();
      } else if (key == 'i'||key == 'I') {
        data.ImprimaMateriais();
        data.ImprimaConveccoes();
      } else if (key == 'p'||key == 'P') {
        paredes.AdicionaParede("Papelao", 50, 5.5);
      } else if (key == 'a'||key == 'A') {
        paredes.AdicionaParede("Aco", 50, 15);
      }
    } else if (key == 'e'||key == 'E') {
      paredes.AdicionaParede("Aco", 50, 15);
    }
  }
}

void mousePressed() {
}
void mouseDragged() {
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e>0) {
    interfaceX.ScrollPlus();
  } else {
    interfaceX.ScrollMinus();
  }
}