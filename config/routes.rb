Rails.application.routes.draw do
  # resources :articles, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :articles
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
end
