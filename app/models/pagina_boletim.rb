class PaginaBoletim < PaginaUTFPR

  def extrair
    html = page_html
    hash = OpenStruct.new
    tabela2 = html.at("body > center:nth-child(4) > table.tbl")
    hash.disciplinas = tabela2.css("tr")[1..-1]
    .select{|e| e.css("td").size >7}
    .collect do |e|
      next if e.css("td").size < 7
      disciplina = OpenStruct.new
      disciplina.codigo = e.css("td")[0].text
      disciplina.nome = e.css("td")[1].text

      disciplina.codigo_turma = e.css("td")[2].text
      disciplina.faltas = e.css("td")[3].text
      disciplina.media_parcial = e.css("td")[3].text
      disciplina.aulas_dadas = e.css("td")[4].text
      disciplina.cch_prevista = e.css("td")[5].text
      disciplina.pct_frequencia = e.css("td")[6].text
      disciplina.media_final = e.css("td")[7].text
      disciplina.situacao = e.css("td")[8].text
      disciplina
    end

    hash
  end
  private
  def page_url
    "https://utfws.utfpr.edu.br/aluno#{self.conexao.cod_campus}/sistema/mpboletim.inicioAluno?p_pesscodnr=#{self.ra[0..-2]}&p_curscodnr=#{self.conexao.curscodnr}&p_alcuordemnr=#{self.conexao.alcuordemnr}"
  end

end
