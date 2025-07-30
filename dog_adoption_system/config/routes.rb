Rails.application.routes.draw do
  get "breeds/index"
  get "breeds/show"
  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'home', to: 'pages#home'

  resources :dogs, only: [:index, :show]
  resources :owners, only: [:index, :show]
  resources :adoptions, only: [:index, :show]

  get 'breeds', to: 'breeds#index'
  get 'breeds/:breed_name', to: 'breeds#show', as: 'breed'
  

  get "up" => "rails/health#show", as: :rails_health_check
end