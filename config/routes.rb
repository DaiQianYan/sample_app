Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'

  # get 'static_pages/home'
  # get '/home', to: 'static_pages#home'

  # get 'static_pages/help'
  get '/help', to: 'static_pages#help' # , as: 'halp'

  # get 'static_pages/about'
  get '/about', to: 'static_pages#about'

  # get 'static_pages/contact'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'
  # Adding a resource to get the standard RESTful actions for sessions.
  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :users
  
  # Adding a route for the Account Activations edit action.
  resources :account_activations, only: [:edit]

  # Adding a resource for password resets.
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  # root 'application#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
