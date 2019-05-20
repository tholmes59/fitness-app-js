Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#home'
  get '/signup', to: 'user#new'
  post '/signup', to: 'user#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  get '/auth/facebook/callback', to: 'sessions#create'

  resources :users

end
