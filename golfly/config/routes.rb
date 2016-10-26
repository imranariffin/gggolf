Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'
  get 'about', to: 'home#about' 
  get 'contact', to: 'home#contact'

  resources :users
  resources :tournaments

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
