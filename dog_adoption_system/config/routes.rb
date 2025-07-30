Rails.application.routes.draw do
  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'home', to: 'pages#home'
  

  resources :dogs, only: [:index, :show]
  resources :owners, only: [:index, :show]
  resources :adoptions, only: [:index, :show]
  
  get "up" => "rails/health#show", as: :rails_health_check
end