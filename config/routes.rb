Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get 'home/index'
  get 'users/mypage', to: 'users#mypage'
  get 'users/:user_id', to: 'users#show', as: 'user_show'
  get 'users/show', to: 'users#show'
  get 'users/show/edit', to: 'users#edit'
  get 'posts/new', to: 'posts#new'
  resources :users, only: [:edit, :update, :mypage,:show]
  devise_scope :user do
  get 'users/sign_out' => 'devise/sessions#destroy'
  end
  post 'users/:id/edit' => 'users#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
