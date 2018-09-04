Calculos calculo = new Calculos();
class Calculos {

  float espessura=0;

  float condutividade=0;

  float resistencia_termica=0;

  float delta_temperaturas=0;

  float Taxa() {

    return this.Fluxo()*configuracoes.area_parede;
  }
  float Fluxo() {

    resistencia_termica = 0;

    if (paredes.ContaExistentes()>0) {
      for (int a =0; a<paredes.ContaExistentes(); a++) {

        this.resistencia_termica += (paredes.espessura[a]/1000)/paredes.condutividade[a]; // RESISTENCIA POR CONDUÇÃO
      }
      if (configuracoes.check_temp_1.valor==false) {//RESISTENCIA POR CONVECCAO NO AMBIENTE 1
        this.resistencia_termica += 1/configuracoes.coeficiente_filme_1;
      }
      if (configuracoes.check_temp_2.valor==false) {//RESISTENCIA POR CONVECCAO NO AMBIENTE 2
        this.resistencia_termica += 1/configuracoes.coeficiente_filme_2;
      }

      this.delta_temperaturas = abs(T1.RetornaNumero() - T2.RetornaNumero());

      return this.delta_temperaturas/this.resistencia_termica;
    } else {
      return 0;
    }
  }
  float TaxaCilindrica() {
    return this.FluxoCilindrico()*configuracoes_cilindricas.comprimento_parede;
  }
  float FluxoCilindrico() {

    float raio_interno_atual = configuracoes_cilindricas.raio_interno;
    resistencia_termica = 0;
    if (paredes_cilindricas.ContaExistentes()>0) {
      for (int a =paredes_cilindricas.ContaExistentes()-1; a>=0; a--) {

        this.resistencia_termica += log((raio_interno_atual+paredes_cilindricas.espessura[a])/raio_interno_atual)/(2*PI*paredes_cilindricas.condutividade[a]); // RESISTENCIA POR CONDUÇÃO

        raio_interno_atual+=paredes_cilindricas.espessura[a];
      }
      if (configuracoes_cilindricas.check_temp_1.valor==false) {//RESISTENCIA POR CONVECCAO NO AMBIENTE 1
        this.resistencia_termica += 1/configuracoes_cilindricas.coeficiente_filme_1;
      }
      if (configuracoes_cilindricas.check_temp_2.valor==false) {//RESISTENCIA POR CONVECCAO NO AMBIENTE 2
        this.resistencia_termica += 1/configuracoes_cilindricas.coeficiente_filme_2;
      }

      this.delta_temperaturas = abs(T3.RetornaNumero() - T4.RetornaNumero());

      return this.delta_temperaturas/this.resistencia_termica;
    } else {
      return 0;
    }
  }
  int DistanciaPP(int x_1, int y_1, int x_2, int y_2) {

    int y = abs(y_1-y_2);
    int x = abs(x_1-x_2);

    return int(sqrt(pow(x, 2) + pow(y, 2)));
  }
}