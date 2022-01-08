Rails.application.routes.draw do
  devise_for :users
  root "homes#top"
  resources :posts, only: %i[new index show edit update create destroy]
  resources :users, only: %i[index show edit]
  resources :genres, only: %i[index show create destroy edit]
  resources :meals
end
