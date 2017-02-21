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
    resources :requirements
    # resources :acquirements # TODO: calculate the nutrition acquirement of a combo

    resources :dishes
    resources :orders
    resources :combos, except: [:update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
