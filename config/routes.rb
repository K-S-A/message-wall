Rails.application.routes.draw do
  # get '/auth/:provider/callback', to: 'sessions#create'
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  root 'messages#index'
  resources :messages, except: [:destroy]
end
