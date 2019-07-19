Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/auth/facebook/callback', to: 'sessions#facebook'

  get '/auth/github/callback', to: 'sessions#github'

  resources :users
  resources :workouts

  resources :users, only: [:show] do
    resources :workouts, only: [:index]
  end

  resources :workouts, only: [:show] do 
    resources :reviews, only: [:new, :create, :index]
  end

  root 'static#home'
  get '/home', to: 'welcome#home'

  get 'workout/longest', to: 'workouts#longest'
end
