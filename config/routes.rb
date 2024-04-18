Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  get 'checkouts/create'

  # authenticated :admin do
  #   root to: "admins#home", as: :admins_root
  # end

  get "admins", to: "admins#home"

  root to: "pages#home"


  namespace :admins do
    root to: "admins#home", as: :root
    resources :orders
    resources :products do
      member do
        delete :delete_image_attachement
      end
      resources :stocks
    end
    resources :categories
  end

  resources :orders, only: %i[new create show index]
  resources :categories, only: %i[show index]
  resources :products, only: :show

  get "profile", to: "users#profile"
  patch "profile", to: "users#update"

  get "cart", to: "carts#show"
  post "orders/checkout", to: "orders#create"
  get "success", to: "checkouts#success"
  get "recap", to: "checkouts#recap"

end
