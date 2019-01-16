Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/signup',   to: 'users#new'
  root 'public#home'

  # get 'public/home'

  get 'public/help'
  get 'public/feedback'

  resources :users
  resources :account_activations, only: [:edit]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
