Rails.application.routes.draw do

  resources :attractions

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root to: "welcome#index"
  
  resources :destinations

  resources :users do
    resources :trips, shallow: true
  end

  resources :trips, only: [:index, :show]
end
