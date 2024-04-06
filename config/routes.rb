Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts do
    resources :comments, only: [:create], shallow: true
  end
  resources :comments, only: [] do
    get 'delete', on: :member
  end

  resources :categories, only: [:index, :show]
  resource :user_profile, only: [:show, :edit, :update]
end
