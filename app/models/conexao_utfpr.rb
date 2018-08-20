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
    end

    def get_dados
      if is_conectado?
        dados = OpenStruct.new
        dados.pagina_inicial = PaginaInicialUTFPR.new(self).extrair
        self.curscodnr = dados.pagina_inicial.curscodnr
        self.alcuordemnr = dados.pagina_inicial.alcuordemnr

        dados.declaracao_matricula = PaginaDeclaracaoMatricula.new(self).extrair
        dados.disciplinas_matricladas = PaginaDisciplinasMatriculadas.new(self).extrair
        dados.boletim = PaginaBoletim.new(self).extrair

        #self.ra = dados.pagina_inicial  =.curscodnr
        dados
      end
    end


    def RA
      self.ra
    end
    def is_conectado?
      status = nil
      begin
        open("https://utfws.utfpr.edu.br/aluno03/sistema/mpmenu.inicio",
        http_basic_authentication: [self.login, self.senha]) do |f|
          status = f.status[0]    #=> ["200", "OK"]
        end
      rescue OpenURI::HTTPError => e
        status = e.io.status[0]
      end
      status == "200"
    end
    private

    def configurar_conexao
      OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ciphers] = "DES-CBC3-SHA"
    end
end
