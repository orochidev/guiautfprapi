Rails.application.routes.draw do
  get 'cursos/index'

  get 'cursos/show'

  resources :alunos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #API
  #root 'topics#index'
 namespace :v1, defaults: { format: :json }  do

   get "/dados_portal" => "dados_portal#show" #GET usuarios/logar?
   get "/disciplinas_matriculadas" => "alunos#disciplinas_matriculadas" #GET usuarios/logar?


 end
end
