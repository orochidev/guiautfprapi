require "ostruct"

class PaginaInicialUTFPR < PaginaUTFPR

  def extrair
    html = page_html
    hash = OpenStruct.new
    #Para extrair Nome e RA da barra superior
    aux = html.at("//*[@id='div_fsInterno']/table/tr[1]/td[2]/font")
    aux.search(".//b").remove #bang
    str = aux.text
    hash.RA = self.conexao.RA
    hash.nome = str.match(/[^\d -][\W\w]+/)[0]
    if !html.at_css("select#p_CursLinha")
      #Para extrair nome do curso e situação
      aux = html.at("//*[@id='cursos']/center/font")
      aux.search(".//strong").remove #bang
      str = aux.text.strip
      hash.nome_curso = str.split("-")[0].strip
      hash.situacao_curso = str.split("-")[1].strip

      #Pra pegar umas variavel louca ai que não sei pra que serve
      aux = html.search("script:contains('jsCursos')").last
      str = aux.text.match(/{[\w\W]*}/)[0].gsub(/\s+/, "").gsub(/([a-z]+):/, '"\1":')

      json = JSON.parse(str)

      hash.linha = json["linha"]
      hash.curscodnr = json["curscodnr"]
      hash.tpcurcodnr = json["tpcurcodnr"]
      hash.alcuordemnr = json["alcuordemnr"]
      hash
    else
      aux = html.search("select#p_CursLinha option:contains('Regular')").first
      linha = aux.attr("value")

      hash.nome_curso = aux.text.split("-")[0].strip
      hash.situacao_curso = aux.text.split("-")[2].split(":")[1].strip
      p hash.nome_curso
      p hash.situacao_curso

      aux = html.search("script:contains('jsCursos')").last
      str = aux.text.split("=")[1].split(";")[0].chomp.strip.gsub(/([a-z]+):/, '"\1":')

      json = JSON.parse(str)

      json = json.select{|j| j["linha"].to_s == linha}.first

      hash.linha = json["linha"]
      hash.curscodnr = json["curscodnr"]
      hash.tpcurcodnr = json["tpcurcodnr"]
      hash.alcuordemnr = json["alcuordemnr"]
      hash
    end
  end
  private
  def page_url
    "https://utfws.utfpr.edu.br/aluno#{cod_campus}/sistema/mpmenu.inicio"

  end
  def has_select_box?

  end
end
