class PaginaDeclaracaoMatricula < PaginaUTFPR

    def extrair
      html = page_html
      hash = OpenStruct.new
      tabela = html.at("body > center > table > thead > tr > td > table > tbody:nth-child(3) > tr > td > center > table")
    #  p tabela.text
      #p tabela
      #Para extrair Nome e RA da barra superior
      tabela.css("tr").each{|element| element.css("strong").remove  }
      hash.nome = tabela.css("tr")[0].css("td")[0].text
      hash.ra = tabela.css("tr")[0].css("td")[1].text

      hash.nome_curso = tabela.css("tr")[1].css("td")[0].text

      hash.carga_horaria = tabela.css("tr")[2].css("td")[0].text
      hash.duracao = tabela.css("tr")[2].css("td")[1].text
      hash.regime_ensino = tabela.css("tr")[2].css("td")[2].text

      hash.ingresso = tabela.css("tr")[3].css("td")[0].text
      p hash.ingresso
      hash.periodo = tabela.css("tr")[4].css("td")[0].text

      hash.semestre = tabela.css("tr")[4].css("td")[1].text
      hash.turno = tabela.css("tr")[4].css("td")[2].text

      hash.inicio_semestre = tabela.css("tr")[5].css("td")[0].text
      hash.termino_semestre = tabela.css("tr")[5].css("td")[1].text
      hash.dias_letivos = tabela.css("tr")[5].css("td")[2].text

      hash.estagio = tabela.css("tr")[6].css("td")[0].text



    #  p hash
      hash
    end

    private
    def page_url
      "https://utfws.utfpr.edu.br/aluno#{self.conexao.cod_campus}/sistema/mpDeclaracoes.inicioAluno?p_pesscodnr=#{self.ra[0..-2]}&p_curscodnr=#{self.conexao.curscodnr}&p_alcuordemnr=#{self.conexao.alcuordemnr}"
    end

end
