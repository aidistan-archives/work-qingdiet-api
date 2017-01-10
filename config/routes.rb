Rails.application.routes.draw do
  namespace :v1 do
    namespace :login do
      get  'oauth/authorize'
      post 'oauth/access_token'
    end

    resources :users, only: [:show, :update, :destroy] do
      resources :addresses
      resources :measurements, except: :update
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
