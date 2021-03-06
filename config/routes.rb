Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  root 'welcome#index'

  resources :products do
    resources :reviews
  end

  resources :reviews do
      resources :likes
  end

  resources :tags, only: [:show,:index]


  resources :users, only: [:new, :create]

  resources :review, only: [], shallow:true do
    resources :votes, only: [:create, :destroy,:update]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  # resource :sessions, only: [:new, :create, :destroy]


  get('/',{to: 'welcome#index', as: 'home'})
  get('/about', { to: 'welcome#about'})


  get('/contact', {to: 'contact#new'})
  post('/contact', {to: 'contact#create'})


  namespace :admin do
    resources :dashboard, only: [:index]
  end






end
