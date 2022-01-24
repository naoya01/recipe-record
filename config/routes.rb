Rails.application.routes.draw do
  devise_for :users
  root "homes#top"
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
