Rails.application.routes.draw do
  get 'home/index'

  get 'static_pages/home'

  root 'home#index'

  devise_for :users, controllers: { session: 'users/sessions', :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items
  resources :users
  get 'admin/users' => 'admin#users_index'
  get 'admin/items' => 'admin#items_index'
  post 'admin/items/approve' => 'admin#approve_item'
  post 'admin/items/unapprove' => 'admin#unapprove_item'

end
	