require 'open-uri'
require 'nokogiri'
class ConexaoUTFPR
    attr_accessor :login, :senha
    def initialize(login: , senha: , campus:)
      configurar_conexao
      inicial = PaginaInicialUTFPR.new(login: login, senha: senha, cod_campus: campus)
      dados_inicial = inicial.extrair
      p dados_inicial
    end
    def logado?
      teste = open("https://utfws.utfpr.edu.br/aluno03/sistema/mpmenu.inicio",
      http_basic_authentication: [login,senha])
      doc = Nokogiri::HTML(teste)
      p doc.at("html").to_html

      true
    end
    private
    def conectar

    end
    def configurar_conexao
      OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ciphers] = "DES-CBC3-SHA"

    end
end
