Rails.application.routes.draw do

  devise_for :users 

  resources :users do
    resources :trips
  end


  resources :trips
  resources :destinations

  root to: "welcome#index"

end
