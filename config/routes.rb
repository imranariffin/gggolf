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
  get 'sitemap', to: 'home#sitemap'
  get 'tournament/:id', to: 'tournaments#tournament'
  
  #contact other players
 # get 'contact_players', to: 'contact_players#new', as: 'contact_players'
  #post 'contact_players', to: 'contact_players#create'
  

  resources :users do
    resources :contact_players , only: [:new, :create]
  end
  
  resources :tournaments do
    resources :teams
    resources :tournament_registrations do
      collection do
        post 'spectator'
      end
    end
    resources :sponsors
    resources :check_in
    
    get 'checkout/registration', to: 'check_out#registration', as: 'registration_checkout'
    get 'checkout/spectator', to: 'check_out#spectator', as: 'spectator_checkout'
    get 'checkout/sponsor', to: 'check_out#sponsor', as: 'sponsor_checkout'
    member do
      delete 'quit', to: 'tournament_registrations#destroy', as: :quit
      get 'sponsor'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
