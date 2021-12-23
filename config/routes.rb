Rails.application.routes.draw do
  root 'dashboard#index'

  get '/team_members', to: 'dashboard#team_members'
  get '/about', to: 'dashboard#about'
  get '/predict', to: 'dashboard#predict'
  get '/dataset_info', to: 'dashboard#dataset_info'

  get '/logistics_intro', to: 'dashboard#logistics_intro'
  get '/logistics_core_model', to: 'dashboard#logistics_core_model'
  get '/logistics_model_training', to: 'dashboard#logistics_model_training'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
