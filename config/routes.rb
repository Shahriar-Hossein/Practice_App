Rails.application.routes.draw do
  devise_for :users, :controllers =>
    {
      registrations: 'users/registrations'

    }
  #resources :posts

  root 'pages#index'
  get 'pages/index'

  resources :posts do
    resources :comments
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
