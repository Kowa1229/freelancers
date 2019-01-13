Rails.application.routes.draw do
  get 'users/new'
  root 'public#home'

  # get 'public/home'

  get 'public/help'
  get 'public/feedback'

  resources :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
