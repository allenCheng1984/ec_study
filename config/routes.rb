Rails.application.routes.draw do
  root 'dashboard#index'

  get '/team_members', to: 'dashboard#team_members'
  get '/about', to: 'dashboard#about'
  get '/predict', to: 'dashboard#predict'
  get '/dataset_info', to: 'dashboard#dataset_info'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
