Rails.application.routes.draw do

  root 'home#index'


  devise_for :users, controllers: { session: 'users/sessions', :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items do 
    resources :comments
  end
  resources :comments
  resources :users
  resources :message_rooms
  resources :messages
  resources :notifications
  get 'search' => 'items#search'
  post 'filter' => 'items#filter'
  get 'admins/users' => 'admins#users_index'
  get 'admins/items' => 'admins#items_index'
  post 'admins/item/approve' => 'admins#approve_item'
  post 'admins/item/unapprove' => 'admins#unapprove_item'
  post 'rate' => 'items#rate'
  get 'get-item' => 'items#get_item'
end
	