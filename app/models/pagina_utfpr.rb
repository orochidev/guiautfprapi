class PaginaUTFPR
  attr_accessor :ra, :login, :senha, :cod_campus, :conexao

  def initialize(conexao)
    self.conexao = conexao
    self.login = conexao.login
    self.ra = conexao.login

    self.senha = conexao.senha
    self.cod_campus = conexao.cod_campus
  end

  def page_html
    page = open(page_url, http_basic_authentication: [self.login,self.senha])
    Nokogiri::HTML(page)
  end
end
