Rails.application.routes.draw do
  devise_for :users
  root "homes#top"
  resources :posts
  resources :users, only: %i[index show edit]
  resources :genres, only: %i[index show create update destroy edit]
  get '/meals/day', to: 'meals#day'
  resources :meals
  resources :cookings do
    resources :favorites, only: [:create, :destroy, :index ,:show]
  end
end
