Rails.application.routes.draw do

  devise_for :users 

  resources :users do
    resources :trips, shallow: true
  end

  resources :destinations
  root to: "welcome#index"

end
