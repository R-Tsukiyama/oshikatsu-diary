Rails.application.routes.draw do
  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
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
  post 'posts/new', to: 'posts#new'
  post 'posts/index', to: "posts#index"
  get 'posts/index', to: 'posts#index'
  get 'posts/:post_id/edit', to: 'posts#edit', as: 'posts_edit'
  get 'posts/:post_id', to: 'posts#show', as: 'posts_show'
  resources :posts
  resources :posts do
    collection do
      get 'index'
    end
  end
  resources :posts do
    member do
      delete 'destroy_image/:image_id', to: 'posts#destroy_image', as: 'destroy_image'
    end
  end
  get 'search_by_tag', to: 'posts#search_by_tag', as: 'search_by_tag'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
