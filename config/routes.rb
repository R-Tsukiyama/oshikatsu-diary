Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get 'home/index'
  get 'users/mypage', to: 'users#mypage'
  get 'users/:user_id', to: 'users#show', as: 'user_show'
  get 'users/show', to: 'users#show'
  get 'users/show/edit', to: 'users#edit'
  resources :users, only: [:edit, :update, :mypage, :show]
  devise_scope :user do
    post 'users/sign_out', to: 'devise/sessions#destroy'
  end
  get 'posts/new', to: 'posts#new'
  post 'posts/new', to: 'posts#index'
  get 'posts/index', to: 'posts#index'
  get 'posts/edit', to: 'posts#edit'
  get 'posts/:id', to: 'posts#show', as: 'posts_show'
  get 'posts/show', to: 'posts#show'
  resources :posts, except: [:show]
  resources :posts do
    collection do
      get 'index'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
