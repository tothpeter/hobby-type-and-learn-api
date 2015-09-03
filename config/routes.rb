require 'api_constraints'

Rails.application.routes.draw do
  # root 'welcome#index'

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :sessions, :only => [:create, :destroy]

      resources :labels, only: [:create, :update, :destroy]
      resources :cards, only: [:index, :create]
    end
  end
end
