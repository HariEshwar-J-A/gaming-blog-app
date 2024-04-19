Rails.application.routes.draw do
  # Devise routes for regular web and API user authentication
  devise_for :users

  # Root of the site directed to posts index page for the web interface
  root to: 'posts#index'

  # Regular web application routes for posts and comments
  resources :posts do
    resources :comments, only: [:create, :destroy] # Adjust based on your actual web app needs
  end
  resources :categories, only: [:index, :show] # Web interface for viewing categories

  # User profile route, assuming you have a UserController handling these
  resource :user_profile, only: [:show, :edit, :update]

  # API namespace setup for version 1
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Devise routes for API
      # devise_for :users, skip: :all  # Skip devise routes inside API as we define custom endpoints below
      # post 'signup', to: 'registrations#create'
      # post 'login', to: 'sessions#create'
      # delete 'logout', to: 'sessions#destroy'

      # Custom Devise routes
      devise_scope :user do
        post 'signup', to: 'registrations#create', as: :user_registration
        post 'login', to: 'sessions#create', as: :user_session
        delete 'logout', to: 'sessions#destroy', as: :destroy_user_session
      end

      # API resources
      resources :posts, only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:create, :destroy], shallow: true
      end
      resources :categories, only: [:index, :show]
    end
  end
end
