require 'test_helper'

class AlunoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @RA = Rails.application.secrets.RA_VALIDO_1
    @password = Rails.application.secrets.SENHA_VALIDA_1

    @RA_trancado = Rails.application.secrets.RA_TRANCADO_1
    @password_trancado = Rails.application.secrets.SENHA_TRACADO_1


  end
  test "logar no portal da UTFPR com login válido" do
    connection = PortalUtfpr.logar(login: @RA, senha: @password)
    assert connection.logado?
  end
  test "logar no portal da UTFPR com login inválido" do
    credencial = Credencial.new(@RA, "kk*8(*)*)")
    connection = PortalUtfpr.logar(credencial)
    assert_not connection.logado?
  end

  test "logar no portal da UTFPR sem a classe Credencial" do
    connection = PortalUtfpr.logar(login: @RA, senha: @password)
    assert connection.logado?
  end

  test "logar no portal da UTFPR com matricula trancada" do
    connection = PortalUtfpr.logar(login: @RA_trancado, senha: @password)
    assert connection.logado?
    aluno = connection.build_aluno
    matricula = aluno.matricula_cursos.first
    assert_equal :trancada, matricula.situacao

  end


end
