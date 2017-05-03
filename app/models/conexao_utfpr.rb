class ConexaoUtfpr
    def logado?
      true
    end
    def build_aluno
      raise DeslogadoError unless logado?

      Aluno.new
    end
    private
end
