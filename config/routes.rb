Rails.application.routes.draw do
  # get 'admins/home'
  devise_for :admins

  authenticated :admin do
    root to: "admins#home", as: :admins_root
  end

  get "admins", to: "admins#home"
  root to: "pages#home"

end
