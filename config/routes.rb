Rails.application.routes.draw do

  devise_for :users
  resources :trips

  root to: "welcome#index"

end
