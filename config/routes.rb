Rails.application.routes.draw do

  resources :attractions
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  post 'attractions/:id', to: 'attractions#set_trip'
  root to: "welcome#index"
  resources :destinations

  resources :users do
    resources :trips, shallow: true
  end

end
