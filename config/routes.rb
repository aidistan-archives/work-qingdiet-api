Rails.application.routes.draw do
  namespace :v1 do
    namespace :oauth do
      get  'login'
      get  'authorize'
      post 'access_token'
    end

    resources :users, only: [:show, :update, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
