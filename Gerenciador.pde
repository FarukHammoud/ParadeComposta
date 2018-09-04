Gerenciador gerenciador = new Gerenciador(0);

class Gerenciador {
  int frame = 0; // 0 - inicio ; 1 - parede composta plana ; 2 parede composta cilindrica

  Gerenciador(int new_frame) {

    this.frame = new_frame;
  }
  void Atualizar() {

    if (this.frame == 0) {
      gInicio.Show();
    } else if (this.frame == 1) {
      configuracoes.Compila();
      gPlana.Show();
    } else if (this.frame == 2) {
      configuracoes_cilindricas.Compila();
      gCilindrico.Show();
    }
  }
  void Tarefa(int tarefa) {
    if (tarefa == -1) {
    } else if (tarefa == 0) {
      this.frame = 0;// Muda para o primeiro frame
    } else if (tarefa == 1) { // Muda para o segundo frame
      this.frame = 1;
    } else if (tarefa == 2) { // muda para o terceiro frame
      this.frame = 2;
    } else if (tarefa == 3) {
      if (this.frame==0) {
        gInicio.showOptions = true;
      }
    } else if (tarefa == 4) {
      fill(120, 0, 0);
      if (mouseX<600) {
        text("Clique ou role o scroll para mudar a temperatura.", mouseX+20, mouseY-50);
      } else {
        text("Clique ou role o scroll para mudar a temperatura.", mouseX-400, mouseY-50);
      }
    } else if (tarefa == 5) {
      if (T1.show_editor) {
        T1.selecionado = true;
        T1.numero = int(T1.editor.texto);
        T1.show_editor = false;
      } else {
        T1.selecionado = false;
        T1.show_editor = true;
      }
    } else if (tarefa == 6) {
      if (T2.show_editor) {
        T2.selecionado = true;
        T2.numero = int(T2.editor.texto);
        T2.show_editor = false;
      } else {
        T2.selecionado = false;
        T2.show_editor = true;
      }
    } else if (tarefa == 7) {
      fill(120, 0, 0);
      text("Clique para adicionar uma parede.", mouseX+40, mouseY);
    } else if (tarefa == 8) {
      addParede.on = true;
    } else if (tarefa == 9) {
      fill(120, 0, 0);
      text("Clique salvar o ponto atual.", mouseX+40, mouseY);
    } else if (tarefa == 10) {
      //salvar o ponto atual
      salvo.on = true;
      data.ImprimeTmp();
    } else if (tarefa == 11) {
      fill(120, 0, 0);
      if (paredes.ContaExistentes()>0) {
        text(paredes.linha_1, mouseX+20, mouseY-20);
        text(paredes.linha_2, mouseX+20, mouseY);
        text(paredes.linha_3, mouseX+20, mouseY+20);


        ellipse(mouseX, mouseY, 10, 10);
      }
    } else if (tarefa == 12) {
      if(paredes.ContaExistentes()>0){
      editar.on = true;
      editar.x = mouseX;
      editar.y = mouseY;
      }
    } else if (tarefa == 13) {
      fill(120, 0, 0);
      text("Clique para modificar as configurações.", mouseX+40, mouseY);
    } else if (tarefa == 14) {
      configuracoes.on = true;
    } else if (tarefa == 15) {
      fill(120, 0, 0);
      text("Clique para gerar um grafico.", mouseX+40, mouseY);
    } else if (tarefa == 16) {
        grafic.on = true;
        data.getTmp();
    } else if (tarefa == 17) {
      //passar por cima fechar
    } else if (tarefa == 18) {
      addParede.on = false;
    } else if (tarefa == 19) {
      //passar por cima confirmar
    } else if (tarefa == 20) {
      addParede.Compila();
      addParede.on = false;
    } else if (tarefa == 21) {
      //passar por cima confirmar
    } else if (tarefa == 22) {
      configuracoes.on = false;
    } else if (tarefa == 23) {
      //passar por cima confirmar
    } else if (tarefa == 24) {
      configuracoes.on = false;
      configuracoes.Compila();
    } else if (tarefa == 25) {
      fill(120, 0, 0);
      text("Clique para voltar ao menu.", mouseX-300, mouseY);
    } else if (tarefa == 26) {
      this.frame = 0;
      paredes.Limpar();
      paredes_cilindricas.Limpar();
      T1.Limpar();
      T2.Limpar();
      
    }
     else if (tarefa == 27) {
      editar.on = false;
    }
    else if (tarefa == 28) {
      //BOTAO EDITAR
      editar.on = false;
    }
    else if (tarefa == 29) {
      //BOTAO DELETAR
      editar.on = false;
      paredes.Excluir(paredes.Atual());
      
    }
    else if (tarefa == 30) {
      //BOTAO DELETAR
      salvo.on = false;
    }
    else if(tarefa == 31){
      fill(120, 0, 0);
      if (paredes_cilindricas.ContaExistentes()>0) {
        text(paredes_cilindricas.linha_1, mouseX+20, mouseY-20);
        text(paredes_cilindricas.linha_2, mouseX+20, mouseY);
        text(paredes_cilindricas.linha_3, mouseX+20, mouseY+20);


        ellipse(mouseX, mouseY, 10, 10);
      }
     
      
    }
    else if (tarefa == 32) {
      //BOTAO DELETAR
      editar.on = false;
      paredes_cilindricas.Excluir(paredes_cilindricas.Atual());
      
    }
     else if (tarefa == 33) {
      if (T3.show_editor) {
        T3.selecionado = true;
        T3.numero = int(T3.editor.texto);
        T3.show_editor = false;
      } else {
        T3.selecionado = false;
        T3.show_editor = true;
      }
    }
     else if (tarefa == 34) {
      if (T4.show_editor) {
        T4.selecionado = true;
        T4.numero = int(T4.editor.texto);
        T4.show_editor = false;
      } else {
        T4.selecionado = false;
        T4.show_editor = true;
      }
    }
    else if (tarefa == 35) {
      configuracoes_cilindricas.on = true;
    }
   else if (tarefa == 36) {
      configuracoes_cilindricas.on = false;
    }else if (tarefa == 37) {
      configuracoes_cilindricas.on = false;
      configuracoes_cilindricas.Compila();
    }
    else if (tarefa == 38) {
      //BOTAO DELETAR
      falta.on = false;
    }
    else if(tarefa == 39){
       grafic.on = false; 
    }
  }
}