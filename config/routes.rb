Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :dashboard, only: [:index]
      get '/users/me', to: 'users#me'
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      # resources :categories do
      #   get 'transactions', on: :member
      # end
      resources :cost_centers, only: [:index, :show, :create, :update, :destroy]
      resources :accounts, only: [:index, :show, :create, :update, :destroy]
      # resources :accounts do
      #   get 'transactions', on: :member
      # end
      resources :cards, only: [:index, :show, :create, :update, :destroy]
      get '/reminders/summary', to: 'reminders#summary'
      resources :reminders, only: [:index, :show, :create, :update, :destroy]
      resources :transactions, only: [:index, :show, :create, :update, :destroy] do
        collection do
          post :create_bulk
        end
      end
      resources :goals, only: [:index, :show, :create, :update, :destroy]
      post '/auth/login', to: 'authentication#login'
      get '/*a', to: 'application#not_found'
    end
  end
end
