Rails.application.routes.draw do

  get '/search', to: 'search#search'


  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
  get :search, on: :collection
  member do
  get :following, :followers
  end
  end

  resources :relationships, only: [:create, :destroy]
  resources :books do
  get :search, on: :collection
  resources  :book_comments, only: [:create, :destroy]
  resource  :favorites, only: [:create, :destroy]
  end
  root 'home#top'
  get 'home/about'

end