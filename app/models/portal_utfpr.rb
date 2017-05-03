class PortalUtfpr
  LOGIN_URL = ""
  def self.logar(login: , senha:)
    agent = Mechanize.new{|a| a.ssl_version, a.verify_mode = 'SSLv3', OpenSSL::SSL::VERIFY_NONE}
    agent.ssl_version = 'SSLv3'
    agent.add_auth(PortalUtfpr.login_url(9), login, senha)
    agent.get(PortalUtfpr.login_url(9)) do |page|
      puts page.title
    end
    ConexaoUtfpr.new

  end

  def self.login_url(cod_campus)
    cod_campus
    cod = ""
    cod += "0" if cod_campus <= 9
    cod += "#{cod_campus}"
    "http://utfws.utfpr.edu.br/aluno#{cod}/sistema/mpmenu.inicio"
  end
end
