Rails.application.routes.draw do
  get 'usage/index'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root "homes#top"
  get 'usage', to: 'usage#usage'
  get '/search', to: 'searchs#search'
  resources :posts
  resources :users, only: %i[index show edit]
  resources :genres, only: %i[index show create update destroy edit] do
   member do        # memberの場合
     get 'month'
     get 'week'
   end
  end
  get '/meals/day', to: 'meals#day'
  resources :meals
  resources :cookings do
    resource :favorites, only: [:create, :destroy]
  end
  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'
end
