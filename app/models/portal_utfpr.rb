require 'rubygems'

require 'open-uri'
require 'nokogiri'

class PortalUtfpr

  def self.logar(login: , senha:)
    OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ciphers] = "DES-CBC3-SHA"
    conexao = ConexaoUtfpr.new(login: login, senha)
    conexao.logado?


    teste = open("https://utfws.utfpr.edu.br/aluno03/sistema/mpmenu.inicio",
    http_basic_authentication: [login,senha])
    doc = Nokogiri::HTML(teste)
    p doc.at("html").to_html


  end


end
