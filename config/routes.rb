Rails.application.routes.draw do
  namespace :v1 do
    namespace :login do
      get  'oauth/authorize'
      post 'oauth/authorize'
      post 'oauth/access_token'
      post 'weixin/access_token'
    end

    resources :users, except: %i[create destroy]
    resources :addresses
    resources :measurements
    resources :requirements
    # resources :acquirements # TODO: calculate the nutrition acquirement of a combo

    resources :dishes
    resources :orders
    resources :combos, except: %i[update]
  end
end
