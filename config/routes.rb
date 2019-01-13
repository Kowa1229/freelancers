Rails.application.routes.draw do
  root 'public#home'

  # get 'public/home'

  get 'public/help'
  get 'public/feedback'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
