Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration"
  end
  devise_for :users, :controllers => {:registrations => "user_registrations"}

  get 'home/index'

  root 'home#index'

  get 'about', to: 'home#about', as: :about
 # get 'contact', to: 'home#contact', as: :contact
  get 'contact', to: 'contactforms#new', as: 'contact'
  post 'contact', to: 'contactforms#create'
  get 'faq', to: 'home#faq'
  get 'tos', to: 'home#tos'
  get 'privacy', to: 'home#privacy'
  get 'tournament/:id', to: 'tournaments#tournament'

  resources :users
  resources :tournaments do
    resources :teams
    resources :tournament_registrations
    member do
      delete 'quit', to: 'tournament_registrations#destroy', as: :quit
      post 'sponsor'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
