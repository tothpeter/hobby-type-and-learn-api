require 'api_constraints'

Rails.application.routes.draw do
  # root 'welcome#index'

  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :sessions, :only => [:create, :destroy]
      
      get :current_user, to: 'users#logged_in_user'

      resources :labels, only: [:create, :update, :destroy]
      resources :cards, only: [:index, :create, :update]
    end
  end
end
