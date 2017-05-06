require 'test_helper'

class AlunoTest <   ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @RA = "#{Rails.application.secrets.RA_VALIDO_1}"
    @password = "" + Rails.application.secrets.SENHA_VALIDA_1

    @RA_trancado = "#{Rails.application.secrets.RA_TRANCADO_1}"
    @password_trancado = "" + Rails.application.secrets.SENHA_TRANCADO_1


  end
  test "pegar nome da página inicial do portal do aluno" do
    connection = ConexaoUTFPR.new(login: @RA, senha: @password, campus: "03")
  end



end
