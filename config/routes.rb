Rails.application.routes.draw do
  

  resources :friendships
  # Routing logic: fallback requests for React Router.
  # Leave this here to help deploy your app later!


  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }

  # get '/courses', to: 'courses#render_courses'

  post '/signup', to: 'users#create'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  get '/me', to: 'users#show'



  resources :reviews
  resources :courses, only: [:index, :show, :create, :update]
  resources :users, except: [:create]





end




