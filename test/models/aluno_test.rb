require 'test_helper'

class AlunoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "logar no portal da UTFPR com login válido" do
    credencial = Credencial.new("1602632", "jefferson123")
    connection = PortalUtfpr.logar(credencial)
    assert connection.logado?
  end
  test "logar no portal da UTFPR com login inválido" do
    credencial = Credencial.new("1602632", "jefferson123")
    connection = PortalUtfpr.logar(credencial)
    assert_not connection.logado?
  end

  test "logar no portal da UTFPR sem a classe Credencial" do
    connection = PortalUtfpr.logar(RA: "1602632", senha: "jefferson123")
    assert_not connection.logado?
  end

  test "logar no portal da UTFPR com matricula trancada" do
    credencial = Credencial.new("1602632", "jefferson123")
    connection = PortalUtfpr.logar(credencial)
    assert connection.logado?
    aluno = connection.build_aluno
    matricula = aluno.matricula_cursos.first
    assert_equal :trancada, matricula.situacao

  end


end
