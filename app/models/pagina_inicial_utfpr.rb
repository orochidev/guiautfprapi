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
  end
  private
  def page_url
    "https://utfws.utfpr.edu.br/aluno#{cod_campus}/sistema/mpmenu.inicio"

  end

end
