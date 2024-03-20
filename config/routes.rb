Rails.application.routes.draw do
  # namespace :admin do
  #   resources :stocks
  # end
  devise_for :admins

  authenticated :admin do
    root to: "admins#home", as: :admins_root
  end

  get "admins", to: "admins#home"

  root to: "pages#home"

  namespace :admins do
    resources :categories
    resources :products
  end

  namespace :admins do
    resources :products do
    resources :stocks
    end
  end
end
