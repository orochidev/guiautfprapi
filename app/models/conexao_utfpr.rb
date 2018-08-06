require 'open-uri'
require 'nokogiri'
require 'ostruct'
class ConexaoUTFPR
    attr_accessor :login, :senha, :cod_campus, :ra, :curscodnr, :pesscodnr, :alcuordemnr
    def initialize(login, senha, campus)
      self.login = login
      self.senha = senha
      self.cod_campus = campus

      configurar_conexao
      dados = OpenStruct.new
      dados.pagina_inicial = PaginaInicialUTFPR.new(self).extrair
      self.curscodnr = dados.pagina_inicial.curscodnr
      self.alcuordemnr = dados.pagina_inicial.alcuordemnr

      dados.declaracao_matricula = PaginaDeclaracaoMatricula.new(self).extrairs
      #self.ra = dados.pagina_inicial  =.curscodnr


    end
    def logado?
      teste = open("https://utfws.utfpr.edu.br/aluno03/sistema/mpmenu.inicio",
      http_basic_authentication: [login,senha])
      doc = Nokogiri::HTML(teste)
      p doc.at("html").to_html

      true
    end

    def RA
      self.ra
    end
    private
    def conectar

    end
    def configurar_conexao
      OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ciphers] = "DES-CBC3-SHA"

    end
end
