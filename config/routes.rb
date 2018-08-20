Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #API
 namespace :v1, defaults: { format: :json }  do

   get "/dados_portal" => "dados_portal#show" #GET usuarios/logar?


 end
end
