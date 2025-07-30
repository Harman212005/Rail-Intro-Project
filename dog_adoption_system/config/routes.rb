Rails.application.routes.draw do
  root 'pages#home'
 
  get 'about', to: 'pages#about'
  get 'home', to: 'pages#home'
  
  get "up" => "rails/health#show", as: :rails_health_check
end