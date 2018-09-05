module V1

  class AlunosController < ApiController
    def index
    end

    def disciplinas_matriculadas
      render  :json => @current_data.boletim.to_h

    end
  end
end
