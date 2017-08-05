Rails.application.routes.draw do
  resources :photos
  #get 'photo/index'

  devise_for :users
  get 'home/create'
  root 'photos#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
