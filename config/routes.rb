Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root "homes#top"
  resources :posts, only: %i[new index show edit update create destroy]
  resources :users, only: %i[index show edit]
end
