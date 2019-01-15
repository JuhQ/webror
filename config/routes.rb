Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beerclubs

  resources :users do
    get 'close', on: :member
    get 'unclose', on: :member
  end

  resources :beers

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'breweries#index'

  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'

  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  get 'places', to: 'places#index'
  post 'places', to:'places#search'

  get 'beerlist', to:'beers#list'

end
