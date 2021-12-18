Rails.application.routes.draw do
  root 'dashboard#index'

  get '/team_members', to: 'dashboard#team_members'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
