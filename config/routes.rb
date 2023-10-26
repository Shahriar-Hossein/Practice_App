# app/config/routes.rb
Rails.application.routes.draw do

  root 'posts#index'
  # get 'pages/index'

  devise_for  :users,
              :controllers =>
              {
                registrations: 'users/registrations'
              }

    # get 'user/profile', to: 'users/registrations#show'
  devise_scope :user do
    get 'profile', to: 'users/registrations#show'
  end
  # resource :users, only: [:show]
  # resources :posts

  resources :posts do
    resources :comments
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
