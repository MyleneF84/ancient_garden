Rails.application.routes.draw do
  namespace :admins do
    resources :categories
  end
  # get 'admins/home'
  devise_for :admins

  authenticated :admin do
    root to: "admins#home", as: :admins_root
  end

  get "admins", to: "admins#home"
  root to: "pages#home"

end
