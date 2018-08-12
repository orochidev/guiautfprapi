class PaginaDisciplinasMatriculadas < PaginaUTFPR
  def extrair
    html = page_html
    hash = OpenStruct.new
    tabela1 = html.at("table.cabealuno")
    tabela1.css("tr").each{|element| element.css("strong").remove  }


    hash.nome = tabela1.css("tr")[0].css("td")[0].text.strip

    hash.curso = tabela1.css("tr")[1].css("td")[0].text.strip
    hash.periodo = tabela1.css("tr")[1].css("td")[1].text.strip

    hash.turno = tabela1.css("tr")[2].css("td")[0].text.strip
    hash.matriz = tabela1.css("tr")[2].css("td")[1].text.strip.gsub("\n", "")
    hash.situacao = tabela1.css("tr")[2].css("td")[2].text.strip.gsub("\n", "")

    hash.ingresso = tabela1.css("tr")[3].css("td")[0].text.strip.gsub("\n", "")
    hash.coeficiente = tabela1.css("tr")[3].css("td")[1].text.strip.gsub("\n", "")
    hash.data_colacao = tabela1.css("tr")[3].css("td")[2].text.strip.gsub("\n", "")

    tabela2 = html.at("#fsDisciplinas_int > table")

    hash.disciplinas = tabela2.css("tr")[1..-4].collect do |e|
      disciplina = OpenStruct.new
      disciplina.codigo = e.css("td")[0].text
      disciplina.nome = e.css("td")[1].text
      disciplina.turma = e.css("td")[2].text
      #TODO: Pegar plano de ensino e o outro plano que tá lá
      disciplina.chs = e.css("td")[5].text
      disciplina
    end

  #  p hash.disciplinas

    tabela3 = html.at("#fshorarios_int > table")
    hash.horarios = tabela3.css("tr")[1..-1].collect do |e|
      horario = OpenStruct.new
      horario.codigo = e.css("td")[0].text
      horario.inicio = e.css("th")[0].text
      horario.termino = e.css("th")[1].text
      horario.aula_segunda = parse_aula_string(e.css("td")[1].text)
      horario.aula_terca = parse_aula_string(e.css("td")[2].text)
      horario.aula_quarta = parse_aula_string(e.css("td")[3].text)
      horario.aula_quinta = parse_aula_string(e.css("td")[4].text)
      horario.aula_sexta = parse_aula_string(e.css("td")[5].text)
      horario.aula_sabado = parse_aula_string(e.css("td")[6].text)
      horario
    end


  end

  private

  def parse_aula_string(string)
    if !string.blank?
      temp = OpenStruct.new

      temp.codigo_disciplina = string.split("-")[0]
      temp.codigo_turma = string.split("-")[1].split("/")[0]
      temp.sala = string.split("-")[1].split("/")[1]
      temp
    end
  end
  def page_url
    "https://utfws.utfpr.edu.br/aluno#{self.conexao.cod_campus}/sistema/mpconfirmacaomatricula.pcTelaAluno?p_pesscodnr=#{self.ra[0..-2]}&p_curscodnr=#{self.conexao.curscodnr}&p_alcuordemnr=#{self.conexao.alcuordemnr}"
  end

end
