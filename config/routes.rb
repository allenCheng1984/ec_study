Rails.application.routes.draw do
  root 'dashboard#index'

  get '/team_members', to: 'dashboard#team_members'
  get '/about', to: 'dashboard#about'
  get '/predict', to: 'dashboard#predict'
  get '/dataset_info', to: 'dashboard#dataset_info'

  get '/sales_intro', to: 'dashboard#sales_intro'
  get '/sales_model_training', to: 'dashboard#sales_model_training'
  get '/sales_conclusion', to: 'dashboard#sales_conclusion'

  get '/review_intro', to: 'dashboard#review_intro'
  get '/review_model_training', to: 'dashboard#review_model_training'
  get '/review_conclusion', to: 'dashboard#review_conclusion'

  get '/logistics_intro', to: 'dashboard#logistics_intro'
  get '/logistics_model_training', to: 'dashboard#logistics_model_training'
  get '/logistics_conclusion', to: 'dashboard#logistics_conclusion'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
