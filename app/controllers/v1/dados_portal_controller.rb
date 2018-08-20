class OpenStruct
  def as_json(options = nil)
    @table.as_json(options)
  end
end

module V1
  class DadosPortalController < ApiController

    # GET /alunos/1
    # GET /alunos/1.json
    def show
      render  :json => @current_data.to_h
    end

    # POST /alunos
    # POST /alunos.json


    private
    def openstruct_to_hash(object, hash = {})
    object.each_pair do |key, value|
      hash[key] = value.is_a?(OpenStruct) ? openstruct_to_hash(value) : value
    end
    hash
  end


      # Use callbacks to share common setup or constraints between actions.
      def set_aluno
        @aluno = Aluno.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def aluno_params
        params.fetch(:aluno, {})
      end
  end
end
