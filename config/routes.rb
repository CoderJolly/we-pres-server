Rails.application.routes.draw do
  get 'pages/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#index'

  namespace :api do
    namespace :v1 do
      # user auth routes
      post 'users/create', to: 'users#new_user', as: 'create_user'
      patch 'users/update', to: 'users#update_user', as: 'update_user'
      get 'users/', to: 'users#user', as: 'get_user'
      put 'users/update', to: 'users#update_user'
      post 'users/sign_in', to: 'users#sign_in', as: 'sign_in'
      delete 'users/sign_out', to: 'users#sign_out', as: 'sign_out'
      delete 'users/destroy', to: 'users#destroy_user', as: 'delete_user'

      # resources
      get 'src', to: 'storage#index', as: 'src'
    end
  end
end
