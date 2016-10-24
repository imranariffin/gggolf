Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration"
  end
  devise_for :users, :controllers => {:registrations => "user_registrations"}

  get 'home/index'

  root 'home#index'

  resources :users
  resources :tournaments

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
