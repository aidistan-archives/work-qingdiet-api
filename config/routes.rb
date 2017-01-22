Rails.application.routes.draw do
  namespace :v1 do
    namespace :login do
      get  'oauth/authorize'
      post 'oauth/authorize'
      post 'oauth/access_token'
    end

    resources :users, except: [:create, :destroy]
    resources :addresses
    resources :measurements
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
