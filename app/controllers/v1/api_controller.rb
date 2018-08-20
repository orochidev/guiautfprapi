module V1
	class ApiController < ApplicationController
    before_action :api_authenticate
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::HttpAuthentication::Token::ControllerMethods
  	protected
  	def api_authenticate
  		api_authenticate_by_login_password || render_unauthorized
  	end

  	def api_authenticate_by_login_password

      p params[:campus].nil?
       if params[:campus].nil? || !Campus.const_defined?(params[:campus].upcase)
         render_unauthorized
      else
      authenticate_with_http_basic do |username, password|
        cod_campus = Campus.const_get(params[:campus].upcase)
        utfpr = ConexaoUTFPR.new(username, password, cod_campus)
        if utfpr.is_conectado?
          @current_data = utfpr.get_dados
        else
          render_unauthorized
        end
      end
    end
  	end

  	def render_unauthorized(realm = "Application")
  		self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
  		render :json => {:errors => ['Login ou senhas incorretos. Por favor corrija as informações e tente novamente.']}, status: :unauthorized
  	end
  end

end
