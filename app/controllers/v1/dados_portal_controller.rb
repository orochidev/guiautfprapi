

module V1
  class DadosPortalController < ApiController

    # GET /alunos/1
    # GET /alunos/1.json
    def show
      render  :json => @current_data.to_h
    end

    # POST /alunos
    # POST /alunos.json

    def next_class

    end


  end
end
