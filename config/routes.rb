Rails.application.routes.draw do
  
  get 'bottles/new'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'

  root 'static_pages#home'
  
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/locale',  to: 'static_pages#locale'
  get  '/signup',  to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get  'oauth2callback'    => 'sessions#create_google'
  get  'google'            => 'sessions#googleauth'
  post 'documents/getdata' => 'documents#getdata'

  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :bottles
end
